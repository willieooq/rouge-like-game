// lib/shared/beans/enemy/enemy_action_queue_result.dart
import '../../../models/enemy/enemy_action.dart';

/// 敵人行動隊列生成結果 Bean
class EnemyActionQueueResult {
  final List<EnemyAction> actions;
  final bool success;
  final String message;
  final String aiStrategy;

  const EnemyActionQueueResult({
    required this.actions,
    required this.success,
    required this.message,
    this.aiStrategy = '',
  });

  EnemyActionQueueResult copyWith({
    List<EnemyAction>? actions,
    bool? success,
    String? message,
    String? aiStrategy,
  }) {
    return EnemyActionQueueResult(
      actions: actions ?? this.actions,
      success: success ?? this.success,
      message: message ?? this.message,
      aiStrategy: aiStrategy ?? this.aiStrategy,
    );
  }

  static const EnemyActionQueueResult empty = EnemyActionQueueResult(
    actions: [],
    success: false,
    message: '無行動隊列',
  );
}
