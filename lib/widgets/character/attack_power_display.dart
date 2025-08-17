import 'package:flutter/material.dart';

import '../../constants/font_constants.dart';

/// 攻擊力顯示組件
class AttackPowerDisplay extends StatelessWidget {
  final int attackPower;
  final Color? textColor;
  final double? fontSize;

  const AttackPowerDisplay({
    super.key,
    required this.attackPower,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$attackPower',
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: fontSize ?? PortraitFontSizes.attackPowerFontSize,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// 根據頭像大小計算攻擊力字體大小
  static double getAttackPowerFontSize(double avatarHeight) {
    return avatarHeight * PortraitFontSizes.attackPowerFontRatio;
  }
}
