import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rouge_project/models/character/characterNotifier.dart';

void main() {
  group('CharacterProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should provide initial character state', () {
      final character = container.read(characterProvider);

      expect(character.name, equals('測試戰士'));
      expect(character.maxCost, equals(8));
      expect(character.currentCost, equals(8));
      expect(character.attackPower, equals(120));
    });

    group('Skill Usage Tests', () {
      test('should use skill when sufficient cost', () {
        final notifier = container.read(characterProvider.notifier);

        // 使用技能
        notifier.useSkill(3);

        final character = container.read(characterProvider);
        expect(character.currentCost, equals(5)); // 8 - 3 = 5
      });

      test('should not use skill when insufficient cost', () {
        final notifier = container.read(characterProvider.notifier);

        // 先消耗Cost到剩餘2
        notifier.setCost(2);

        // 嘗試使用需要5 Cost的技能
        notifier.useSkill(5);

        // Cost應該沒有變化
        final character = container.read(characterProvider);
        expect(character.currentCost, equals(2));
      });

      test('should check skill usability correctly', () {
        final notifier = container.read(characterProvider.notifier);

        notifier.setCost(5);

        expect(notifier.canUseSkill(3), isTrue); // 足夠
        expect(notifier.canUseSkill(5), isTrue); // 剛好
        expect(notifier.canUseSkill(6), isFalse); // 不足
      });
    });

    group('Cost Management Tests', () {
      test('should restore cost correctly', () {
        final notifier = container.read(characterProvider.notifier);

        // 設定初始Cost
        notifier.setCost(3);

        // 恢復Cost
        notifier.restoreCost(2);

        final character = container.read(characterProvider);
        expect(character.currentCost, equals(5));
      });

      test('should not exceed max cost when restoring', () {
        final notifier = container.read(characterProvider.notifier);

        notifier.setCost(6);
        notifier.restoreCost(5); // 試圖超過maxCost (8)

        final character = container.read(characterProvider);
        expect(character.currentCost, equals(8)); // 被限制在maxCost
      });

      test('should reset to full cost', () {
        final notifier = container.read(characterProvider.notifier);

        notifier.setCost(3);
        notifier.resetToFullCost();

        final character = container.read(characterProvider);
        expect(character.currentCost, equals(8));
      });

      test('should set cost within bounds', () {
        final notifier = container.read(characterProvider.notifier);

        // 正常值
        notifier.setCost(5);
        expect(container.read(characterProvider).currentCost, equals(5));

        // 超過最大值
        notifier.setCost(15);
        expect(container.read(characterProvider).currentCost, equals(8));

        // 負值
        notifier.setCost(-3);
        expect(container.read(characterProvider).currentCost, equals(0));
      });
    });

    group('State Properties Tests', () {
      test('should calculate cost percentage correctly', () {
        final notifier = container.read(characterProvider.notifier);

        notifier.setCost(4); // 4/8 = 0.5
        expect(notifier.costPercentage, equals(0.5));

        notifier.setCost(2); // 2/8 = 0.25
        expect(notifier.costPercentage, equals(0.25));
      });

      test('should check exhausted state correctly', () {
        final notifier = container.read(characterProvider.notifier);

        notifier.setCost(0);
        expect(notifier.isExhausted, isTrue);

        notifier.setCost(1);
        expect(notifier.isExhausted, isFalse);
      });

      test('should check full cost state correctly', () {
        final notifier = container.read(characterProvider.notifier);

        notifier.setCost(8);
        expect(notifier.isFullCost, isTrue);

        notifier.setCost(7);
        expect(notifier.isFullCost, isFalse);
      });
    });

    group('Derived Providers Tests', () {
      test('should provide character name through derived provider', () {
        final characterName = container.read(characterNameProvider);
        expect(characterName, equals('測試戰士'));
      });

      test('should provide cost percentage through derived provider', () {
        final notifier = container.read(characterProvider.notifier);
        notifier.setCost(4);

        final percentage = container.read(characterCostPercentageProvider);
        expect(percentage, equals(0.5));
      });

      test('should check skill usability through family provider', () {
        final notifier = container.read(characterProvider.notifier);
        notifier.setCost(5);

        expect(container.read(canUseSkillProvider(3)), isTrue);
        expect(container.read(canUseSkillProvider(5)), isTrue);
        expect(container.read(canUseSkillProvider(6)), isFalse);
      });
    });
  });
}
