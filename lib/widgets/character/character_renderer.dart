import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/character/character.dart';
import '../../models/character/mastery.dart';
import '../../models/party/operation_mode.dart';
import '../../providers/operation_mode_provider.dart';
import '../mastery_dot.dart';
import 'attack_power_display.dart';
import 'character_avatar.dart';
import 'character_card.dart';
import 'character_skill_view.dart';

/// 角色渲染工廠類
///
/// 提供各種角色相關的視覺組件，支援多種使用場景：
/// - buildInteractivePortrait: 戰鬥界面的完整交互角色
/// - buildAvatar: 背包、列表等場景的純展示頭像
/// - buildCard: 詳細信息展示
/// - buildMasteryDot: 專精圓點組件
/// - buildAttackPower: 攻擊力顯示組件
///
/// 使用範例：
/// ```dart
/// // 戰鬥界面
/// CharacterRenderer.buildInteractivePortrait(character, isSelected: true)
///
/// // 背包界面
/// CharacterRenderer.buildAvatar(character, size: 40)
/// ```
class CharacterRenderer {
  /// 完整交互式角色肖像（用於戰鬥界面）
  /// 包含模式切換、選擇狀態等完整功能
  static Widget buildInteractivePortrait(
    Character character, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    // 改用 ConsumerWidget 包裝
    return _InteractivePortraitWrapper(
      character: character,
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  /// 純展示頭像（用於背包、列表等）
  /// 無交互功能，純顯示
  static Widget buildAvatar(
    Character character, {
    double? size,
    bool isSelected = false,
  }) {
    return CharacterAvatar(
      character: character,
      isSelected: isSelected,
      size: size,
      isInteractive: false,
    );
  }

  /// 卡片模式（用於詳細信息展示）
  /// 顯示更多角色信息
  static Widget buildCard(Character character) {
    return CharacterCard(character: character);
  }

  /// 專精圓點
  static Widget buildMasteryDot(Mastery mastery, {double? size}) {
    return MasteryDot(mastery: mastery, size: size);
  }

  /// 攻擊力顯示
  static Widget buildAttackPower(
    int attackPower, {
    Color? textColor,
    double? fontSize,
  }) {
    return AttackPowerDisplay(
      attackPower: attackPower,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  /// 角色背景容器
  static Widget buildBackground(
    Character character, {
    bool isSelected = false,
    double? width,
    double? height,
    Widget? child,
  }) {
    return CharacterAvatar.buildBackground(
      character: character,
      isSelected: isSelected,
      width: width,
      height: height,
      child: child,
    );
  }
}

/// 交互式角色肖像包裝器
/// 確保正確監聽狀態變化
class _InteractivePortraitWrapper extends ConsumerWidget {
  final Character character;
  final bool isSelected;
  final VoidCallback? onTap;

  const _InteractivePortraitWrapper({
    required this.character,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 正確監聽狀態變化
    final displayState = ref.watch(operationModeProvider);

    // 獲取當前角色的顯示模式
    final characterDisplayMode = ref
        .read(operationModeProvider.notifier)
        .getCharacterDisplayMode(character.id);

    // Debug 輸出
    // print(
    //   '角色 ${character.name} 顯示模式: $characterDisplayMode, 全域模式: ${displayState.globalMode}',
    // );

    return characterDisplayMode == CharacterDisplayMode.skill
        ? CharacterSkillView(character: character)
        : CharacterAvatar(
            character: character,
            isSelected: isSelected,
            onTap: onTap,
            isInteractive: true,
          );
  }
}
