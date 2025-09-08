import '../../../models/character/character.dart';
import '../../../models/enemy/enemy.dart';

/// 技能執行請求 Bean
class SkillExecutionRequest {
  final String skillId;
  final String casterId;
  final List<Character> allies;
  final List<Enemy> enemies;
  final List<String> targetIds;
  final Map<String, dynamic>? context;

  const SkillExecutionRequest({
    required this.skillId,
    required this.casterId,
    required this.allies,
    required this.enemies,
    required this.targetIds,
    this.context,
  });

  SkillExecutionRequest copyWith({
    String? skillId,
    String? casterId,
    List<Character>? allies,
    List<Enemy>? enemies,
    List<String>? targetIds,
    Map<String, dynamic>? context,
  }) {
    return SkillExecutionRequest(
      skillId: skillId ?? this.skillId,
      casterId: casterId ?? this.casterId,
      allies: allies ?? this.allies,
      enemies: enemies ?? this.enemies,
      targetIds: targetIds ?? this.targetIds,
      context: context ?? this.context,
    );
  }
}
