// ================================
// lib/widgets/skill/skill_renderer.dart - 修正版
// ================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/skill/skills.dart';
import '../../utils/widget_utils.dart';
import 'skill_button.dart';
import 'skill_icon.dart';
import 'skill_info.dart';

/// 技能渲染工廠類（修正版）
///
/// 使用 WidgetUtils 來獲取技能數據，避免類型轉換問題
/// 對於複雜的業務邏輯，適當時會直接調用服務
class SkillRenderer {
  /// 完整功能技能按鈕（用於戰鬥界面）
  static Widget buildInteractiveButton(
    String skillId, {
    required String characterId,
    required bool canUse,
    required VoidCallback? onTap,
    bool isTopHalf = true,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final skills = WidgetUtils.getSkillInWidget(ref, skillId);

        if (skills == null) {
          return buildEmptySlot(isTopHalf: isTopHalf);
        }

        return SkillButton(
          skills: skills,
          canUse: canUse,
          onTap: onTap,
          isTopHalf: isTopHalf,
          isInteractive: true,
        );
      },
    );
  }

  /// 純展示技能按鈕
  static Widget buildDisplayButton(
    String skillId, {
    bool isTopHalf = true,
    double? width,
    double? height,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final skills = WidgetUtils.getSkillInWidget(ref, skillId);

        if (skills == null) {
          return buildEmptySlot(isTopHalf: isTopHalf);
        }

        return SkillButton(
          skills: skills,
          canUse: true,
          isTopHalf: isTopHalf,
          isInteractive: false,
          width: width,
          height: height,
        );
      },
    );
  }

  /// 技能圖標
  static Widget buildIcon(String skillId, {double? size}) {
    return Consumer(
      builder: (context, ref, child) {
        final skills = WidgetUtils.getSkillInWidget(ref, skillId);

        if (skills == null) {
          return SkillIcon.empty(size: size);
        }

        return SkillIcon(skills: skills, size: size);
      },
    );
  }

  /// 技能資訊卡片
  static Widget buildInfoCard(String skillId) {
    return Consumer(
      builder: (context, ref, child) {
        final skills = WidgetUtils.getSkillInWidget(ref, skillId);

        if (skills == null) {
          return const SkillInfo.empty();
        }

        return SkillInfo(skills: skills);
      },
    );
  }

  /// 增強版技能資訊卡片
  static Widget buildEnhancedInfoCard(String skillId) {
    return Consumer(
      builder: (context, ref, child) {
        final skills = WidgetUtils.getSkillInWidget(ref, skillId);

        if (skills == null) {
          return WidgetUtils.buildSkillErrorPlaceholder(skillId);
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                buildIcon(skillId, size: 32),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            skills.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          WidgetUtils.buildSkillTypeIcon(ref, skillId),
                        ],
                      ),
                      Text(
                        WidgetUtils.getSkillSummary(ref, skillId),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetUtils.buildSkillEfficiencyIndicator(ref, skillId),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 技能列表
  static Widget buildList(
    List<String> skillIds, {
    Function(String skillId)? onSkillSelected,
    bool useEnhancedCards = false,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          children: skillIds.map((skillId) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: onSkillSelected != null
                    ? () => onSkillSelected(skillId)
                    : null,
                child: useEnhancedCards
                    ? buildEnhancedInfoCard(skillId)
                    : buildInfoCard(skillId),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// 按類型分組的技能列表（使用簡化版分組）
  static Widget buildGroupedList(
    List<String> skillIds, {
    Function(String skillId)? onSkillSelected,
    bool useEnhancedCards = false,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        // 簡化版分組邏輯
        final skills = WidgetUtils.getValidSkills(ref, skillIds);
        final Map<String, List<Skills>> grouped = {};

        for (final skill in skills) {
          grouped.putIfAbsent(skill.type, () => []).add(skill);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: grouped.entries.map((entry) {
            final type = entry.key;
            final skillList = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    type.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...skillList.map(
                  (skill) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 16,
                    ),
                    child: GestureDetector(
                      onTap: onSkillSelected != null
                          ? () => onSkillSelected(skill.id)
                          : null,
                      child: useEnhancedCards
                          ? buildEnhancedInfoCard(skill.id)
                          : buildInfoCard(skill.id),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  /// 推薦技能列表（簡化版）
  static Widget buildRecommendedList(
    List<String> skillIds, {
    int? maxCost,
    String? preferredType,
    Function(String skillId)? onSkillSelected,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        // 簡化版篩選邏輯
        final skills = WidgetUtils.getValidSkills(ref, skillIds);
        final recommendedSkills = skills.where((skill) {
          if (maxCost != null && skill.cost > maxCost) return false;
          if (preferredType != null && skill.type != preferredType)
            return false;
          return true;
        }).toList();

        if (recommendedSkills.isEmpty) {
          return const Center(child: Text('沒有符合條件的推薦技能'));
        }

        return Column(
          children: recommendedSkills.map((skill) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: onSkillSelected != null
                    ? () => onSkillSelected(skill.id)
                    : null,
                child: Row(
                  children: [
                    buildIcon(skill.id, size: 32),
                    const SizedBox(width: 8),
                    WidgetUtils.buildSkillTypeIcon(ref, skill.id),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skill.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            WidgetUtils.getSkillSummary(ref, skill.id),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    WidgetUtils.buildSkillEfficiencyIndicator(ref, skill.id),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// 技能網格
  static Widget buildGrid(
    List<String> skillIds, {
    int crossAxisCount = 3,
    Function(String skillId)? onSkillSelected,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: skillIds.length,
          itemBuilder: (context, index) {
            final skillId = skillIds[index];
            return GestureDetector(
              onTap: onSkillSelected != null
                  ? () => onSkillSelected(skillId)
                  : null,
              child: buildDisplayButton(skillId),
            );
          },
        );
      },
    );
  }

  /// 空技能槽
  static Widget buildEmptySlot({
    bool isTopHalf = true,
    double? width,
    double? height,
  }) {
    return SkillButton.empty(
      isTopHalf: isTopHalf,
      width: width,
      height: height,
    );
  }

  /// 技能比較組件
  static Widget buildComparison(String skillId1, String skillId2) {
    return Consumer(
      builder: (context, ref, child) {
        final efficiency1 = WidgetUtils.getSkillEfficiency(ref, skillId1);
        final efficiency2 = WidgetUtils.getSkillEfficiency(ref, skillId2);

        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  buildEnhancedInfoCard(skillId1),
                  Text('效率: ${efficiency1.toStringAsFixed(1)}'),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                const Icon(Icons.compare_arrows),
                Text(
                  efficiency1 > efficiency2
                      ? '更好'
                      : efficiency1 < efficiency2
                      ? '較差'
                      : '相同',
                  style: TextStyle(
                    color: efficiency1 > efficiency2
                        ? Colors.green
                        : efficiency1 < efficiency2
                        ? Colors.red
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  buildEnhancedInfoCard(skillId2),
                  Text('效率: ${efficiency2.toStringAsFixed(1)}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// 為特定情況推薦的技能組件（簡化版）
  static Widget buildSituationalRecommendations(
    List<String> availableSkills,
    String situation, {
    Function(String skillId)? onSkillSelected,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        // 簡化版情況推薦
        List<String> recommended = [];

        switch (situation) {
          case 'low_hp':
            recommended = availableSkills
                .where((id) => WidgetUtils.isHealSkill(ref, id))
                .toList();
            break;
          case 'high_damage':
            recommended = availableSkills
                .where((id) => WidgetUtils.isAttackSkill(ref, id))
                .toList();
            break;
          case 'support':
            recommended = availableSkills
                .where((id) => WidgetUtils.isSupportSkill(ref, id))
                .toList();
            break;
          default:
            recommended = availableSkills;
        }

        if (recommended.isEmpty) {
          return Center(child: Text('沒有適合 $situation 情況的技能'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '推薦用於: $situation',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...recommended.map(
              (skillId) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: GestureDetector(
                  onTap: onSkillSelected != null
                      ? () => onSkillSelected(skillId)
                      : null,
                  child: buildEnhancedInfoCard(skillId),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 最佳技能組合推薦（簡化版）
  static Widget buildBestCombinationRecommendation(
    List<String> availableSkills,
    int totalCostLimit, {
    Function(List<String> combination)? onCombinationSelected,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        // 簡化版最佳組合邏輯
        final skills = WidgetUtils.getValidSkills(ref, availableSkills);

        // 按效率排序
        skills.sort((a, b) {
          final effA = a.cost > 0 ? a.damage / a.cost : 0.0;
          final effB = b.cost > 0 ? b.damage / b.cost : 0.0;
          return effB.compareTo(effA);
        });

        final List<String> bestCombination = [];
        int remainingCost = totalCostLimit;

        for (final skill in skills) {
          if (skill.cost <= remainingCost) {
            bestCombination.add(skill.id);
            remainingCost -= skill.cost;
          }
        }

        if (bestCombination.isEmpty) {
          return const Center(child: Text('無法在給定成本內找到合適的技能組合'));
        }

        final totalCost = bestCombination.fold(
          0,
          (sum, skillId) => sum + WidgetUtils.getSkillCost(ref, skillId),
        );

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '推薦技能組合',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '總成本: $totalCost/$totalCostLimit',
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...bestCombination.map(
                  (skillId) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: buildEnhancedInfoCard(skillId),
                  ),
                ),
                if (onCombinationSelected != null) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => onCombinationSelected(bestCombination),
                      child: const Text('使用這個組合'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
