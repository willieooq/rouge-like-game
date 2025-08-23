// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Skills _$SkillsFromJson(Map<String, dynamic> json) => _Skills(
  id: json['id'] as String,
  name: json['name'] as String,
  cost: (json['cost'] as num).toInt(),
  damage: (json['damage'] as num).toInt(),
  description: json['description'] as String,
  element: json['element'] as String,
  type: json['type'] as String,
  damageMultiplier: (json['damageMultiplier'] as num?)?.toDouble() ?? 0.0,
  statusEffects:
      (json['statusEffects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isAOE: json['isAOE'] as bool? ?? false,
  defaultTarget: json['defaultTarget'] as String? ?? "enemy",
);

Map<String, dynamic> _$SkillsToJson(_Skills instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'cost': instance.cost,
  'damage': instance.damage,
  'description': instance.description,
  'element': instance.element,
  'type': instance.type,
  'damageMultiplier': instance.damageMultiplier,
  'statusEffects': instance.statusEffects,
  'isAOE': instance.isAOE,
  'defaultTarget': instance.defaultTarget,
};
