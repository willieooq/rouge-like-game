// lib/models/status/status_effect.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_effect.freezed.dart';
part 'status_effect.g.dart';

/// 狀態作用域
enum StatusScope {
  @JsonValue('battle_only')
  battleOnly, // 僅戰鬥中
  @JsonValue('global')
  global, // 全局持續（跨戰鬥）
}

/// 狀態效果類型
enum StatusType {
  @JsonValue('buff')
  buff, // 增益
  @JsonValue('debuff')
  debuff, // 減益
  @JsonValue('dot')
  dot, // 持續傷害 (Damage Over Time)
  @JsonValue('hot')
  hot, // 持續治療 (Heal Over Time)
  @JsonValue('special')
  special, // 特殊效果
}

/// 狀態觸發時機
enum StatusTrigger {
  @JsonValue('turn_start')
  turnStart, // 回合開始
  @JsonValue('turn_end')
  turnEnd, // 回合結束
  @JsonValue('on_attack')
  onAttack, // 攻擊時
  @JsonValue('on_damaged')
  onDamaged, // 受傷時
  @JsonValue('on_healed')
  onHealed, // 被治療時
  @JsonValue('on_death')
  onDeath, // 死亡時
}

/// 屬性修正類型
enum AttributeType {
  @JsonValue('attack')
  attack, // 攻擊力
  @JsonValue('defense')
  defense, // 防禦力
  @JsonValue('speed')
  speed, // 速度
  @JsonValue('hp')
  hp, // 生命值
  @JsonValue('crit_rate')
  critRate, // 暴擊率
  @JsonValue('crit_damage')
  critDamage, // 暴擊傷害
}

/// 狀態效果實例
@freezed
abstract class StatusEffect with _$StatusEffect {
  const factory StatusEffect({
    required String id, // 狀態ID（唯一）
    required String name, // 狀態名稱
    required String description, // 狀態描述
    required StatusType type, // 狀態類型
    required int maxDuration, // 最大持續回合數
    required int currentDuration, // 當前剩餘回合數
    required int maxStacks, // 最大層數
    required int currentStacks, // 當前層數
    @Default(false) bool isStackable, // 是否可累積層數
    @Default(false) bool isRefreshable, // 是否可重新計時
    @Default(false) bool isDispellable, // 是否可驅散
    @Default(true) bool isRemovable, // 是否可消除（時間到期自然消失）
    @Default(false) bool isDetonable, // 是否可引爆
    @Default(StatusScope.battleOnly) StatusScope scope, // 狀態作用域
    // 效果數值
    required Map<AttributeType, double> attributeModifiers, // 屬性修正值
    @Default(0) int dotDamage, // DOT傷害（每回合）
    @Default(0) int hotHealing, // HOT治療（每回合）
    @Default(0) double detonationMultiplier, // 引爆倍率
    // 觸發條件
    @Default([]) List<StatusTrigger> triggers,

    // 視覺效果
    @Default('#FFFFFF') String color, // 狀態顏色
    @Default('') String iconPath, // 圖標路徑
  }) = _StatusEffect;

  factory StatusEffect.fromJson(Map<String, dynamic> json) =>
      _$StatusEffectFromJson(json);
}

/// 狀態效果模板（用於創建狀態實例）
@freezed
abstract class StatusTemplate with _$StatusTemplate {
  const factory StatusTemplate({
    required String id,
    required String name,
    required String description,
    required StatusType type,
    required int baseDuration, // 基礎持續時間
    required int maxStacks,
    @Default(true) bool isStackable,
    @Default(true) bool isRefreshable,
    @Default(true) bool isDispellable,
    @Default(true) bool isRemovable, // 是否可消除
    @Default(false) bool isDetonable,
    @Default(StatusScope.battleOnly) StatusScope scope, // 狀態作用域
    // 每層效果數值
    required Map<AttributeType, double> attributePerStack,
    @Default(0) int dotDamagePerStack,
    @Default(0) int hotHealingPerStack,
    @Default(1.0) double detonationMultiplier,

    @Default([]) List<StatusTrigger> triggers,
    @Default('#FFFFFF') String color,
    @Default('') String iconPath,
  }) = _StatusTemplate;

  factory StatusTemplate.fromJson(Map<String, dynamic> json) =>
      _$StatusTemplateFromJson(json);
}

/// 狀態效果管理器
class StatusEffectManager {
  final List<StatusEffect> _activeEffects = [];

  /// 獲取所有活躍狀態
  List<StatusEffect> get activeEffects => List.unmodifiable(_activeEffects);

  /// 添加狀態效果
  void addStatusEffect(
    StatusTemplate template, {
    int? customDuration,
    int stacks = 1,
  }) {
    final existingIndex = _activeEffects.indexWhere(
      (effect) => effect.id == template.id,
    );

    if (existingIndex != -1) {
      // 已存在相同狀態
      final existing = _activeEffects[existingIndex];

      if (template.isStackable) {
        // 可疊加：增加層數
        final newStacks = (existing.currentStacks + stacks).clamp(
          1,
          template.maxStacks,
        );

        if (template.isRefreshable) {
          // 可重新計時：重置持續時間
          _activeEffects[existingIndex] = existing.copyWith(
            currentStacks: newStacks,
            currentDuration: customDuration ?? template.baseDuration,
          );
        } else {
          // 不可重新計時：只增加層數
          _activeEffects[existingIndex] = existing.copyWith(
            currentStacks: newStacks,
          );
        }
      } else if (template.isRefreshable) {
        // 不可疊加但可重新計時：重置時間
        _activeEffects[existingIndex] = existing.copyWith(
          currentDuration: customDuration ?? template.baseDuration,
        );
      }
      // 不可疊加也不可重新計時：不做任何操作
    } else {
      // 新增狀態
      final statusEffect = _createStatusFromTemplate(
        template,
        customDuration,
        stacks,
      );
      _activeEffects.add(statusEffect);
    }
  }

  /// 移除狀態效果（檢查是否可移除）
  bool removeStatusEffect(String statusId) {
    final index = _activeEffects.indexWhere((effect) => effect.id == statusId);
    if (index == -1) return false;

    final effect = _activeEffects[index];
    if (!effect.isRemovable) {
      return false; // 不可移除的狀態
    }

    _activeEffects.removeAt(index);
    return true;
  }

  /// 強制移除狀態效果（忽略 isRemovable 限制）
  bool forceRemoveStatusEffect(String statusId) {
    final index = _activeEffects.indexWhere((effect) => effect.id == statusId);
    if (index == -1) return false;

    _activeEffects.removeAt(index);
    return true;
  }

  /// 減少指定狀態的層數
  void reduceStacks(String statusId, int stacksToReduce) {
    final index = _activeEffects.indexWhere((effect) => effect.id == statusId);
    if (index == -1) return;

    final effect = _activeEffects[index];
    final newStacks = effect.currentStacks - stacksToReduce;

    if (newStacks <= 0) {
      _activeEffects.removeAt(index);
    } else {
      _activeEffects[index] = effect.copyWith(currentStacks: newStacks);
    }
  }

  /// 引爆指定狀態（返回引爆傷害）
  int detonateStatus(String statusId) {
    final index = _activeEffects.indexWhere((effect) => effect.id == statusId);
    if (index == -1) return 0;

    final effect = _activeEffects[index];
    if (!effect.isDetonable) return 0;

    // 計算引爆傷害：層數 * DOT傷害 * 引爆倍率
    final detonationDamage =
        (effect.currentStacks * effect.dotDamage * effect.detonationMultiplier)
            .round();

    // 移除狀態
    _activeEffects.removeAt(index);

    return detonationDamage;
  }

  /// 處理回合開始的狀態效果
  Map<String, dynamic> processTurnStart() {
    return _processStatusTrigger(StatusTrigger.turnStart);
  }

  /// 處理回合結束的狀態效果
  Map<String, dynamic> processTurnEnd() {
    final result = _processStatusTrigger(StatusTrigger.turnEnd);

    // 減少所有狀態的持續時間，但只移除可移除的過期狀態
    final toRemove = <int>[];

    for (int i = 0; i < _activeEffects.length; i++) {
      final effect = _activeEffects[i];
      final newDuration = effect.currentDuration - 1;

      if (newDuration <= 0 && effect.isRemovable) {
        toRemove.add(i); // 標記為需要移除
      } else if (newDuration > 0) {
        // 更新持續時間（包括不可移除的狀態）
        _activeEffects[i] = effect.copyWith(currentDuration: newDuration);
      }
      // 不可移除且時間到期的狀態保持 currentDuration = 0，但不移除
    }

    // 從後往前移除，避免索引問題
    for (int i = toRemove.length - 1; i >= 0; i--) {
      _activeEffects.removeAt(toRemove[i]);
    }

    return result;
  }

  /// 計算屬性修正總值
  Map<AttributeType, double> calculateAttributeModifiers() {
    final Map<AttributeType, double> totalModifiers = {};

    for (final effect in _activeEffects) {
      for (final entry in effect.attributeModifiers.entries) {
        // 累積式計算：同類型修正相加
        totalModifiers[entry.key] =
            (totalModifiers[entry.key] ?? 0.0) +
            (entry.value * effect.currentStacks);
      }
    }

    return totalModifiers;
  }

  /// 獲取指定類型的狀態數量
  int getStatusCount(StatusType type) {
    return _activeEffects.where((effect) => effect.type == type).length;
  }

  /// 獲取指定ID的狀態
  StatusEffect? getStatusById(String statusId) {
    try {
      return _activeEffects.firstWhere((effect) => effect.id == statusId);
    } catch (e) {
      return null;
    }
  }

  /// 清除所有狀態
  void clearAllEffects() {
    _activeEffects.clear();
  }

  /// 清除指定類型的狀態
  void clearEffectsByType(StatusType type) {
    _activeEffects.removeWhere((effect) => effect.type == type);
  }

  /// 驅散可驅散的負面狀態
  int dispelDebuffs({int maxDispel = 1}) {
    int dispelled = 0;
    final toRemove = <int>[];

    for (int i = 0; i < _activeEffects.length && dispelled < maxDispel; i++) {
      final effect = _activeEffects[i];
      if (effect.type == StatusType.debuff &&
          effect.isDispellable &&
          effect.isRemovable) {
        toRemove.add(i);
        dispelled++;
      }
    }

    // 從後往前移除
    for (int i = toRemove.length - 1; i >= 0; i--) {
      _activeEffects.removeAt(toRemove[i]);
    }

    return dispelled;
  }

  /// 清除所有可移除的狀態
  void clearRemovableEffects() {
    _activeEffects.removeWhere((effect) => effect.isRemovable);
  }

  /// 清除指定類型的可移除狀態
  void clearRemovableEffectsByType(StatusType type) {
    _activeEffects.removeWhere(
      (effect) => effect.type == type && effect.isRemovable,
    );
  }

  /// 清除戰鬥結束時應該移除的狀態
  void clearBattleEndEffects() {
    _activeEffects.removeWhere(
      (effect) => effect.scope == StatusScope.battleOnly && effect.isRemovable,
    );
  }

  /// 獲取全局狀態列表
  List<StatusEffect> get globalEffects => _activeEffects
      .where((effect) => effect.scope == StatusScope.global)
      .toList();

  /// 獲取戰鬥狀態列表
  List<StatusEffect> get battleEffects => _activeEffects
      .where((effect) => effect.scope == StatusScope.battleOnly)
      .toList();

  // 私有方法
  StatusEffect _createStatusFromTemplate(
    StatusTemplate template,
    int? customDuration,
    int stacks,
  ) {
    return StatusEffect(
      id: template.id,
      name: template.name,
      description: template.description,
      type: template.type,
      maxDuration: customDuration ?? template.baseDuration,
      currentDuration: customDuration ?? template.baseDuration,
      maxStacks: template.maxStacks,
      currentStacks: stacks.clamp(1, template.maxStacks),
      isStackable: template.isStackable,
      isRefreshable: template.isRefreshable,
      isDispellable: template.isDispellable,
      isRemovable: template.isRemovable,
      isDetonable: template.isDetonable,
      scope: template.scope,
      attributeModifiers: _calculateAttributeModifiers(
        template.attributePerStack,
        stacks,
      ),
      dotDamage: template.dotDamagePerStack * stacks,
      hotHealing: template.hotHealingPerStack * stacks,
      detonationMultiplier: template.detonationMultiplier,
      triggers: template.triggers,
      color: template.color,
      iconPath: template.iconPath,
    );
  }

  Map<AttributeType, double> _calculateAttributeModifiers(
    Map<AttributeType, double> perStack,
    int stacks,
  ) {
    return perStack.map((key, value) => MapEntry(key, value * stacks));
  }

  Map<String, dynamic> _processStatusTrigger(StatusTrigger trigger) {
    int totalDotDamage = 0;
    int totalHotHealing = 0;
    final List<String> triggeredEffects = [];

    for (final effect in _activeEffects) {
      if (effect.triggers.contains(trigger)) {
        triggeredEffects.add(effect.name);

        if (trigger == StatusTrigger.turnStart ||
            trigger == StatusTrigger.turnEnd) {
          totalDotDamage += effect.dotDamage;
          totalHotHealing += effect.hotHealing;
        }
      }
    }

    return {
      'dotDamage': totalDotDamage,
      'hotHealing': totalHotHealing,
      'triggeredEffects': triggeredEffects,
    };
  }
}
