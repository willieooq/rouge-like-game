import '../../../models/enemy/enemy.dart';

/// 敵人遭遇生成結果 Bean
class EnemyEncounterResult {
  final List<Enemy> enemies;
  final bool success;
  final String message;
  final double difficultyRating;

  const EnemyEncounterResult({
    required this.enemies,
    required this.success,
    required this.message,
    this.difficultyRating = 0.0,
  });

  EnemyEncounterResult copyWith({
    List<Enemy>? enemies,
    bool? success,
    String? message,
    double? difficultyRating,
  }) {
    return EnemyEncounterResult(
      enemies: enemies ?? this.enemies,
      success: success ?? this.success,
      message: message ?? this.message,
      difficultyRating: difficultyRating ?? this.difficultyRating,
    );
  }

  static const EnemyEncounterResult empty = EnemyEncounterResult(
    enemies: [],
    success: false,
    message: '無敵人遭遇',
  );
}
