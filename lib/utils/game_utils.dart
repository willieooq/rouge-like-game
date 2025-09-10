// ================================
// lib/utils/game_utils.dart - 游戏全局工具类（重构版 - 移除技能直接操作）
// ================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'enemy_utils.dart';
import 'skill_utils.dart';

/// 游戏全局工具类 - 重构版
///
/// 职责：提供跨领域的便利方法，聚合其他专门的工具类
/// 设计原则：不直接访问服务，而是委托给专门的工具类
/// 注意：技能相关操作请使用 SkillUtils，敌人相关操作请使用 EnemyUtils
class GameUtils {
  GameUtils._();

  // ================================
  // 跨领域的战斗分析方法
  // ================================

  /// 获取完整的技能-敌人匹配分析
  static Map<String, dynamic> analyzeSkillVsEnemy(
    Ref ref,
    String skillId,
    String enemyId,
  ) {
    final skill = SkillUtils.getSkill(ref, skillId);
    final enemy = EnemyUtils.getEnemyData(ref, enemyId);

    if (skill == null || enemy == null) {
      return {
        'error': '技能或敌人不存在',
        'skill_exists': skill != null,
        'enemy_exists': enemy != null,
      };
    }

    // 这里是跨领域的分析逻辑
    final estimatedDamage = SkillUtils.calculateSkillDamage(
      ref,
      skill,
      100, // 假设基础攻击力
      1.0, // 假设无buff
    );

    final finalDamage = SkillUtils.calculateFinalDamage(
      ref,
      estimatedDamage,
      enemy.baseDefense,
    );

    final efficiency = finalDamage / skill.cost;
    final turnsToKill = (enemy.baseHp / finalDamage).ceil();

    return {
      'skill': skill,
      'enemy': enemy,
      'estimated_damage': estimatedDamage,
      'final_damage': finalDamage,
      'efficiency': efficiency,
      'turns_to_kill': turnsToKill,
      'cost_to_kill': turnsToKill * skill.cost,
      'is_effective': efficiency > 10.0, // 效率阈值
    };
  }

  /// 分析技能组合对敌人的效果
  static Map<String, dynamic> analyzeSkillCombinationVsEnemy(
    Ref ref,
    List<String> skillIds,
    String enemyId,
  ) {
    final enemy = EnemyUtils.getEnemyData(ref, enemyId);
    if (enemy == null) {
      return {'error': '敌人不存在'};
    }

    final validSkills = SkillUtils.getValidSkills(ref, skillIds);
    if (validSkills.isEmpty) {
      return {'error': '没有有效技能'};
    }

    int totalDamage = 0;
    int totalCost = 0;
    final skillAnalyses = <Map<String, dynamic>>[];

    for (final skill in validSkills) {
      final analysis = analyzeSkillVsEnemy(ref, skill.id, enemyId);
      skillAnalyses.add(analysis);

      if (analysis['final_damage'] != null) {
        totalDamage += analysis['final_damage'] as int;
        totalCost += skill.cost;
      }
    }

    final canKillInOneRound = totalDamage >= enemy.baseHp;
    final overallEfficiency = totalCost > 0 ? totalDamage / totalCost : 0.0;

    return {
      'enemy': enemy,
      'skills': validSkills,
      'total_damage': totalDamage,
      'total_cost': totalCost,
      'overall_efficiency': overallEfficiency,
      'can_kill_in_one_round': canKillInOneRound,
      'damage_percentage': (totalDamage / enemy.baseHp * 100).clamp(0, 100),
      'skill_analyses': skillAnalyses,
    };
  }

  /// 推荐最佳战斗策略
  static Map<String, dynamic> recommendBattleStrategy(
    Ref ref,
    List<String> availableSkills,
    String enemyId,
  ) {
    final enemy = EnemyUtils.getEnemyData(ref, enemyId);
    if (enemy == null) {
      return {'error': '敌人不存在'};
    }

    // 根据敌人类型推荐不同策略
    String situation;
    String reasoning;

    if (EnemyUtils.isBossEnemy(ref, enemyId)) {
      situation = 'high_damage';
      reasoning = 'Boss敌人血量高，需要高伤害技能快速解决';
    } else if (EnemyUtils.isEliteEnemy(ref, enemyId)) {
      situation = 'support';
      reasoning = '精英敌人有特殊能力，需要辅助技能应对';
    } else {
      situation = 'low_cost';
      reasoning = '普通敌人，使用低成本技能保存资源';
    }

    final recommendedSkills = SkillUtils.recommendForSituation(
      ref,
      availableSkills,
      situation: situation,
    );

    // 分析推荐组合的效果
    final combinationAnalysis = analyzeSkillCombinationVsEnemy(
      ref,
      recommendedSkills,
      enemyId,
    );

    return {
      'enemy': enemy,
      'enemy_type': EnemyUtils.isBossEnemy(ref, enemyId)
          ? 'boss'
          : EnemyUtils.isEliteEnemy(ref, enemyId)
          ? 'elite'
          : 'normal',
      'strategy': situation,
      'reasoning': reasoning,
      'recommended_skills': recommendedSkills,
      'combination_analysis': combinationAnalysis,
    };
  }

  // ================================
  // 队伍和进度分析
  // ================================

  /// 计算队伍总战力
  static Map<String, dynamic> calculatePartyPower(
    Ref ref,
    List<String> characterSkills,
  ) {
    final skillStats = SkillUtils.getSkillStatistics(ref, characterSkills);

    // 基础战力计算
    final basePower =
        (skillStats['total_damage'] ?? 0) * 10 +
        (skillStats['total_cost'] ?? 0) * 5;

    // 效率加成
    final efficiencyBonus = ((skillStats['average_efficiency'] ?? 0.0) * 100)
        .round();

    // 多样性加成（技能类型越多越好）
    final typeCount = (skillStats['type_distribution'] as Map?)?.length ?? 0;
    final diversityBonus = typeCount * 50;

    final totalPower = basePower + efficiencyBonus + diversityBonus;

    return {
      'base_power': basePower,
      'efficiency_bonus': efficiencyBonus,
      'diversity_bonus': diversityBonus,
      'total_power': totalPower,
      'skill_stats': skillStats,
      'power_rating': _getPowerRating(totalPower),
    };
  }

  /// 获取战力等级描述
  static String _getPowerRating(int power) {
    if (power >= 1000) return '传奇';
    if (power >= 750) return '史诗';
    if (power >= 500) return '稀有';
    if (power >= 250) return '精良';
    return '普通';
  }

  /// 分析队伍技能配置建议
  static Map<String, dynamic> analyzePartyConfiguration(
    Ref ref,
    List<String> currentSkills,
    List<String> availableSkills,
  ) {
    final currentStats = SkillUtils.getSkillStatistics(ref, currentSkills);
    final currentGroups = SkillUtils.groupSkillsByType(ref, currentSkills);

    // 识别缺失的技能类型
    final missingTypes = <String>[];
    if ((currentGroups['attack']?.length ?? 0) == 0) missingTypes.add('attack');
    if ((currentGroups['heal']?.length ?? 0) == 0) missingTypes.add('heal');
    if ((currentGroups['support']?.length ?? 0) == 0)
      missingTypes.add('support');

    // 推荐补充技能
    final recommendations = <String, List<String>>{};
    for (final type in missingTypes) {
      recommendations[type] = SkillUtils.recommendForSituation(
        ref,
        availableSkills,
        situation: type == 'attack'
            ? 'high_damage'
            : type == 'heal'
            ? 'low_hp'
            : 'support',
      ).take(3).toList(); // 只推荐前3个
    }

    return {
      'current_stats': currentStats,
      'missing_types': missingTypes,
      'recommendations': recommendations,
      'is_balanced': missingTypes.isEmpty,
      'improvement_suggestions': _generateImprovementSuggestions(
        ref,
        currentSkills,
        missingTypes,
      ),
    };
  }

  /// 生成改进建议
  static List<String> _generateImprovementSuggestions(
    Ref ref,
    List<String> currentSkills,
    List<String> missingTypes,
  ) {
    final suggestions = <String>[];
    final stats = SkillUtils.getSkillStatistics(ref, currentSkills);

    if (missingTypes.contains('attack')) {
      suggestions.add('缺少攻击技能，建议添加高伤害技能');
    }
    if (missingTypes.contains('heal')) {
      suggestions.add('缺少治疗技能，建议添加回复技能以提高生存能力');
    }
    if (missingTypes.contains('support')) {
      suggestions.add('缺少辅助技能，建议添加buff/debuff技能');
    }

    final avgEfficiency = stats['average_efficiency'] as double? ?? 0.0;
    if (avgEfficiency < 10.0) {
      suggestions.add('整体效率偏低，建议替换一些低效率技能');
    }

    final totalCost = stats['total_cost'] as int? ?? 0;
    if (totalCost > 20) {
      suggestions.add('总成本过高，建议加入一些低成本技能');
    }

    return suggestions;
  }

  // ================================
  // 游戏进度和难度分析
  // ================================

  /// 评估玩家准备度（针对特定敌人或关卡）
  static Map<String, dynamic> assessPlayerReadiness(
    Ref ref,
    List<String> playerSkills,
    String targetEnemyId,
  ) {
    final battleStrategy = recommendBattleStrategy(
      ref,
      playerSkills,
      targetEnemyId,
    );
    final partyPower = calculatePartyPower(ref, playerSkills);

    final combinationAnalysis =
        battleStrategy['combination_analysis'] as Map<String, dynamic>? ?? {};
    final canWin =
        combinationAnalysis['can_kill_in_one_round'] as bool? ?? false;
    final damagePercentage =
        combinationAnalysis['damage_percentage'] as double? ?? 0.0;

    String readinessLevel;
    if (canWin) {
      readinessLevel = '完全准备好';
    } else if (damagePercentage >= 80) {
      readinessLevel = '基本准备好';
    } else if (damagePercentage >= 50) {
      readinessLevel = '需要改进';
    } else {
      readinessLevel = '准备不足';
    }

    return {
      'readiness_level': readinessLevel,
      'can_win_in_one_round': canWin,
      'damage_percentage': damagePercentage,
      'party_power': partyPower,
      'battle_strategy': battleStrategy,
      'success_probability': _calculateSuccessProbability(damagePercentage),
    };
  }

  /// 计算成功概率
  static double _calculateSuccessProbability(double damagePercentage) {
    if (damagePercentage >= 100) return 0.95;
    if (damagePercentage >= 80) return 0.75;
    if (damagePercentage >= 60) return 0.60;
    if (damagePercentage >= 40) return 0.40;
    return 0.20;
  }

  // ================================
  // 通用工具方法
  // ================================

  /// 格式化数值显示
  static String formatValue(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(2);
    }
    return value.toString();
  }

  /// 获取颜色代码（根据效率等级）
  static String getEfficiencyColor(double efficiency) {
    if (efficiency >= 15) return 'green';
    if (efficiency >= 10) return 'orange';
    return 'red';
  }

  /// 获取难度评级
  static String getDifficultyRating(int enemyHp, int enemyDefense) {
    final difficulty = enemyHp + enemyDefense * 2;
    if (difficulty >= 500) return '地狱';
    if (difficulty >= 300) return '困难';
    if (difficulty >= 150) return '普通';
    return '简单';
  }
}
