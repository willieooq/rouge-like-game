import 'package:flutter_test/flutter_test.dart';
import 'package:rouge_project/models/battle/battle_state.dart';
import 'package:rouge_project/models/character/character.dart';
import 'package:rouge_project/models/character/mastery.dart';
import 'package:rouge_project/models/skill/skills.dart';

void main() {
  group('BattleState Model Tests', () {
    // 測試用的fixture data (類似 Java 的 @BeforeEach setup)
    late Character warrior;
    late Character mage;
    late List<Character> testParty;

    setUp(() {
      // setUp = Java 的 @BeforeEach
      warrior = const Character(
        id: 'warrior',
        name: '戰士',
        mastery: Mastery.fire,
        attackPower: 120,
        skillIds: ['slash'],
      );

      mage = const Character(
        id: 'mage',
        name: '法師',
        mastery: Mastery.ice,
        attackPower: 100,
        skillIds: ['fireball'],
      );

      testParty = [warrior, mage];
    });

    test('should create with default values', () {
      final battleState = BattleState(party: testParty);

      expect(battleState.party, equals(testParty));
      expect(battleState.currentTurnCost, equals(6)); // @Default value
      expect(battleState.maxTurnCost, equals(6));
      expect(battleState.isPlayerTurn, isTrue);
      expect(battleState.turnNumber, equals(1));
    });

    test('should calculate total party cost', () {
      final battleState = BattleState(party: testParty);

      expect(battleState.maxTurnCost, equals(10)); // 6 + 4
    });

    test('should use skill and reduce turn cost', () {
      const skill = Skill(
        id: 'test_skill',
        name: 'Test',
        description: 'Test',
        cost: 3,
        baseDamage: 100,
        element: '火',
        type: SkillType.attack,
      );

      final battleState = BattleState(party: testParty, currentTurnCost: 6);

      final afterSkill = battleState.afterUsingSkill(skill);

      expect(afterSkill.currentTurnCost, equals(3)); // 6 - 3
      expect(afterSkill.party, equals(testParty)); // party不變
    });

    test('should start new turn correctly', () {
      final battleState = BattleState(
        party: testParty,
        currentTurnCost: 2, // 當前回合剩餘
        isPlayerTurn: true,
        turnNumber: 1,
      );

      final newTurn = battleState.startNewTurn();

      expect(newTurn.currentTurnCost, equals(6)); // 恢復滿Cost
      expect(newTurn.isPlayerTurn, isFalse); // 切換到敵人回合
      expect(newTurn.turnNumber, equals(1)); // 玩家回合結束不算一輪

      // 再切換一次 (敵人回合結束)
      final nextPlayerTurn = newTurn.startNewTurn();
      expect(nextPlayerTurn.isPlayerTurn, isTrue);
      expect(nextPlayerTurn.turnNumber, equals(2)); // 現在才算新的一輪
    });
  });
}
