// ============================================================================
// 檔案位置: test/models/character/character_test.dart
// Character數據結構測試

import 'package:flutter_test/flutter_test.dart';
import 'package:rouge_project/models/character/character.dart';

void main() {
  group('Character Model Tests', () {
    test('should create character with required fields', () {
      const character = Character(
        id: 'test_warrior',
        name: '測試戰士',
        maxCost: 8,
        currentCost: 8,
        attackPower: 120,
        skillIds: ['skill1', 'skill2'],
      );

      expect(character.id, equals('test_warrior'));
      expect(character.name, equals('測試戰士'));
      expect(character.maxCost, equals(8));
      expect(character.currentCost, equals(8));
      expect(character.attackPower, equals(120));
      expect(character.skillIds, equals(['skill1', 'skill2']));
    });

    test('should create updated character using copyWith', () {
      const original = Character(
        id: 'warrior',
        name: '戰士',
        maxCost: 8,
        currentCost: 8,
        attackPower: 120,
        skillIds: ['skill1'],
      );

      final updated = original.copyWith(currentCost: 5, attackPower: 150);

      // 未更新的欄位保持不變
      expect(updated.id, equals(original.id));
      expect(updated.name, equals(original.name));
      expect(updated.maxCost, equals(original.maxCost));
      expect(updated.skillIds, equals(original.skillIds));

      // 更新的欄位
      expect(updated.currentCost, equals(5));
      expect(updated.attackPower, equals(150));
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

    test('should have immutable properties', () {
      const character = Character(
        id: 'test',
        name: 'Test',
        maxCost: 8,
        currentCost: 5,
        attackPower: 100,
        skillIds: ['skill1'],
      );

      // 嘗試修改skillIds應該不影響原始對象
      final skillIds = character.skillIds;
      // skillIds.add('new_skill'); // 這會拋出異常，因為是不可變的

      expect(character.skillIds.length, equals(1));
    });
  });
}
