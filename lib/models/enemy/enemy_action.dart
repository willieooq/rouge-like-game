// lib/models/battle/enemy_action.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'enemy_action.freezed.dart';

/// 敵人行動類型
enum EnemyActionType {
  attack, // 攻擊
  skill, // 技能
  defend, // 防禦
  buff, // 增益
  debuff, // 減益
  special, // 特殊行動
}

/// 敵人行動
///
/// 遵循 Single Responsibility Principle：
/// 只負責描述敵人的一個具體行動
@freezed
abstract class EnemyAction with _$EnemyAction {
  const factory EnemyAction({
    required String id, // 行動ID
    required String name, // 行動名稱
    required String description, // 行動描述
    required EnemyActionType type, // 行動類型
    required String skillId, // 對應的技能ID
    @Default(1) int priority, // 優先級（數字越小越優先）
    @Default(false) bool isInterruptible, // 是否可被打斷
    @Default(true) bool isTargetable, // 是否可被選中無效化
    @Default('#FF6B6B') String color, // 顯示顏色
    @Default('') String iconPath, // 圖標路徑
    @Default(1.0) double damageMultiplier, // 傷害倍率
    @Default({}) Map<String, dynamic> parameters, // 額外參數
  }) = _EnemyAction;
}

/// 敵人行動結果
///
/// 遵循 Single Responsibility Principle：
/// 只負責描述行動執行的結果
@freezed
abstract class EnemyActionResult with _$EnemyActionResult {
  const factory EnemyActionResult({
    required EnemyAction action,
    required bool wasExecuted,
    @Default(0) int damageDealt,
    @Default(0) int healingReceived,
    @Default([]) List<String> statusEffectsApplied,
    @Default('') String message,
  }) = _EnemyActionResult;
}

/// 敵人行動擴展方法
///
/// 遵循 Open/Closed Principle：
/// 通過擴展方法添加行為，而不修改原始類
extension EnemyActionExtensions on EnemyAction {
  /// 是否為攻擊類行動
  bool get isAttackAction =>
      type == EnemyActionType.attack || type == EnemyActionType.skill;

  /// 是否為輔助類行動
  bool get isSupportAction =>
      type == EnemyActionType.buff || type == EnemyActionType.defend;

  /// 是否為負面行動
  bool get isDebuffAction => type == EnemyActionType.debuff;

  /// 獲取行動的顯示圖標
  String getDisplayIcon() {
    if (iconPath.isNotEmpty) return iconPath;

    switch (type) {
      case EnemyActionType.attack:
        return 'assets/icons/sword.png';
      case EnemyActionType.skill:
        return 'assets/icons/magic.png';
      case EnemyActionType.defend:
        return 'assets/icons/shield.png';
      case EnemyActionType.buff:
        return 'assets/icons/buff.png';
      case EnemyActionType.debuff:
        return 'assets/icons/debuff.png';
      case EnemyActionType.special:
        return 'assets/icons/special.png';
    }
  }

  /// 獲取行動類型的顯示名稱
  String getTypeDisplayName() {
    switch (type) {
      case EnemyActionType.attack:
        return '攻擊';
      case EnemyActionType.skill:
        return '技能';
      case EnemyActionType.defend:
        return '防禦';
      case EnemyActionType.buff:
        return '增益';
      case EnemyActionType.debuff:
        return '減益';
      case EnemyActionType.special:
        return '特殊';
    }
  }

  /// 創建執行結果
  EnemyActionResult createResult({
    required bool wasExecuted,
    int damageDealt = 0,
    int healingReceived = 0,
    List<String> statusEffectsApplied = const [],
    String message = '',
  }) {
    return EnemyActionResult(
      action: this,
      wasExecuted: wasExecuted,
      damageDealt: damageDealt,
      healingReceived: healingReceived,
      statusEffectsApplied: statusEffectsApplied,
      message: message,
    );
  }
}
