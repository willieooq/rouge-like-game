// lib/shared/beans/battle/battle_action_result.dart
import '../../../models/battle/battle_state.dart';

/// 戰鬥行動結果 Bean
class BattleActionResult {
  final BattleState newState;
  final bool success;
  final String message;

  const BattleActionResult({
    required this.newState,
    required this.success,
    required this.message,
  });

  BattleActionResult copyWith({
    BattleState? newState,
    bool? success,
    String? message,
  }) {
    return BattleActionResult(
      newState: newState ?? this.newState,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }
}
