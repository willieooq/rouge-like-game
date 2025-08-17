import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/battle/operation_mode.dart';

// 添加這兩行 part 聲明
part 'operation_mode_provider.freezed.dart';

@freezed
abstract class DisplayState with _$DisplayState {
  const factory DisplayState({
    required OperationMode globalMode,
    required Set<String> skillModeCharacters, // 單獨處於技能模式的角色ID
  }) = _DisplayState;
}

/// 戰鬥模式顯示切換
class OperationModeNotifier extends StateNotifier<DisplayState> {
  OperationModeNotifier()
    : super(
        const DisplayState(
          globalMode: OperationMode.commonMode,
          skillModeCharacters: {},
        ),
      );

  // 全域模式切換
  void switchGlobalMode() {
    print(
      '切換全域模式: ${state.globalMode} -> ${state.globalMode == OperationMode.commonMode ? OperationMode.skillMode : OperationMode.commonMode}',
    );

    state = state.copyWith(
      globalMode: state.globalMode == OperationMode.commonMode
          ? OperationMode.skillMode
          : OperationMode.commonMode,
      skillModeCharacters: {}, // 切換全域模式時清空單角色模式
    );
  }

  // 單角色技能模式切換
  void toggleCharacterSkillMode(String characterId) {
    final updatedSet = Set<String>.from(state.skillModeCharacters);

    if (updatedSet.contains(characterId)) {
      // 如果該角色已經是技能模式，則切換回一般模式
      updatedSet.remove(characterId);
    } else {
      // 如果該角色不是技能模式，則：
      // 1. 清空所有其他角色的技能模式
      updatedSet.clear();
      // 2. 只設定當前角色為技能模式
      updatedSet.add(characterId);
    }

    state = state.copyWith(skillModeCharacters: updatedSet);
  }

  // 角色使用技能後，如果是單角色模式則切回
  void onSkillUsed(String characterId) {
    if (state.globalMode == OperationMode.commonMode &&
        state.skillModeCharacters.contains(characterId)) {
      // 單角色模式，使用技能後切回
      final updatedSet = Set<String>.from(state.skillModeCharacters);
      updatedSet.remove(characterId);
      state = state.copyWith(skillModeCharacters: updatedSet);
    }
    // 全域技能模式不做任何切換
  }

  // 判斷角色應該顯示哪種模式
  CharacterDisplayMode getCharacterDisplayMode(String characterId) {
    if (state.globalMode == OperationMode.skillMode) {
      return CharacterDisplayMode.skill; // 全域技能模式
    }

    if (state.skillModeCharacters.contains(characterId)) {
      return CharacterDisplayMode.skill; // 單角色技能模式
    }

    return CharacterDisplayMode.common; // 一般模式
  }
}

final operationModeProvider =
    StateNotifierProvider<OperationModeNotifier, DisplayState>((ref) {
      return OperationModeNotifier();
    });
