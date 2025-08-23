import 'package:flutter/material.dart';
import 'package:rouge_project/widgets/skill/skill_button_content.dart';

import '../../constants/normal_constants.dart';
import '../../models/skill/skills.dart';

/// 技能按鈕組件
/// 可配置為交互式或純展示模式
class SkillButton extends StatelessWidget {
  final Skills skills;
  final bool canUse;
  final VoidCallback? onTap;
  final bool isTopHalf;
  final bool isInteractive;
  final double? width;
  final double? height;

  const SkillButton({
    super.key,
    required this.skills,
    this.canUse = true,
    this.onTap,
    this.isTopHalf = true,
    this.isInteractive = false,
    this.width,
    this.height,
  });

  /// 空技能槽構造函數
  const SkillButton.empty({
    super.key,
    this.isTopHalf = true,
    this.width,
    this.height,
  }) : skills = const Skills(
         id: '',
         name: '',
         cost: 0,
         damage: 0,
         description: '',
         element: '',
         type: '',
       ),
       canUse = false,
       onTap = null,
       isInteractive = false;

  @override
  Widget build(BuildContext context) {
    if (skills.id.isEmpty) {
      return _buildEmptySlot();
    }

    Widget button = _buildSkillButton();

    // 如果是交互式的，添加點擊功能
    if (isInteractive && onTap != null) {
      button = GestureDetector(onTap: canUse ? onTap : null, child: button);
    }

    return button;
  }

  /// 建立技能按鈕
  Widget _buildSkillButton() {
    return Container(
      width: width ?? double.infinity,
      height: height,
      padding: EdgeInsets.all(_getButtonPadding()),
      decoration: _buildButtonDecoration(),
      child: SkillButtonContent(skills: skills, canUse: canUse),
    );
  }

  /// 建立空技能槽
  Widget _buildEmptySlot() {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey),
        borderRadius: _getBorderRadius(),
      ),
      child: const Center(
        child: Text('無技能', style: TextStyle(color: Colors.grey, fontSize: 8)),
      ),
    );
  }

  /// 建立按鈕裝飾
  BoxDecoration _buildButtonDecoration() {
    return BoxDecoration(
      color: _getBackgroundColor(),
      border: Border.all(color: _getBorderColor()),
      borderRadius: _getBorderRadius(),
    );
  }

  /// 獲取背景顏色
  Color _getBackgroundColor() {
    if (!canUse) return Colors.grey[300]!;

    return isTopHalf ? Colors.blue[200]! : Colors.red[200]!;
  }

  /// 獲取邊框顏色
  Color _getBorderColor() {
    if (!canUse) return Colors.grey;

    return isTopHalf ? Colors.blue : Colors.red;
  }

  /// 獲取圓角
  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
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
    );
  }

  /// 獲取按鈕內邊距
  double _getButtonPadding() {
    // 可以根據按鈕大小動態調整
    final baseHeight = height ?? portraitHeight / 2;
    return baseHeight * 0.05; // 高度的5%
  }
}
