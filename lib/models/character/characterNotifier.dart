import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/models/character/mastery.dart';

import 'character.dart';

/// CharacterNotifier = Service Layer
/// 負責管理Character狀態和提供業務邏輯方法
/// see [Character]
class CharacterNotifier extends StateNotifier<Character> {
  // 構造函數：接收初始角色狀態
  CharacterNotifier(super.initialCharacter);
  //
  // // 業務方法：檢查是否可以使用技能
  // bool canUseSkill(int skillCost) {
  //   return state.currentCost >= skillCost;
  // }
  //
  // // 業務方法：使用技能
  // void useSkill(int skillCost) {
  //   if (canUseSkill(skillCost)) {
  //     state = state.copyWith(currentCost: state.currentCost - skillCost);
  //   }
  // }
  //
  // // 業務方法：恢復Cost
  // void restoreCost(int amount) {
  //   final newCost = (state.currentCost + amount).clamp(0, state.maxCost);
  //   state = state.copyWith(currentCost: newCost);
  // }
  //
  // // 業務方法：重置到滿Cost
  // void resetToFullCost() {
  //   state = state.copyWith(currentCost: state.maxCost);
  // }
  //
  // // 業務方法：直接設定Cost值
  // void setCost(int newCost) {
  //   final clampedCost = newCost.clamp(0, state.maxCost);
  //   state = state.copyWith(currentCost: clampedCost);
  // }
  //
  // // 業務方法：檢查Cost狀態
  // bool get isExhausted => state.currentCost <= 0;
  // bool get isFullCost => state.currentCost >= state.maxCost;
  // double get costPercentage => state.currentCost / state.maxCost;
}

// Provider定義：管理一個測試戰士
final characterProvider = StateNotifierProvider<CharacterNotifier, Character>((
  ref,
) {
  const testWarrior = Character(
    id: 'test_warrior',
    name: '測試戰士',
    mastery: Mastery.fire,
    attackPower: 120,
    skillIds: ['slash', 'heavy_strike'],
  );

  return CharacterNotifier(testWarrior);
});

// 衍生Provider：角色名稱
final characterNameProvider = Provider<String>((ref) {
  final character = ref.watch(characterProvider);
  return character.name;
});

// // 衍生Provider：Cost百分比
// final characterCostPercentageProvider = Provider<double>((ref) {
//   final notifier = ref.watch(characterProvider.notifier);
//   return notifier.costPercentage;
// });
//
// // 參數化Provider：檢查是否可以使用指定Cost的技能
// final canUseSkillProvider = Provider.family<bool, int>((ref, skillCost) {
//   final notifier = ref.watch(characterProvider.notifier);
//   return notifier.canUseSkill(skillCost);
// });
