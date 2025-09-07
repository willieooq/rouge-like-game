// lib/shared/beans/battle/battle_action_result.dart
// 保持你現有的實現，但添加擴展方法：

import '../../../models/battle/battle_state.dart';
import '../../../models/enemy/enemy_action.dart';

/// 基礎戰鬥動作結果
class BattleActionResult {
  final BattleState newState;
  final bool actionSuccess;
  final String message;

  // 新增統計字段（可選）
  final int? totalDamageDealt;
  final int? totalHealingReceived;
  final List<String>? statusEffectsApplied;
  final List<EnemyActionResult>? actionResults;

  const BattleActionResult({
    required this.newState,
    required this.actionSuccess,
    required this.message,
    this.totalDamageDealt,
    this.totalHealingReceived,
    this.statusEffectsApplied,
    this.actionResults,
  });

  BattleActionResult copyWith({
    BattleState? newState,
    bool? actionSuccess,
    String? message,
    int? totalDamageDealt,
    int? totalHealingReceived,
    List<String>? statusEffectsApplied,
    List<EnemyActionResult>? actionResults,
  }) {
    return BattleActionResult(
      newState: newState ?? this.newState,
      actionSuccess: actionSuccess ?? this.actionSuccess,
      message: message ?? this.message,
      totalDamageDealt: totalDamageDealt ?? this.totalDamageDealt,
      totalHealingReceived: totalHealingReceived ?? this.totalHealingReceived,
      statusEffectsApplied: statusEffectsApplied ?? this.statusEffectsApplied,
      actionResults: actionResults ?? this.actionResults,
    );
  }

  // 便利工廠方法
  static BattleActionResult success({
    required BattleState newState,
    required String message,
    int? totalDamageDealt,
    int? totalHealingReceived,
    List<String>? statusEffectsApplied,
    List<EnemyActionResult>? actionResults,
  }) {
    return BattleActionResult(
      newState: newState,
      actionSuccess: true,
      message: message,
      totalDamageDealt: totalDamageDealt,
      totalHealingReceived: totalHealingReceived,
      statusEffectsApplied: statusEffectsApplied,
      actionResults: actionResults,
    );
  }

  static BattleActionResult failure({
    required BattleState currentState,
    required String message,
  }) {
    return BattleActionResult(
      newState: currentState,
      actionSuccess: false,
      message: message,
    );
  }
}

/// 擴展方法，提供便利功能
extension BattleActionResultExtensions on BattleActionResult {
  /// 是否為敵人回合結果
  bool get isEnemyTurnResult =>
      actionResults != null && actionResults!.isNotEmpty;

  /// 是否造成了實際傷害
  bool get hasDamage => (totalDamageDealt ?? 0) > 0;

  /// 是否有治療效果
  bool get hasHealing => (totalHealingReceived ?? 0) > 0;

  /// 是否應用了狀態效果
  bool get hasStatusEffects => (statusEffectsApplied ?? []).isNotEmpty;

  /// 獲取總體效果描述
  String get effectSummary {
    final effects = <String>[];

    if (hasDamage) effects.add('造成 $totalDamageDealt 點傷害');
    if (hasHealing) effects.add('回復 $totalHealingReceived 點生命值');
    if (hasStatusEffects)
      effects.add('應用 ${statusEffectsApplied!.length} 個狀態效果');

    return effects.isEmpty ? '無特殊效果' : effects.join('，');
  }
}
