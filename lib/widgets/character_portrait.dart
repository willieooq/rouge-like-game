import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/normal_constants.dart';
import '../models/battle/operation_mode.dart';
import '../models/character/character.dart';
import '../providers/operation_mode_provider.dart';

class CharacterPortrait extends ConsumerWidget {
  final Character character;
  final bool isSelected;
  final VoidCallback? onTap;

  const CharacterPortrait({
    super.key,
    required this.character,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(operationModeProvider);

    return SizedBox(
      width: portraitWidth,
      height: portraitHeight,
      child: currentMode == OperationMode.commonMode
          ? _buildCommonMode(context)
          : _buildSkillMode(context),
    );
  }

  /// Common Mode
  /// 顯示圖像、屬性、數值
  Widget _buildCommonMode(BuildContext context) {
    // 角色立繪模式
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // 使用mastery顏色作為背景
          color: Color(character.mastery.colorValue),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(cardBorderRadius),
        ),
        child: Stack(
          children: [
            // 左上角專精圓點
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(character.mastery.colorValue),
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
            // 底部攻擊力
            Positioned(
              bottom: 4,
              left: 4,
              right: 4,
              child: Text(
                '${character.attackPower}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // 角色名稱（中間）
            Center(
              child: Text(
                character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Skill Mode
  /// 顯示上下兩個技能的便於戰鬥模式
  Widget _buildSkillMode(BuildContext context) {
    // 技能模式
    return Column(
      children: [
        // 上半部：技能A
        Expanded(
          child: GestureDetector(
            onTap: () {
              // 觸發技能A
              print('Skill A activated for ${character.name}');
              // 觸發後切回commonMode
              // 這裡需要ref，但在方法裡怎麼取得？
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                border: Border.all(color: Colors.blue),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(cardBorderRadius),
                  topRight: Radius.circular(cardBorderRadius),
                ),
              ),
              child: const Center(
                child: Text('A', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        // 下半部：技能B
        Expanded(
          child: GestureDetector(
            onTap: () {
              // 觸發技能B
              print('Skill B activated for ${character.name}');
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red[200],
                border: Border.all(color: Colors.red),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(cardBorderRadius),
                  bottomRight: Radius.circular(cardBorderRadius),
                ),
              ),
              child: const Center(
                child: Text('B', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
