import 'package:flutter/material.dart';

import '../../models/skill/skill_data.dart';
import 'skill_icon.dart';

/// 技能信息卡片組件
/// 用於詳細的技能說明顯示
class SkillInfo extends StatelessWidget {
  final SkillData skillData;

  const SkillInfo({super.key, required this.skillData});

  /// 空技能信息構造函數
  const SkillInfo.empty({super.key})
    : skillData = const SkillData(
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
    if (skillData.id.isEmpty) {
      return _buildEmptyInfo();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // 技能圖標
            SkillIcon(skillData: skillData, size: 48),
            const SizedBox(width: 12),

            // 技能詳細信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 技能名稱和Cost
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        skillData.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Cost: ${skillData.cost}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // 技能描述
                  Text(
                    skillData.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),

                  // 技能屬性信息
                  Row(
                    children: [
                      _buildInfoChip('傷害', '${skillData.damage}'),
                      const SizedBox(width: 8),
                      _buildInfoChip('屬性', skillData.element),
                      const SizedBox(width: 8),
                      _buildInfoChip('類型', skillData.type),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 建立空技能信息
  Widget _buildEmptyInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const SkillIcon.empty(size: 48),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '無技能',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '該槽位沒有裝備技能',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 建立信息標籤
  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$label: $value', style: const TextStyle(fontSize: 11)),
    );
  }
}
