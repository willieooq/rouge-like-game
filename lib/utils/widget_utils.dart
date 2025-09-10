// ================================
// lib/utils/widget_utils.dart - Widget專用工具類（修正版）
// ================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dependency_injection.dart';
import '../models/skill/skills.dart';

/// Widget層面的便利工具 - 修正版
///
/// 職責：專門為Widget使用場景優化的工具方法
/// 設計原則：直接使用 WidgetRef 調用服務，避免類型轉換問題
class WidgetUtils {
  WidgetUtils._();

  /// 在Widget中安全獲取技能數據
  static Skills? getSkillInWidget(WidgetRef ref, String skillId) {
    try {
      return ref.read(skillServiceProvider).getSkill(skillId);
    } catch (e) {
      debugPrint('獲取技能數據失敗: $e');
      return null;
    }
  }

  /// 獲取技能成本
  static int getSkillCost(WidgetRef ref, String skillId) {
    try {
      return ref.read(skillServiceProvider).getSkillCost(skillId);
    } catch (e) {
      return 0;
    }
  }

  /// 獲取技能效率
  static double getSkillEfficiency(WidgetRef ref, String skillId) {
    final skill = getSkillInWidget(ref, skillId);
    if (skill == null || skill.cost == 0) return 0.0;
    return skill.damage / skill.cost;
  }

  /// 獲取技能簡要描述
  static String getSkillSummary(WidgetRef ref, String skillId) {
    final skill = getSkillInWidget(ref, skillId);
    if (skill == null) return '未知技能';

    final cost = skill.cost;
    final damage = skill.damage;
    final type = skill.type;

    var summary = '$type - Cost:$cost';
    if (damage > 0) summary += ' Dmg:$damage';

    return summary;
  }

  /// 檢查技能類型
  static bool isAttackSkill(WidgetRef ref, String skillId) {
    final skill = getSkillInWidget(ref, skillId);
    return skill?.isAttackSkill ?? false;
  }

  static bool isHealSkill(WidgetRef ref, String skillId) {
    final skill = getSkillInWidget(ref, skillId);
    return skill?.isHealSkill ?? false;
  }

  static bool isSupportSkill(WidgetRef ref, String skillId) {
    final skill = getSkillInWidget(ref, skillId);
    return skill?.isSupportSkill ?? false;
  }

  /// 批量獲取有效技能（Widget版本 - 簡化版）
  static List<Skills> getValidSkills(WidgetRef ref, List<String> skillIds) {
    return skillIds
        .map((id) => getSkillInWidget(ref, id))
        .where((skill) => skill != null)
        .cast<Skills>()
        .toList();
  }

  /// 構建技能錯誤佔位符
  static Widget buildSkillErrorPlaceholder(String skillId) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '技能不存在: $skillId',
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  /// 構建載入中的技能佔位符
  static Widget buildSkillLoadingPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  /// 構建技能效率指示器
  static Widget buildSkillEfficiencyIndicator(WidgetRef ref, String skillId) {
    final efficiency = getSkillEfficiency(ref, skillId);

    Color color;
    if (efficiency >= 15) {
      color = Colors.green;
    } else if (efficiency >= 10) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        efficiency.toStringAsFixed(1),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 構建技能類型圖標
  static Widget buildSkillTypeIcon(WidgetRef ref, String skillId) {
    if (isAttackSkill(ref, skillId)) {
      return const Icon(Icons.whatshot, color: Colors.red, size: 16);
    } else if (isHealSkill(ref, skillId)) {
      return const Icon(Icons.healing, color: Colors.green, size: 16);
    } else if (isSupportSkill(ref, skillId)) {
      return const Icon(Icons.shield, color: Colors.blue, size: 16);
    } else {
      return const Icon(Icons.help_outline, color: Colors.grey, size: 16);
    }
  }
}
