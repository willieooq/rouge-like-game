// ================================
// lib/utils/skill_utils.dart - 技能专用工具类（完整更新版）
// ================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dependency_injection.dart';
import '../core/interfaces/i_skill_service.dart';
import '../models/skill/skills.dart';

/// 技能专用工具类 - 技能操作的主要入口点
///
/// 职责：提供所有技能相关的便利方法
/// 设计原则：直接访问技能服务，作为技能领域的主要工具类
class SkillUtils {
  SkillUtils._();

  // ================================
  // 核心技能访问方法
  // ================================

  /// 从 Ref 获取技能服务
  static ISkillService _getSkillService(Ref ref) {
    return ref.read(skillServiceProvider);
  }

  /// 获取技能数据 - 主要入口点
  static Skills? getSkill(Ref ref, String skillId) {
    try {
      return _getSkillService(ref).getSkill(skillId);
    } catch (e) {
      // 静默处理错误，避免在工具类中抛出异常
      return null;
    }
  }

  /// 获取技能成本
  static int getSkillCost(Ref ref, String skillId) {
    try {
      return _getSkillService(ref).getSkillCost(skillId);
    } catch (e) {
      return 0; // 默认成本
    }
  }

  /// 检查技能是否存在
  static bool hasSkill(Ref ref, String skillId) {
    try {
      return _getSkillService(ref).hasSkill(skillId);
    } catch (e) {
      return false;
    }
  }

  /// 获取角色技能列表
  static List<Skills> getCharacterSkills(Ref ref, List<String> skillIds) {
    try {
      return _getSkillService(ref).getCharacterSkills(skillIds);
    } catch (e) {
      return [];
    }
  }

  /// 计算技能伤害
  static int calculateSkillDamage(
    Ref ref,
    Skills skill,
    int casterAttackPower,
    double buffMultiplier,
  ) {
    try {
      return _getSkillService(
        ref,
      ).calculateSkillDamage(skill, casterAttackPower, buffMultiplier);
    } catch (e) {
      return 0;
    }
  }

  /// 计算最终伤害
  static int calculateFinalDamage(Ref ref, int skillDamage, int enemyDefense) {
    try {
      return _getSkillService(
        ref,
      ).calculateFinalDamage(skillDamage, enemyDefense);
    } catch (e) {
      return skillDamage; // 如果计算失败，返回原始伤害
    }
  }

  // ================================
  // 技能分类和类型检查
  // ================================

  /// 检查技能类型
  static bool isAttackSkill(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    return skill?.isAttackSkill ?? false;
  }

  static bool isHealSkill(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    return skill?.isHealSkill ?? false;
  }

  static bool isSupportSkill(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    return skill?.isSupportSkill ?? false;
  }

  /// 检查是否为 AOE 技能
  static bool isAOESkill(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    return skill?.isAOE ?? false;
  }

  /// 检查是否为单体技能
  static bool isSingleTargetSkill(Ref ref, String skillId) {
    return !isAOESkill(ref, skillId);
  }

  // ================================
  // 技能成本分析
  // ================================

  /// 技能成本范围检查
  static bool isLowCostSkill(Ref ref, String skillId) {
    final cost = getSkillCost(ref, skillId);
    return cost <= 2;
  }

  static bool isMediumCostSkill(Ref ref, String skillId) {
    final cost = getSkillCost(ref, skillId);
    return cost >= 3 && cost <= 5;
  }

  static bool isHighCostSkill(Ref ref, String skillId) {
    final cost = getSkillCost(ref, skillId);
    return cost >= 6;
  }

  /// 获取成本等级（返回 'low', 'medium', 'high'）
  static String getCostLevel(Ref ref, String skillId) {
    if (isLowCostSkill(ref, skillId)) return 'low';
    if (isMediumCostSkill(ref, skillId)) return 'medium';
    return 'high';
  }

  // ================================
  // 技能效率和比较
  // ================================

  /// 获取技能的效率值（伤害/成本比）
  static double getSkillEfficiency(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    if (skill == null || skill.cost == 0) return 0.0;

    return skill.damage / skill.cost;
  }

  /// 获取综合效率（考虑伤害和治疗）
  static double getOverallEfficiency(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    if (skill == null || skill.cost == 0) return 0.0;

    final totalValue = skill.damage;
    return totalValue / skill.cost;
  }

  /// 比较两个技能的效率
  static int compareSkillsByEfficiency(
    Ref ref,
    String skillId1,
    String skillId2,
  ) {
    final efficiency1 = getSkillEfficiency(ref, skillId1);
    final efficiency2 = getSkillEfficiency(ref, skillId2);

    return efficiency2.compareTo(efficiency1); // 降序排列
  }

  /// 比较两个技能的成本
  static int compareSkillsByCost(Ref ref, String skillId1, String skillId2) {
    final cost1 = getSkillCost(ref, skillId1);
    final cost2 = getSkillCost(ref, skillId2);

    return cost1.compareTo(cost2); // 升序排列
  }

  /// 比较两个技能的伤害
  static int compareSkillsByDamage(Ref ref, String skillId1, String skillId2) {
    final skill1 = getSkill(ref, skillId1);
    final skill2 = getSkill(ref, skillId2);

    final damage1 = skill1?.damage ?? 0;
    final damage2 = skill2?.damage ?? 0;

    return damage2.compareTo(damage1); // 降序排列
  }

  // ================================
  // 技能筛选和推荐
  // ================================

  /// 批量获取技能数据（过滤掉不存在的）
  static List<Skills> getValidSkills(Ref ref, List<String> skillIds) {
    return skillIds
        .map((id) => getSkill(ref, id))
        .where((skill) => skill != null)
        .cast<Skills>()
        .toList();
  }

  /// 按类型分组技能
  static Map<String, List<Skills>> groupSkillsByType(
    Ref ref,
    List<String> skillIds,
  ) {
    final skills = getValidSkills(ref, skillIds);
    final Map<String, List<Skills>> grouped = {};

    for (final skill in skills) {
      grouped.putIfAbsent(skill.type, () => []).add(skill);
    }

    return grouped;
  }

  /// 按成本等级分组技能
  static Map<String, List<Skills>> groupSkillsByCost(
    Ref ref,
    List<String> skillIds,
  ) {
    final skills = getValidSkills(ref, skillIds);
    final Map<String, List<Skills>> grouped = {
      'low': [],
      'medium': [],
      'high': [],
    };

    for (final skill in skills) {
      final level = getCostLevel(ref, skill.id);
      grouped[level]!.add(skill);
    }

    return grouped;
  }

  /// 获取推荐技能（基于某些条件）
  static List<Skills> getRecommendedSkills(
    Ref ref,
    List<String> availableSkillIds, {
    int? maxCost,
    String? preferredType,
    double? minEfficiency,
  }) {
    final skills = getValidSkills(ref, availableSkillIds);

    return skills.where((skill) {
      if (maxCost != null && skill.cost > maxCost) return false;
      if (preferredType != null && skill.type != preferredType) return false;
      if (minEfficiency != null &&
          getSkillEfficiency(ref, skill.id) < minEfficiency)
        return false;
      return true;
    }).toList();
  }

  /// 为特定情况推荐技能
  static List<String> recommendForSituation(
    Ref ref,
    List<String> availableSkills, {
    required String
    situation, // 'low_hp', 'high_damage', 'support', 'aoe', 'single'
  }) {
    switch (situation) {
      case 'low_hp':
        return availableSkills.where((id) => isHealSkill(ref, id)).toList()
          ..sort((a, b) => compareSkillsByEfficiency(ref, a, b));
      case 'high_damage':
        return availableSkills.where((id) => isAttackSkill(ref, id)).toList()
          ..sort((a, b) => compareSkillsByDamage(ref, a, b));
      case 'support':
        return availableSkills.where((id) => isSupportSkill(ref, id)).toList()
          ..sort((a, b) => compareSkillsByCost(ref, a, b));
      case 'aoe':
        return availableSkills.where((id) => isAOESkill(ref, id)).toList()
          ..sort((a, b) => compareSkillsByEfficiency(ref, a, b));
      case 'single':
        return availableSkills
            .where((id) => isSingleTargetSkill(ref, id))
            .toList()
          ..sort((a, b) => compareSkillsByEfficiency(ref, a, b));
      case 'low_cost':
        return availableSkills.where((id) => isLowCostSkill(ref, id)).toList()
          ..sort((a, b) => compareSkillsByEfficiency(ref, a, b));
      default:
        return availableSkills;
    }
  }

  /// 获取技能的简短描述
  static String getSkillSummary(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    if (skill == null) return '未知技能';

    final cost = skill.cost;
    final damage = skill.damage;
    final type = skill.type;

    var summary = '$type - Cost:$cost';
    if (damage > 0) summary += ' Dmg:$damage';

    return summary;
  }

  /// 获取技能的详细描述
  static String getSkillDetails(Ref ref, String skillId) {
    final skill = getSkill(ref, skillId);
    if (skill == null) return '技能不存在';

    final efficiency = getSkillEfficiency(ref, skillId);
    final costLevel = getCostLevel(ref, skillId);

    return '${skill.name}\n'
        '类型: ${skill.type}\n'
        '成本: ${skill.cost} ($costLevel)\n'
        '伤害: ${skill.damage}\n'
        '效率: ${efficiency.toStringAsFixed(2)}\n'
        '描述: ${skill.description}';
  }

  /// 获取最佳技能组合（根据总成本限制）
  static List<String> getBestSkillCombination(
    Ref ref,
    List<String> availableSkills,
    int totalCostLimit,
  ) {
    final skills = getValidSkills(ref, availableSkills);

    // 按效率排序
    skills.sort(
      (a, b) => getOverallEfficiency(
        ref,
        b.id,
      ).compareTo(getOverallEfficiency(ref, a.id)),
    );

    final List<String> combination = [];
    int remainingCost = totalCostLimit;

    for (final skill in skills) {
      if (skill.cost <= remainingCost) {
        combination.add(skill.id);
        remainingCost -= skill.cost;
      }
    }

    return combination;
  }

  /// 获取平衡的技能组合（包含攻击、治疗、辅助）
  static Map<String, List<String>> getBalancedSkillCombination(
    Ref ref,
    List<String> availableSkills,
    int totalCostLimit,
  ) {
    final groupedSkills = groupSkillsByType(ref, availableSkills);
    final Map<String, List<String>> balancedCombination = {
      'attack': [],
      'heal': [],
      'support': [],
    };

    int remainingCost = totalCostLimit;
    final costPerType = (totalCostLimit / 3).floor(); // 平均分配成本

    // 为每种类型选择技能
    for (final type in ['attack', 'heal', 'support']) {
      final skills = groupedSkills[type] ?? [];
      skills.sort(
        (a, b) => getOverallEfficiency(
          ref,
          b.id,
        ).compareTo(getOverallEfficiency(ref, a.id)),
      );

      int typeCost = 0;
      for (final skill in skills) {
        if (skill.cost <= remainingCost &&
            typeCost + skill.cost <= costPerType) {
          balancedCombination[type]!.add(skill.id);
          remainingCost -= skill.cost;
          typeCost += skill.cost;
        }
      }
    }

    return balancedCombination;
  }

  // ================================
  // 技能统计和分析
  // ================================

  /// 获取技能使用统计
  static Map<String, dynamic> getSkillStatistics(
    Ref ref,
    List<String> skillIds,
  ) {
    final skills = getValidSkills(ref, skillIds);
    if (skills.isEmpty) return {};

    final totalDamage = skills.fold(0, (sum, skill) => sum + skill.damage);
    final totalCost = skills.fold(0, (sum, skill) => sum + skill.cost);
    final avgEfficiency =
        skills.fold(
          0.0,
          (sum, skill) => sum + getSkillEfficiency(ref, skill.id),
        ) /
        skills.length;

    final typeCount = <String, int>{};
    for (final skill in skills) {
      typeCount[skill.type] = (typeCount[skill.type] ?? 0) + 1;
    }

    return {
      'total_skills': skills.length,
      'total_damage': totalDamage,
      'total_cost': totalCost,
      'average_efficiency': avgEfficiency,
      'type_distribution': typeCount,
      'most_common_type': typeCount.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key,
    };
  }

  /// 查找相似技能
  static List<String> findSimilarSkills(
    Ref ref,
    String skillId,
    List<String> availableSkills,
  ) {
    final targetSkill = getSkill(ref, skillId);
    if (targetSkill == null) return [];

    final targetEfficiency = getSkillEfficiency(ref, skillId);

    return availableSkills.where((id) {
      if (id == skillId) return false; // 排除自己

      final skill = getSkill(ref, id);
      if (skill == null) return false;

      // 相似条件：同类型且效率相近（±20%）
      final sameType = skill.type == targetSkill.type;
      final efficiency = getSkillEfficiency(ref, id);
      final similarEfficiency =
          (efficiency - targetEfficiency).abs() / targetEfficiency <= 0.2;

      return sameType && similarEfficiency;
    }).toList();
  }
}
