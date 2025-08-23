// lib/services/status_service.dart
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/status/status_effect.dart';

/// 狀態效果結果
class StatusEffectResult {
  final int dotDamage;
  final int hotHealing;
  final List<String> triggeredEffects;

  const StatusEffectResult({
    required this.dotDamage,
    required this.hotHealing,
    required this.triggeredEffects,
  });

  static const StatusEffectResult empty = StatusEffectResult(
    dotDamage: 0,
    hotHealing: 0,
    triggeredEffects: [],
  );
}

/// 狀態效果應用結果
class StatusApplicationResult {
  final StatusEffectManager statusManager;
  final bool success;
  final String message;

  const StatusApplicationResult({
    required this.statusManager,
    required this.success,
    required this.message,
  });
}

/// 狀態服務
///
/// 遵循 Single Responsibility Principle：
/// 專門負責狀態效果的處理邏輯
class StatusService {
  /// 狀態模板緩存
  static Map<String, StatusTemplate>? _statusTemplateCache;

  /// 處理回合開始時的狀態效果
  StatusEffectResult processTurnStart(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  }) {
    final result = statusManager.processTurnStart();
    return _convertToStatusEffectResult(result);
  }

  /// 處理回合結束時的狀態效果
  StatusEffectResult processTurnEnd(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  }) {
    print("處理回合結束時的狀態效果");
    final result = statusManager.processTurnEnd();
    return _convertToStatusEffectResult(result);
  }

  /// 清理戰鬥結束時的狀態效果
  void clearBattleEndEffects(StatusEffectManager statusManager) {
    statusManager.clearBattleEndEffects();
  }

  /// 添加狀態效果
  void addStatusEffect(
    StatusEffectManager statusManager,
    StatusTemplate template, {
    int? customDuration,
    int stacks = 1,
  }) {
    statusManager.addStatusEffect(
      template,
      customDuration: customDuration,
      stacks: stacks,
    );
  }

  /// 移除狀態效果
  bool removeStatusEffect(StatusEffectManager statusManager, String statusId) {
    return statusManager.removeStatusEffect(statusId);
  }

  /// 引爆狀態效果
  int detonateStatus(StatusEffectManager statusManager, String statusId) {
    return statusManager.detonateStatus(statusId);
  }

  /// 應用狀態效果到狀態管理器
  Future<StatusApplicationResult> applyStatusEffect(
    StatusEffectManager statusManager,
    String statusId, {
    required bool isPlayer,
    int? customDuration,
    int stacks = 1,
  }) async {
    // 確保狀態模板已載入
    await _ensureTemplatesLoaded();

    // 載入狀態效果模板
    final template = _getStatusTemplate(statusId);
    if (template == null) {
      return StatusApplicationResult(
        statusManager: statusManager,
        success: false,
        message: '狀態效果不存在：$statusId',
      );
    }

    // 創建新的狀態管理器實例
    final newManager = _copyStatusManager(statusManager);

    // 添加狀態效果
    newManager.addStatusEffect(
      template,
      customDuration: customDuration,
      stacks: stacks,
    );

    return StatusApplicationResult(
      statusManager: newManager,
      success: true,
      message: '成功應用狀態效果：${template.name}',
    );
  }

  /// 處理技能觸發的狀態效果
  StatusEffectResult processSkillTriggeredEffects(
    StatusEffectManager statusManager,
    StatusTrigger trigger, {
    Map<String, dynamic>? context,
  }) {
    int totalDotDamage = 0;
    int totalHotHealing = 0;
    int vampireHealing = 0;
    final List<String> triggeredEffects = [];

    for (final effect in statusManager.activeEffects) {
      if (effect.triggers.contains(trigger)) {
        triggeredEffects.add(effect.name);

        switch (trigger) {
          case StatusTrigger.onAttack:
            // 處理攻擊時觸發的效果
            if (effect.id == 'vampire_heal' && context != null) {
              final damageDealt = context['damageDealt'] as int? ?? 0;
              vampireHealing += (damageDealt * 0.5).round();
            }
            break;

          case StatusTrigger.onDamaged:
            // 處理受傷時觸發的效果
            break;

          case StatusTrigger.turnStart:
          case StatusTrigger.turnEnd:
            totalDotDamage += effect.dotDamage;
            totalHotHealing += effect.hotHealing;
            break;

          default:
            break;
        }
      }
    }

    return StatusEffectResult(
      dotDamage: totalDotDamage,
      hotHealing: totalHotHealing + vampireHealing,
      triggeredEffects: triggeredEffects,
    );
  }

  /// 獲取所有可用的狀態效果ID
  List<String> getAvailableStatusEffects() {
    return _statusTemplateCache?.keys.toList() ?? [];
  }

  /// 轉換狀態管理器結果為服務結果
  StatusEffectResult _convertToStatusEffectResult(Map<String, dynamic> result) {
    return StatusEffectResult(
      dotDamage: result['dotDamage'] as int? ?? 0,
      hotHealing: result['hotHealing'] as int? ?? 0,
      triggeredEffects: List<String>.from(result['triggeredEffects'] ?? []),
    );
  }

  /// 複製狀態管理器
  StatusEffectManager _copyStatusManager(StatusEffectManager original) {
    final newManager = StatusEffectManager();

    // 複製所有活躍狀態 - 需要在 StatusEffectManager 中添加公開方法
    for (final effect in original.activeEffects) {
      // 使用 StatusEffectManager 的 addStatusEffect 方法重新添加狀態
      // 這是一個臨時解決方案，更好的方式是在 StatusEffectManager 中添加 copy 方法
      newManager.addStatusEffect(
        StatusTemplate(
          id: effect.id,
          name: effect.name,
          description: effect.description,
          type: effect.type,
          baseDuration: effect.maxDuration,
          maxStacks: effect.maxStacks,
          isStackable: effect.isStackable,
          isRefreshable: effect.isRefreshable,
          isDispellable: effect.isDispellable,
          isRemovable: effect.isRemovable,
          isDetonable: effect.isDetonable,
          scope: effect.scope,
          attributePerStack: effect.attributeModifiers.map(
            (key, value) => MapEntry(key, value / effect.currentStacks),
          ),
          dotDamagePerStack: effect.currentStacks > 0
              ? effect.dotDamage ~/ effect.currentStacks
              : 0,
          hotHealingPerStack: effect.currentStacks > 0
              ? effect.hotHealing ~/ effect.currentStacks
              : 0,
          detonationMultiplier: effect.detonationMultiplier,
          triggers: effect.triggers,
          color: effect.color,
          iconPath: effect.iconPath,
        ),
        customDuration: effect.currentDuration,
        stacks: effect.currentStacks,
      );
    }

    return newManager;
  }

  // ===== 靜態方法 =====

  /// 載入狀態效果模板配置
  static Future<void> loadStatusTemplates() async {
    if (_statusTemplateCache != null) return; // 已載入過

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/status_templates.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      _statusTemplateCache = {};
      jsonData.forEach((key, value) {
        final template = _parseStatusTemplate(value);
        if (template != null) {
          _statusTemplateCache![key] = template;
        }
      });
    } catch (e) {
      print('載入狀態模板失敗: $e');
      _statusTemplateCache = {}; // 設為空 Map 避免重複載入
    }
  }

  /// 確保狀態模板已載入
  static Future<void> _ensureTemplatesLoaded() async {
    if (_statusTemplateCache == null) {
      await loadStatusTemplates();
    }
  }

  /// 獲取狀態效果模板
  static StatusTemplate? _getStatusTemplate(String statusId) {
    return _statusTemplateCache?[statusId];
  }

  /// 解析 JSON 為 StatusTemplate
  static StatusTemplate? _parseStatusTemplate(Map<String, dynamic> json) {
    try {
      // 解析 StatusType
      final typeString = json['type'] as String;
      final type = _parseStatusType(typeString);
      if (type == null) return null;

      // 解析 StatusScope
      final scopeString = json['scope'] as String? ?? 'battle_only';
      final scope = _parseStatusScope(scopeString);

      // 解析 AttributeType 映射
      final attributePerStackJson =
          json['attributePerStack'] as Map<String, dynamic>? ?? {};
      final attributePerStack = <AttributeType, double>{};

      attributePerStackJson.forEach((key, value) {
        final attributeType = _parseAttributeType(key);
        if (attributeType != null && value is num) {
          // 將小數形式轉換為百分比形式 (例如 -0.1 -> -10.0)
          attributePerStack[attributeType] = (value.toDouble() * 100);
        }
      });

      // 解析觸發器列表
      final triggersJson = json['triggers'] as List<dynamic>? ?? [];
      final triggers = <StatusTrigger>[];

      for (final triggerString in triggersJson) {
        final trigger = _parseStatusTrigger(triggerString as String);
        if (trigger != null) {
          triggers.add(trigger);
        }
      }

      return StatusTemplate(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        type: type,
        baseDuration: json['baseDuration'] as int,
        maxStacks: json['maxStacks'] as int,
        isStackable: json['isStackable'] as bool? ?? true,
        isRefreshable: json['isRefreshable'] as bool? ?? true,
        isDispellable: json['isDispellable'] as bool? ?? true,
        isRemovable: json['isRemovable'] as bool? ?? true,
        isDetonable: json['isDetonable'] as bool? ?? false,
        scope: scope,
        attributePerStack: attributePerStack,
        dotDamagePerStack: json['dotDamagePerStack'] as int? ?? 0,
        hotHealingPerStack: json['hotHealingPerStack'] as int? ?? 0,
        detonationMultiplier:
            (json['detonationMultiplier'] as num?)?.toDouble() ?? 0.0,
        triggers: triggers,
        color: json['color'] as String? ?? '#FFFFFF',
        iconPath: json['iconPath'] as String? ?? '',
      );
    } catch (e) {
      print('解析狀態模板失敗: $e');
      return null;
    }
  }

  /// 解析 StatusType
  static StatusType? _parseStatusType(String typeString) {
    switch (typeString) {
      case 'buff':
        return StatusType.buff;
      case 'debuff':
        return StatusType.debuff;
      case 'dot':
        return StatusType.dot;
      case 'hot':
        return StatusType.hot;
      case 'special':
        return StatusType.special;
      default:
        return null;
    }
  }

  /// 解析 StatusScope
  static StatusScope _parseStatusScope(String scopeString) {
    switch (scopeString) {
      case 'battle_only':
        return StatusScope.battleOnly;
      case 'global':
        return StatusScope.global;
      default:
        return StatusScope.battleOnly;
    }
  }

  /// 解析 AttributeType
  static AttributeType? _parseAttributeType(String attributeString) {
    switch (attributeString) {
      case 'attack':
        return AttributeType.attack;
      case 'defense':
        return AttributeType.defense;
      case 'speed':
        return AttributeType.speed;
      case 'hp':
        return AttributeType.hp;
      case 'crit_rate':
        return AttributeType.critRate;
      case 'crit_damage':
        return AttributeType.critDamage;
      default:
        return null;
    }
  }

  /// 解析 StatusTrigger
  static StatusTrigger? _parseStatusTrigger(String triggerString) {
    switch (triggerString) {
      case 'turn_start':
        return StatusTrigger.turnStart;
      case 'turn_end':
        return StatusTrigger.turnEnd;
      case 'on_attack':
        return StatusTrigger.onAttack;
      case 'on_damaged':
        return StatusTrigger.onDamaged;
      case 'on_healed':
        return StatusTrigger.onHealed;
      case 'on_death':
        return StatusTrigger.onDeath;
      default:
        return null;
    }
  }
}
