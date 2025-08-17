import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/font_constants.dart';
import '../../constants/normal_constants.dart';
import '../../models/character/character.dart';
import '../../providers/operation_mode_provider.dart';
import '../mastery_dot.dart';
import 'attack_power_display.dart';

/// 角色頭像組件
/// 可配置為交互式或純展示模式
class CharacterAvatar extends ConsumerWidget {
  final Character character;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? size;
  final bool isInteractive;

  const CharacterAvatar({
    super.key,
    required this.character,
    this.isSelected = false,
    this.onTap,
    this.size,
    this.isInteractive = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarSize = size ?? portraitHeight;
    final width = size ?? portraitWidth;

    Widget avatar = _buildAvatarContent(avatarSize, width);

    // 如果是交互式的，添加點擊功能
    if (isInteractive) {
      avatar = GestureDetector(onTap: () => _handleTap(ref), child: avatar);
    }

    return SizedBox(width: width, height: avatarSize, child: avatar);
  }

  /// 處理點擊事件
  void _handleTap(WidgetRef ref) {
    // 原有的選擇邏輯
    if (onTap != null) {
      print("on tab");
      onTap!();
    }

    // 單角色技能模式切換
    ref
        .read(operationModeProvider.notifier)
        .toggleCharacterSkillMode(character.id);
  }

  /// 建立頭像內容
  Widget _buildAvatarContent(double height, double width) {
    return buildBackground(
      character: character,
      isSelected: isSelected,
      width: width,
      height: height,
      child: Stack(
        children: [
          // 左上角專精圓點
          Positioned(
            top: d_4,
            left: d_4,
            child: MasteryDot(
              mastery: character.mastery,
              size: MasteryDot.getMasteryDotSize(height),
            ),
          ),

          // 底部攻擊力
          Positioned(
            bottom: d_4,
            left: d_4,
            right: d_4,
            child: AttackPowerDisplay(
              attackPower: character.attackPower,
              fontSize: AttackPowerDisplay.getAttackPowerFontSize(height),
            ),
          ),

          // 角色名稱（中間）
          Center(
            child: Text(
              character.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: PortraitFontSizes.getCharacterNameFontSize(height),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 建立角色背景容器（靜態方法，供工廠類使用）
  static Widget buildBackground({
    required Character character,
    bool isSelected = false,
    double? width,
    double? height,
    Widget? child,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(character.mastery.colorValue),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: isSelected ? cardBorderWidthOnSelect : cardBorderWidth,
        ),
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: child,
    );
  }
}
