import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/test_characters.dart';
import '../models/battle/party.dart';

class PartyNotifier extends StateNotifier<Party> {
  PartyNotifier(Party initialParty) : super(initialParty);

  // 使用技能（從回合Cost中扣除）
  void useSkill(int skillCost) {
    if (canUseSkill(skillCost)) {
      state = state.copyWith(
        currentTurnCost: state.currentTurnCost - skillCost,
      );
    }
  }

  // 檢查是否可以使用技能
  bool canUseSkill(int skillCost) {
    return state.currentTurnCost >= skillCost;
  }

  // 開始新回合（恢復Cost）
  void startNewTurn() {
    state = state.copyWith(currentTurnCost: state.maxTurnCost);
  }

  // 受到傷害
  void takeDamage(int damage) {
    final newHp = (state.sharedHp - damage).clamp(0, state.maxHp);
    state = state.copyWith(sharedHp: newHp);
  }

  // 治療
  void heal(int amount) {
    final newHp = (state.sharedHp + amount).clamp(0, state.maxHp);
    state = state.copyWith(sharedHp: newHp);
  }

  // 便利屬性
  double get hpPercentage => state.sharedHp / state.maxHp;
  double get costPercentage => state.currentTurnCost / state.maxTurnCost;
  bool get isDefeated => state.sharedHp <= 0;
}

// 創建預設隊伍
final partyProvider = StateNotifierProvider<PartyNotifier, Party>((ref) {
  // 創建5個角色
  const characters = TestCharacters.defaultParty;

  const initialParty = Party(
    characters: characters,
    sharedHp: 100,
    maxHp: 100,
    currentTurnCost: 10, // 每回合有10點Cost可用
    maxTurnCost: 10,
  );

  return PartyNotifier(initialParty);
});
