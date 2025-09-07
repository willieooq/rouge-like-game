// lib/services/status_service_impl.dart
import '../core/interfaces/i_status_service.dart';
import '../models/status/status_effect.dart';
import '../shared/beans/status/status_application_result.dart';
import '../shared/beans/status/status_effect_result.dart';
import '../shared/beans/status/status_trigger_context.dart';

/// 狀態效果服務實現
///
/// 遵循 Single Responsibility Principle：
/// 專門負責狀態效果的處理邏輯
///
/// 遵循 Dependency Inversion Principle：
/// 實現 IStatusService 抽象接口
class StatusServiceImpl implements IStatusService {
  /// 狀態模板緩存
  static Map<String, StatusTemplate>? _statusTemplateCache;

  @override
  bool get isTemplatesLoaded => _statusTemplateCache != null;

  @override
  StatusEffectResult processTurnStart(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  }) {
    final result = statusManager.processTurnStart();
    return _convertToStatusEffectResult(result);
  }

  @override
  StatusEffectResult processTurnEnd(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  }) {
    print("處理回合結束時的狀態效果");
    final result = statusManager.processTurnEnd();
    return _convertToStatusEffectResult(result);
  }

  @override
  void clearBattleEndEffects(StatusEffectManager statusManager) {
    statusManager.clearBattleEndEffects();
  }

  @override
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

  @override
  bool removeStatusEffect(StatusEffectManager statusManager, String statusId) {
    return statusManager.removeStatusEffect(statusId);
  }

  @override
  int detonateStatus(StatusEffectManager statusManager, String statusId) {
    return statusManager.detonateStatus(statusId);
  }

  @override
  Future<StatusApplicationResult> applyStatusEffect(
    StatusEffectManager statusManager,
    String statusId, {
    required bool isPlayer,
    int? customDuration,
    int stacks = 1,
  }) async {
    // 載入狀態效果模板
    final template = getStatusTemplate(statusId);
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

  @override
  StatusEffectResult processSkillTriggeredEffects(
    StatusEffectManager statusManager,
    StatusTrigger trigger, {
    StatusTriggerContext? context,
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
            if (effect.id == 'vampire_heal' && context?.damageDealt != null) {
              vampireHealing += (context!.damageDealt! * 0.5).round();
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

  @override
  List<String> getAvailableStatusEffects() {
    return _statusTemplateCache?.keys.toList() ?? [];
  }

  @override
  StatusTemplate? getStatusTemplate(String statusId) {
    return _statusTemplateCache?[statusId];
  }

  // ===== 靜態輔助方法（供初始化服務使用） =====

  /// 設置狀態模板緩存（供初始化服務使用）
  static void setStatusTemplateCache(Map<String, dynamic> jsonData) {
    _statusTemplateCache = {};
    jsonData.forEach((key, value) {
      final template = _parseStatusTemplateStatic(value);
      if (template != null) {
        _statusTemplateCache![key] = template;
      }
    });
  }

  /// 靜態解析方法（供初始化服務使用）
  static StatusTemplate? _parseStatusTemplateStatic(Map<String, dynamic> json) {
    try {
      // 解析 StatusType
      final typeString = json['type'] as String;
      final type = _parseStatusTypeStatic(typeString);
      if (type == null) return null;

      // 解析 StatusScope
      final scopeString = json['scope'] as String? ?? 'battle_only';
      final scope = _parseStatusScopeStatic(scopeString);

      // 解析 AttributeType 映射
      final attributePerStackJson =
          json['attributePerStack'] as Map<String, dynamic>? ?? {};
      final attributePerStack = <AttributeType, double>{};

      attributePerStackJson.forEach((key, value) {
        final attributeType = _parseAttributeTypeStatic(key);
        if (attributeType != null && value is num) {
          attributePerStack[attributeType] = (value.toDouble() * 100);
        }
      });

      // 解析觸發器列表
      final triggersJson = json['triggers'] as List<dynamic>? ?? [];
      final triggers = <StatusTrigger>[];

      for (final triggerString in triggersJson) {
        final trigger = _parseStatusTriggerStatic(triggerString as String);
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

  // 靜態解析方法
  static StatusType? _parseStatusTypeStatic(String typeString) {
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

  static StatusScope _parseStatusScopeStatic(String scopeString) {
    switch (scopeString) {
      case 'battle_only':
        return StatusScope.battleOnly;
      case 'global':
        return StatusScope.global;
      default:
        return StatusScope.battleOnly;
    }
  }

  static AttributeType? _parseAttributeTypeStatic(String attributeString) {
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

  static StatusTrigger? _parseStatusTriggerStatic(String triggerString) {
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

  // ===== 私有輔助方法 =====

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

    // 複製所有活躍狀態
    for (final effect in original.activeEffects) {
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
}
