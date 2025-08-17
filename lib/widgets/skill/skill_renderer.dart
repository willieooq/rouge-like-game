import 'package:flutter/material.dart';

import '../../models/skill/skill_data.dart';
import '../../services/skill_service.dart';
import 'skill_button.dart';
import 'skill_icon.dart';
import 'skill_info.dart';

/// 技能渲染工廠類
///
/// 提供各種技能相關的視覺組件，支援多種使用場景：
/// - buildInteractiveButton: 戰鬥界面的完整交互技能按鈕
/// - buildDisplayButton: 技能書等場景的純展示按鈕
/// - buildIcon: 技能圖標
/// - buildInfoCard: 技能詳細信息卡片
/// - buildList: 技能列表
///
/// 使用範例：
/// ```dart
/// // 戰鬥界面
/// SkillRenderer.buildInteractiveButton(skillId, characterId: charId, canUse: true)
///
/// // 技能書界面
/// SkillRenderer.buildIcon(skillId, size: 32)
/// ```
class SkillRenderer {
  /// 完整功能技能按鈕（用於戰鬥界面）
  /// 包含技能使用邏輯、狀態檢查等
  static Widget buildInteractiveButton(
    String skillId, {
    required String characterId,
    required bool canUse,
    required VoidCallback? onTap,
    bool isTopHalf = true,
  }) {
    final skillData = SkillService.getSkill(skillId);
    if (skillData == null) {
      return buildEmptySlot(isTopHalf: isTopHalf);
    }

    return SkillButton(
      skillData: skillData,
      canUse: canUse,
      onTap: onTap,
      isTopHalf: isTopHalf,
      isInteractive: true,
    );
  }

  /// 純展示技能按鈕（用於技能書、說明等）
  /// 無交互功能，純顯示
  static Widget buildDisplayButton(
    String skillId, {
    bool isTopHalf = true,
    double? width,
    double? height,
  }) {
    final skillData = SkillService.getSkill(skillId);
    if (skillData == null) {
      return buildEmptySlot(isTopHalf: isTopHalf);
    }

    return SkillButton(
      skillData: skillData,
      canUse: true,
      // 純展示模式總是可用樣式
      isTopHalf: isTopHalf,
      isInteractive: false,
      width: width,
      height: height,
    );
  }

  /// 技能圖標（用於簡化顯示）
  static Widget buildIcon(String skillId, {double? size}) {
    final skillData = SkillService.getSkill(skillId);
    if (skillData == null) {
      return SkillIcon.empty(size: size);
    }

    return SkillIcon(skillData: skillData, size: size);
  }

  /// 技能信息卡片（用於詳細說明）
  static Widget buildInfoCard(String skillId) {
    final skillData = SkillService.getSkill(skillId);
    if (skillData == null) {
      return const SkillInfo.empty();
    }

    return SkillInfo(skillData: skillData);
  }

  /// 技能列表（用於技能選擇界面）
  static Widget buildList(
    List<String> skillIds, {
    Function(String skillId)? onSkillSelected,
  }) {
    return Column(
      children: skillIds.map((skillId) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: GestureDetector(
            onTap: onSkillSelected != null
                ? () => onSkillSelected(skillId)
                : null,
            child: buildInfoCard(skillId),
          ),
        );
      }).toList(),
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

  /// 根據技能ID獲取技能數據（工具方法）
  static SkillData? getSkillData(String skillId) {
    return SkillService.getSkill(skillId);
  }

  /// 檢查技能是否存在（工具方法）
  static bool isValidSkill(String skillId) {
    return SkillService.hasSkill(skillId);
  }
}
