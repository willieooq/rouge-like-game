// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkillData _$SkillDataFromJson(Map<String, dynamic> json) => _SkillData(
  id: json['id'] as String,
  name: json['name'] as String,
  cost: (json['cost'] as num).toInt(),
  damage: (json['damage'] as num).toInt(),
  description: json['description'] as String,
  element: json['element'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$SkillDataToJson(_SkillData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost': instance.cost,
      'damage': instance.damage,
      'description': instance.description,
      'element': instance.element,
      'type': instance.type,
    };
