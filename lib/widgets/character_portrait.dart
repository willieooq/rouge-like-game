import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/normal_constants.dart';
import '../models/battle/operation_mode.dart';
import '../models/character/character.dart';
import '../models/skill/skill_data.dart';
import '../providers/character_provider.dart';
import '../providers/operation_mode_provider.dart';
import '../services/skill_service.dart';

class CharacterPortrait extends ConsumerWidget {
  final Character character;
  final bool isSelected;
  final VoidCallback? onTap;

  const CharacterPortrait({
    super.key,
    required this.character,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayState = ref.watch(operationModeProvider);
    final characterDisplayMode = ref
        .read(operationModeProvider.notifier)
        .getCharacterDisplayMode(character.id);

    return Container(
      width: portraitWidth,
      height: portraitHeight,
      child: characterDisplayMode == CharacterDisplayMode.skill
          ? _buildSkillMode(ref)
          : _buildCommonMode(ref),
    );
  }

  /// Common Mode
  /// 顯示圖像、屬性、數值
  Widget _buildCommonMode(WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // CommonMode點擊角色 → 單角色技能模式切換
        if (onTap != null) {
          onTap!(); // 原有的選擇邏輯
        }
        ref
            .read(operationModeProvider.notifier)
            .toggleCharacterSkillMode(character.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(character.mastery.colorValue),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(cardBorderRadius),
        ),
        child: Stack(
          children: [
            // 左上角專精圓點
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(character.mastery.colorValue),
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
            // 底部攻擊力
            Positioned(
              bottom: 4,
              left: 4,
              right: 4,
              child: Text(
                '${character.attackPower}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // 角色名稱（中間）
            Center(
              child: Text(
                character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Skill Mode
  /// 顯示上下兩個技能的便於戰鬥模式
  Widget _buildSkillMode(WidgetRef ref) {
    return Column(
      children: [
        // 技能A
        Expanded(
          child: _buildSkillButton(ref, 0, true), // 第一個技能，上半部
        ),
        // 技能B
        Expanded(
          child: _buildSkillButton(ref, 1, false), // 第二個技能，下半部
        ),
      ],
    );
  }

  Widget _buildSkillButton(WidgetRef ref, int skillIndex, bool isTopHalf) {
    return Consumer(
      builder: (context, ref, child) {
        final skillId = character.skillIds.length > skillIndex
            ? character.skillIds[skillIndex]
            : '';

        final skillData = skillId.isNotEmpty
            ? SkillService.getSkill(skillId)
            : null;

        if (skillData == null) {
          return _buildEmptySkillSlot(isTopHalf);
        }

        final characterNotifier = ref.read(
          characterProviderFamily(character).notifier,
        );
        final canUse = characterNotifier.canUseSkill(skillId);

        return GestureDetector(
          onTap: canUse ? () => _useSkill(ref, skillId) : null,
          child: _buildSkillContainer(skillData, canUse, isTopHalf),
        );
      },
    );
  }

  // 統一的技能使用函數
  void _useSkill(WidgetRef ref, String skillId) {
    final characterNotifier = ref.read(
      characterProviderFamily(character).notifier,
    );
    final success = characterNotifier.useSkill(skillId);

    if (success) {
      // 通知OperationModeProvider技能已使用
      ref.read(operationModeProvider.notifier).onSkillUsed(character.id);
    }
  }

  Widget _buildEmptySkillSlot(bool isTopHalf) {
    // 空技能槽的顯示
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.only(
          topLeft: isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
          topRight: isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
          bottomLeft: !isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
          bottomRight: !isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
        ),
      ),
      child: const Center(
        child: Text('無技能', style: TextStyle(color: Colors.grey, fontSize: 8)),
      ),
    );
  }

  Widget _buildSkillContainer(
    SkillData skillData,
    bool canUse,
    bool isTopHalf,
  ) {
    final backgroundColor = canUse
        ? (isTopHalf ? Colors.blue[200] : Colors.red[200])
        : Colors.grey[300];
    final borderColor = canUse
        ? (isTopHalf ? Colors.blue : Colors.red)
        : Colors.grey;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor!),
        borderRadius: BorderRadius.only(
          topLeft: isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
          topRight: isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
          bottomLeft: !isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
          bottomRight: !isTopHalf
              ? const Radius.circular(cardBorderRadius)
              : Radius.zero,
        ),
      ),
      child: Stack(
        children: [
          // 技能名稱 - 左上角
          Positioned(
            top: 2,
            left: 2,
            child: Text(
              skillData.name,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: canUse ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
          // 技能描述 - 正中間
          Center(
            child: Text(
              skillData.description,
              style: TextStyle(
                fontSize: 7,
                color: canUse ? Colors.black87 : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Cost - 右下角
          Positioned(
            bottom: 2,
            right: 2,
            child: Text(
              '${skillData.cost}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: canUse ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
