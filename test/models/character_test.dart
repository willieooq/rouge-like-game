import 'package:flutter_test/flutter_test.dart';
import 'package:rouge_project/models/character/character.dart';

void main() {
  // group = Java 的 @Nested class 或 TestSuite
  group('Character Model Tests', () {
    // test = Java 的 @Test method
    test('should create character with required fields', () {
      // Arrange (準備) - 類似 Java 測試的 Given
      const character = Character(
        id: 'test_warrior',
        name: '測試戰士',
        maxCost: 8,
        currentCost: 8,
        attackPower: 120,
        skillIds: ['skill1', 'skill2'],
      );

      // Assert (斷言) - 類似 Java 的 assertThat()
      expect(character.id, equals('test_warrior'));
      expect(character.name, equals('測試戰士'));
      expect(character.maxCost, equals(8));
      expect(character.currentCost, equals(8));
      expect(character.attackPower, equals(120));
      expect(character.skillIds, equals(['skill1', 'skill2']));
    });

    test('should create updated character using copyWith', () {
      // Arrange
      const original = Character(
        id: 'warrior',
        name: '戰士',
        maxCost: 8,
        currentCost: 8,
        attackPower: 120,
        skillIds: ['skill1'],
      );

      // Act (執行) - 類似 Java 測試的 When
      final updated = original.copyWith(currentCost: 5, attackPower: 150);

      // Assert
      expect(updated.id, equals(original.id)); // 未更新的欄位保持不變
      expect(updated.name, equals(original.name));
      expect(updated.maxCost, equals(original.maxCost));
      expect(updated.skillIds, equals(original.skillIds));
      expect(updated.currentCost, equals(5)); // 更新的欄位
      expect(updated.attackPower, equals(150));
    });

    test('should check skill usage correctly', () {
      const character = Character(
        id: 'test',
        name: 'Test',
        maxCost: 8,
        currentCost: 5,
        attackPower: 100,
        skillIds: [],
      );

      // Test boundary conditions (邊界條件測試)
      expect(character.canUseSkill(5), isTrue); // 剛好夠用
      expect(character.canUseSkill(4), isTrue); // 足夠
      expect(character.canUseSkill(6), isFalse); // 不夠用
    });

    test('should use skill and reduce cost', () {
      const character = Character(
        id: 'test',
        name: 'Test',
        maxCost: 8,
        currentCost: 8,
        attackPower: 100,
        skillIds: [],
      );

      final afterSkill = character.afterUsingSkill(3);

      expect(afterSkill.currentCost, equals(5));
      expect(afterSkill.id, equals(character.id)); // 其他欄位不變
    });

    test('should throw exception when using skill without enough cost', () {
      const character = Character(
        id: 'test',
        name: 'Test',
        maxCost: 8,
        currentCost: 2,
        attackPower: 100,
        skillIds: [],
      );

      // expect + throwsA = Java 的 assertThrows()
      expect(() => character.afterUsingSkill(5), throwsA(isA<Exception>()));
    });

    test('should restore cost correctly', () {
      const character = Character(
        id: 'test',
        name: 'Test',
        maxCost: 8,
        currentCost: 3,
        attackPower: 100,
        skillIds: [],
      );

      // 測試正常恢復
      final restored = character.restoreCost(2);
      expect(restored.currentCost, equals(5));

      // 測試超過最大值的限制 (clamp)
      final overRestored = character.restoreCost(10);
      expect(overRestored.currentCost, equals(8)); // 應該被限制在maxCost
    });

    test('should calculate cost percentage correctly', () {
      const character = Character(
        id: 'test',
        name: 'Test',
        maxCost: 10,
        currentCost: 3,
        attackPower: 100,
        skillIds: [],
      );

      expect(character.costPercentage, equals(0.3));
      expect(character.isExhausted, isFalse);
      expect(character.isFullCost, isFalse);

      // 測試邊界情況
      final exhausted = character.copyWith(currentCost: 0);
      expect(exhausted.isExhausted, isTrue);

      final full = character.copyWith(currentCost: 10);
      expect(full.isFullCost, isTrue);
    });

    test('should have proper equality and hashCode', () {
      const char1 = Character(
        id: 'same',
        name: 'Same',
        maxCost: 8,
        currentCost: 8,
        attackPower: 100,
        skillIds: ['skill1'],
      );

      const char2 = Character(
        id: 'same',
        name: 'Same',
        maxCost: 8,
        currentCost: 8,
        attackPower: 100,
        skillIds: ['skill1'],
      );

      const char3 = Character(
        id: 'different',
        name: 'Different',
        maxCost: 8,
        currentCost: 8,
        attackPower: 100,
        skillIds: ['skill1'],
      );

      // 測試相等性 (Freezed自動生成)
      expect(char1, equals(char2));
      expect(char1, isNot(equals(char3)));

      // 測試hashCode一致性
      expect(char1.hashCode, equals(char2.hashCode));
    });
  });
}
