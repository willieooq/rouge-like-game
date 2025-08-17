import 'package:flutter/material.dart';

import '../constants/normal_constants.dart';
import '../models/character/character.dart';
import 'character/character_portrait.dart';

/// 隊伍資訊
class PartyFormation extends StatelessWidget {
  final List<Character> characters;
  final String? selectedCharacterId;
  final Function(String characterId)? onCharacterSelected;
  final VoidCallback? onModeSwitchPressed;

  const PartyFormation({
    super.key,
    required this.characters,
    this.selectedCharacterId,
    this.onCharacterSelected,
    this.onModeSwitchPressed,
  });

  @override
  Widget build(BuildContext context) {
    // 確保有5個角色
    assert(characters.length == 5, 'Party must have exactly 5 characters');

    // 前排3個角色 (index 0, 1, 2)
    final frontRow = characters.take(3).toList();
    // 後排2個角色 (index 3, 4) - 但要分開處理
    final backRowLeft = characters.length > 3 ? characters[3] : null;
    final backRowRight = characters.length > 4 ? characters[4] : null;

    /// 繪製前後排
    return Column(
      children: [
        // 前排（3個角色）
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: frontRow
                .map(
                  (character) => Expanded(
                    child: AspectRatio(
                      aspectRatio: 60 / 80,
                      child: _createCharacterPortraitCharacter(
                        character,
                        selectedCharacterId,
                        onCharacterSelected,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        // 後排（2個角色，居中）
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 左側角色
              Expanded(
                child: AspectRatio(
                  aspectRatio: portraitAspectRatio,

                  child: backRowLeft != null
                      ? _createCharacterPortraitCharacter(
                          backRowLeft,
                          selectedCharacterId,
                          onCharacterSelected,
                        )
                      : SizedBox(
                          width: portraitWidth,
                          height: portraitHeight,
                        ), // 佔位符
                ),
              ),
              // 中間切換按鈕
              Expanded(
                child: AspectRatio(
                  aspectRatio: portraitAspectRatio,
                  child: _buildModeSwitch(),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: portraitAspectRatio,
                  child: // 右側角色
                  backRowRight != null
                      ? _createCharacterPortraitCharacter(
                          backRowRight,
                          selectedCharacterId,
                          onCharacterSelected,
                        )
                      : SizedBox(
                          width: portraitWidth,
                          height: portraitHeight,
                        ), // 佔位符,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 繪製角色圖像
  Widget _createCharacterPortraitCharacter(
    Character character,
    String? selectedCharacterId,
    void Function(String)? onCharacterSelected,
  ) {
    return CharacterPortrait(
      character: character,
      isSelected: character.id == selectedCharacterId,
      onTap: onCharacterSelected != null
          ? () => onCharacterSelected(character.id)
          : null,
    );
  }

  Widget _buildModeSwitch() {
    return GestureDetector(
      onTap: onModeSwitchPressed,
      child: Container(
        width: portraitWidth,
        height: portraitHeight,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 2), // 用橘色區分
          borderRadius: BorderRadius.circular(8),
          color: Colors.orange[50], // 淺橘色背景
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.swap_horiz, // 切換圖標
              color: Colors.orange[700],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              '切換',
              style: TextStyle(fontSize: 10, color: Colors.orange[700]),
            ),
          ],
        ),
      ),
    );
  }
}
