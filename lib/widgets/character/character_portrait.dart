import 'package:flutter/material.dart';

import '../../models/character/character.dart';
import 'character_renderer.dart';

/// 角色繪製圖像
class CharacterPortrait extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return CharacterRenderer.buildInteractivePortrait(
      character,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}
