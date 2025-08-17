import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/normal_constants.dart';
import '../../models/character/character.dart';
import '../../providers/character_provider.dart';
import '../../providers/operation_mode_provider.dart';
import '../skill/skill_renderer.dart';

/// 角色技能視圖組件
class CharacterSkillView extends ConsumerWidget {
  final Character character;

  const CharacterSkillView({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: portraitWidth,
      height: portraitHeight,
      child: Column(
        children: [
          // 技能A（上半部）
          Expanded(child: _buildSkillSlot(ref, 0, true)),
          // 技能B（下半部）
          Expanded(child: _buildSkillSlot(ref, 1, false)),
        ],
      ),
    );
  }

  /// 建立技能槽位
  Widget _buildSkillSlot(WidgetRef ref, int skillIndex, bool isTopHalf) {
    final skillId = character.skillIds.length > skillIndex
        ? character.skillIds[skillIndex]
        : '';

    if (skillId.isEmpty) {
      return SkillRenderer.buildEmptySlot(isTopHalf: isTopHalf);
    }

    // 檢查技能是否可用
    final characterNotifier = ref.read(
      characterProviderFamily(character).notifier,
    );
    final canUse = characterNotifier.canUseSkill(skillId);

    return SkillRenderer.buildInteractiveButton(
      skillId,
      characterId: character.id,
      canUse: canUse,
      onTap: () => _useSkill(ref, skillId),
      isTopHalf: isTopHalf,
    );
  }

  /// 使用技能
  void _useSkill(WidgetRef ref, String skillId) {
    final characterNotifier = ref.read(
      characterProviderFamily(character).notifier,
    );
    final success = characterNotifier.useSkill(skillId);

    if (success) {
      // 通知技能已使用
      ref.read(operationModeProvider.notifier).onSkillUsed(character.id);
    }
  }
}
