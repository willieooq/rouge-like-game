// 測試用的工廠類，類似Java測試中的TestDataBuilder
import 'package:rouge_project/models/battle/battle_state.dart';
import 'package:rouge_project/models/character/character.dart';
import 'package:rouge_project/models/character/mastery.dart';
import 'package:rouge_project/models/skill/skills.dart';

class TestDataBuilder {
  // 建立測試用角色的便利方法
  static Character createCharacter({
    String id = 'test_char',
    String name = 'Test Character',
    int maxCost = 8,
    int currentCost = 8,
    int attackPower = 100,
    List<String> skillIds = const ['skill1'],
  }) {
    return Character(
      id: id,
      name: name,
      mastery: Mastery.fire,
      attackPower: attackPower,
      skillIds: skillIds,
    );
  }

  // 建立測試用技能的便利方法
  static Skill createSkill({
    String id = 'test_skill',
    String name = 'Test Skill',
    String description = 'Test description',
    int cost = 3,
    int baseDamage = 100,
    String element = '物理',
    SkillType type = SkillType.attack,
  }) {
    return Skill(
      id: id,
      name: name,
      description: description,
      cost: cost,
      baseDamage: baseDamage,
      element: element,
      type: type,
    );
  }

  // 建立測試用戰鬥狀態的便利方法
  static BattleState createBattleState({
    List<Character>? party,
    int currentTurnCost = 6,
    int maxTurnCost = 6,
    bool isPlayerTurn = true,
    int turnNumber = 1,
  }) {
    return BattleState(
      party: party ?? [createCharacter()],
      currentTurnCost: currentTurnCost,
      maxTurnCost: maxTurnCost,
      isPlayerTurn: isPlayerTurn,
      turnNumber: turnNumber,
    );
  }
}
