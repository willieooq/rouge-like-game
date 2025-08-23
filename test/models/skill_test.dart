import 'package:flutter_test/flutter_test.dart';
import 'package:rouge_project/models/skill/skills.dart';

void main() {
  group('Skill Model Tests', () {
    test('should create skill with all properties', () {
      const skill = Skill(
        id: 'fireball',
        name: '火球術',
        description: '基礎火系攻擊',
        cost: 3,
        baseDamage: 150,
        element: '火',
        type: SkillType.attack,
      );

      expect(skill.id, equals('fireball'));
      expect(skill.name, equals('火球術'));
      expect(skill.cost, equals(3));
      expect(skill.type, equals(SkillType.attack));
    });

    test('should calculate damage correctly', () {
      const skill = Skill(
        id: 'test',
        name: 'Test',
        description: 'Test skill',
        cost: 3,
        baseDamage: 100,
        element: '物理',
        type: SkillType.attack,
      );

      final damage = skill.calculateDamage(120);
      expect(damage, equals(1200)); // 100 * 120 * 0.1 = 1200, rounded = 12
    });

    test('should identify skill types correctly', () {
      const attackSkill = Skill(
        id: 'attack',
        name: 'Attack',
        description: 'Attack skill',
        cost: 2,
        baseDamage: 100,
        element: '物理',
        type: SkillType.attack,
      );

      const healSkill = Skill(
        id: 'heal',
        name: 'Heal',
        description: 'Heal skill',
        cost: 3,
        baseDamage: 80,
        element: '光',
        type: SkillType.heal,
      );

      expect(attackSkill.isAttackSkill, isTrue);
      expect(attackSkill.isHealSkill, isFalse);
      expect(healSkill.isHealSkill, isTrue);
      expect(healSkill.isAttackSkill, isFalse);
    });

    test('should calculate cost efficiency', () {
      const efficientSkill = Skill(
        id: 'efficient',
        name: 'Efficient',
        description: 'High efficiency',
        cost: 2,
        baseDamage: 100,
        element: '物理',
        type: SkillType.attack,
      );

      const inefficientSkill = Skill(
        id: 'inefficient',
        name: 'Inefficient',
        description: 'Low efficiency',
        cost: 5,
        baseDamage: 100,
        element: '物理',
        type: SkillType.attack,
      );

      expect(efficientSkill.costEfficiency, equals(50.0)); // 100/2
      expect(inefficientSkill.costEfficiency, equals(20.0)); // 100/5
    });
  });

  group('SkillType Enum Tests', () {
    test('should have correct display names', () {
      expect(SkillType.attack.displayName, equals('攻擊'));
      expect(SkillType.heal.displayName, equals('治療'));
      expect(SkillType.support.displayName, equals('輔助'));
    });

    test('should categorize offensive and defensive correctly', () {
      expect(SkillType.attack.isOffensive, isTrue);
      expect(SkillType.heal.isOffensive, isFalse);
      expect(SkillType.support.isOffensive, isFalse);

      expect(SkillType.attack.isDefensive, isFalse);
      expect(SkillType.heal.isDefensive, isTrue);
      expect(SkillType.support.isDefensive, isTrue);
    });
  });
}
