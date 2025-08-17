import 'package:flutter/material.dart';

import '../../models/character/character.dart';
import '../mastery_dot.dart';
import 'attack_power_display.dart';

/// 角色卡片組件
/// 用於詳細信息展示
class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MasteryDot(mastery: character.mastery),
                const SizedBox(width: 8),
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('攻擊力: '),
                AttackPowerDisplay(
                  attackPower: character.attackPower,
                  textColor: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('技能: ${character.skillIds.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
