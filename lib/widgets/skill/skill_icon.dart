import 'package:flutter/material.dart';

import '../../models/skill/skills.dart';

/// 技能圖標組件
/// 用於簡化的技能顯示
class SkillIcon extends StatelessWidget {
  final Skills skills;
  final double? size;

  const SkillIcon({super.key, required this.skills, this.size});

  /// 空技能圖標構造函數
  const SkillIcon.empty({super.key, this.size})
    : skills = const Skills(
        id: '',
        name: '',
        cost: 0,
        damage: 0,
        description: '',
        element: '',
        type: '',
      );

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 40.0;

    if (skills.id.isEmpty) {
      return _buildEmptyIcon(iconSize);
    }

    return _buildSkillIcon(iconSize);
  }

  /// 建立技能圖標
  Widget _buildSkillIcon(double iconSize) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: _getSkillColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Stack(
        children: [
          // 技能名稱縮寫（暫時用首字代替真實圖標）
          Center(
            child: Text(
              _getSkillAbbreviation(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: iconSize * 0.3, // 圖標大小的30%
              ),
            ),
          ),

          // Cost標記 - 右下角
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${skills.cost}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: iconSize * 0.2, // 圖標大小的20%
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 建立空圖標
  Widget _buildEmptyIcon(double iconSize) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: const Center(child: Icon(Icons.help_outline, color: Colors.grey)),
    );
  }

  /// 根據技能屬性獲取顏色
  Color _getSkillColor() {
    switch (skills.element.toLowerCase()) {
      case 'fire':
        return Colors.red[600]!;
      case 'ice':
        return Colors.blue[600]!;
      case 'thunder':
        return Colors.yellow[700]!;
      case 'light':
        return Colors.amber[300]!;
      case 'dark':
        return Colors.grey[800]!;
      case 'earth':
        return Colors.brown[600]!;
      case 'wind':
        return Colors.green[400]!;
      case 'physical':
        return Colors.orange[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  /// 獲取技能名稱縮寫
  String _getSkillAbbreviation() {
    if (skills.name.isEmpty) return '?';

    // 取中文首字或英文首字母
    return skills.name.length > 1 ? skills.name.substring(0, 1) : skills.name;
  }
}
