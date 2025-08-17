// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Skill _$SkillFromJson(Map<String, dynamic> json) => _Skill(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  cost: (json['cost'] as num).toInt(),
  baseDamage: (json['baseDamage'] as num).toInt(),
  element: json['element'] as String,
  type: $enumDecode(_$SkillTypeEnumMap, json['type']),
);

Map<String, dynamic> _$SkillToJson(_Skill instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'cost': instance.cost,
  'baseDamage': instance.baseDamage,
  'element': instance.element,
  'type': _$SkillTypeEnumMap[instance.type]!,
};

const _$SkillTypeEnumMap = {
  SkillType.attack: 'attack',
  SkillType.heal: 'heal',
  SkillType.support: 'support',
};
