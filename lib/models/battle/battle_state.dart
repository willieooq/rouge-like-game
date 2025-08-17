import 'package:freezed_annotation/freezed_annotation.dart';

import '../character/character.dart';
import '../skill/skill.dart';

part 'battle_state.freezed.dart';
part 'battle_state.g.dart';

@freezed
abstract class BattleState with _$BattleState {
  const factory BattleState({
    required List<Character> party,
    @Default(6) int currentTurnCost, // @Default = Java的default value
    @Default(6) int maxTurnCost,
    @Default(true) bool isPlayerTurn,
    @Default(1) int turnNumber,
  }) = _BattleState;

  const BattleState._();

  // 便利方法：檢查是否可以使用技能
  bool canUseSkill(Skill skill) => currentTurnCost >= skill.cost;

  // 便利方法：使用技能後的狀態
  BattleState afterUsingSkill(Skill skill) {
    if (!canUseSkill(skill)) {
      throw Exception('Not enough turn cost to use skill');
    }
    return copyWith(currentTurnCost: currentTurnCost - skill.cost);
  }

  // 便利方法：開始新回合
  BattleState startNewTurn() {
    return copyWith(
      currentTurnCost: maxTurnCost,
      isPlayerTurn: !isPlayerTurn,
      turnNumber: isPlayerTurn ? turnNumber : turnNumber + 1,
    );
  }

  // 便利方法：更新指定角色
  BattleState updateCharacter(String characterId, Character updatedCharacter) {
    final updatedParty = party.map((char) {
      return char.id == characterId ? updatedCharacter : char;
    }).toList();

    return copyWith(party: updatedParty);
  }

  // // Getter methods
  // int get totalPartyCost =>
  //     party.map((char) => char.currentCost).reduce((a, b) => a + b);
  //
  // bool get hasUsableActions =>
  //     party.any((char) => char.currentCost > 0); // any = Java Stream.anyMatch()

  // JSON序列化支持
  factory BattleState.fromJson(Map<String, dynamic> json) =>
      _$BattleStateFromJson(json);
}
