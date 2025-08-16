import '../models/character/character.dart';
import '../models/character/mastery.dart';

class TestCharacters {
  static const List<Character> defaultParty = [
    Character(
      id: 'warrior',
      name: '戰士',
      attackPower: 120,
      skillIds: ['slash', 'heavy_strike'],
      mastery: Mastery.fire, // 火屬性戰士
    ),
    Character(
      id: 'mage',
      name: '法師',
      attackPower: 100,
      skillIds: ['fireball', 'heal'],
      mastery: Mastery.ice, // 冰屬性法師
    ),
    Character(
      id: 'archer',
      name: '弓手',
      attackPower: 110,
      skillIds: ['quick_shot', 'power_shot'],
      mastery: Mastery.wind, // 風屬性弓手
    ),
    Character(
      id: 'rogue',
      name: '盜賊',
      attackPower: 130,
      skillIds: ['backstab', 'smoke'],
      mastery: Mastery.dark, // 闇屬性盜賊
    ),
    Character(
      id: 'priest',
      name: '牧師',
      attackPower: 80,
      skillIds: ['blessing', 'divine_light'],
      mastery: Mastery.light, // 光屬性牧師
    ),
  ];
}
