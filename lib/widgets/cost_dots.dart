import 'package:flutter/material.dart';

class CostDots extends StatelessWidget {
  final int currentCost; // 當前Cost
  final int maxCost; // 最大Cost
  final double dotSize; // 圓點大小
  final Color activeDotColor; // 有Cost的圓點顏色
  final Color inactiveDotColor; // 用掉的圓點顏色

  const CostDots({
    super.key,
    required this.currentCost,
    required this.maxCost,
    this.dotSize = 8.0,
    this.activeDotColor = Colors.blue,
    this.inactiveDotColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0, // 圓點間距
      runSpacing: 4.0, // 換行間距
      children: List.generate(maxCost, (index) {
        // index < currentCost 表示這個圓點還有Cost
        final isActive = index < currentCost;

        return Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeDotColor : inactiveDotColor,
            border: Border.all(color: Colors.black26, width: 0.5),
          ),
        );
      }),
    );
  }
}
