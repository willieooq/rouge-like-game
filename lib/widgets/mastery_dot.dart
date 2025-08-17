import 'package:flutter/material.dart';

import '../models/character/mastery.dart';

/// 專精圓點組件
/// TODO  更換為圖像
class MasteryDot extends StatelessWidget {
  final Mastery mastery;
  final double? size;

  static const double masteryDotRatio = 0.15;

  const MasteryDot({super.key, required this.mastery, this.size});

  @override
  Widget build(BuildContext context) {
    final dotSize = size ?? 12.0;

    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(mastery.colorValue),
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }

  /// 根據頭像大小計算專精圓點大小
  static double getMasteryDotSize(double avatarHeight) {
    return avatarHeight * 0.15; // 頭像高度的15%
  }
}
