import 'package:flutter/material.dart';

import '../../constants/font_constants.dart';
import '../../models/skill/skill_data.dart';

/// 技能按鈕內容佈局組件
/// 負責技能按鈕內部的文字和數值排版
class SkillButtonContent extends StatelessWidget {
  final SkillData skillData;
  final bool canUse;

  const SkillButtonContent({
    super.key,
    required this.skillData,
    this.canUse = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 技能名稱 - 左上角
        Positioned(top: 2, left: 2, child: _buildSkillName()),

        // 技能描述 - 正中間
        Center(child: _buildSkillDescription()),

        // Cost - 右下角
        Positioned(bottom: 2, right: 2, child: _buildSkillCost()),
      ],
    );
  }

  /// 建立技能名稱
  Widget _buildSkillName() {
    return Text(
      skillData.name,
      style: TextStyle(
        fontSize: PortraitFontSizes.skillNameFontSize,
        fontWeight: FontWeight.bold,
        color: _getTextColor(),
      ),
    );
  }

  /// 建立技能描述
  Widget _buildSkillDescription() {
    return Text(
      skillData.description,
      style: TextStyle(
        fontSize: PortraitFontSizes.skillDescriptionFontSize,
        color: _getDescriptionColor(),
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 建立技能Cost
  Widget _buildSkillCost() {
    return Text(
      '${skillData.cost}',
      style: TextStyle(
        fontSize: PortraitFontSizes.skillCostFontSize,
        fontWeight: FontWeight.bold,
        color: _getTextColor(),
      ),
    );
  }

  /// 獲取主要文字顏色
  Color _getTextColor() {
    return canUse ? Colors.black : Colors.grey[600]!;
  }

  /// 獲取描述文字顏色
  Color _getDescriptionColor() {
    return canUse ? Colors.black87 : Colors.grey[600]!;
  }
}
