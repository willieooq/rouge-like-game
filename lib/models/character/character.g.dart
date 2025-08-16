// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Character _$CharacterFromJson(Map<String, dynamic> json) => _Character(
  id: json['id'] as String,
  name: json['name'] as String,
  maxCost: (json['maxCost'] as num).toInt(),
  currentCost: (json['currentCost'] as num).toInt(),
  attackPower: (json['attackPower'] as num).toInt(),
  skillIds: (json['skillIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CharacterToJson(_Character instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'maxCost': instance.maxCost,
      'currentCost': instance.currentCost,
      'attackPower': instance.attackPower,
      'skillIds': instance.skillIds,
    };
