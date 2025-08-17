// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Character _$CharacterFromJson(Map<String, dynamic> json) => _Character(
  id: json['id'] as String,
  name: json['name'] as String,
  mastery: $enumDecode(_$MasteryEnumMap, json['mastery']),
  attackPower: (json['attackPower'] as num).toInt(),
  skillIds: (json['skillIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CharacterToJson(_Character instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mastery': _$MasteryEnumMap[instance.mastery]!,
      'attackPower': instance.attackPower,
      'skillIds': instance.skillIds,
    };

const _$MasteryEnumMap = {
  Mastery.fire: 'fire',
  Mastery.ice: 'ice',
  Mastery.thunder: 'thunder',
  Mastery.none: 'none',
  Mastery.light: 'light',
  Mastery.dark: 'dark',
  Mastery.earth: 'earth',
  Mastery.wind: 'wind',
};
