// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EquipmentEffect _$EquipmentEffectFromJson(Map<String, dynamic> json) =>
    _EquipmentEffect(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      parameters: json['parameters'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$EquipmentEffectToJson(_EquipmentEffect instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'parameters': instance.parameters,
    };

_Equipment _$EquipmentFromJson(Map<String, dynamic> json) => _Equipment(
  id: json['id'] as String,
  name: json['name'] as String,
  rare: $enumDecode(_$RarityEnumMap, json['rare']),
  description: json['description'] as String,
  type: $enumDecode(_$EquipmentTypeEnumMap, json['type']),
  atk: (json['atk'] as num).toInt(),
  hp: (json['hp'] as num).toInt(),
  effect: (json['effect'] as List<dynamic>)
      .map((e) => EquipmentEffect.fromJson(e as Map<String, dynamic>))
      .toList(),
  price: (json['price'] as num).toInt(),
  iconPath: json['iconPath'] as String? ?? '',
  level: (json['level'] as num?)?.toInt() ?? 1,
  durability: (json['durability'] as num?)?.toInt() ?? 0,
  maxDurability: (json['maxDurability'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$EquipmentToJson(_Equipment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rare': _$RarityEnumMap[instance.rare]!,
      'description': instance.description,
      'type': _$EquipmentTypeEnumMap[instance.type]!,
      'atk': instance.atk,
      'hp': instance.hp,
      'effect': instance.effect,
      'price': instance.price,
      'iconPath': instance.iconPath,
      'level': instance.level,
      'durability': instance.durability,
      'maxDurability': instance.maxDurability,
    };

const _$RarityEnumMap = {
  Rarity.common: 'common',
  Rarity.uncommon: 'uncommon',
  Rarity.rare: 'rare',
  Rarity.epic: 'epic',
  Rarity.legendary: 'legendary',
};

const _$EquipmentTypeEnumMap = {
  EquipmentType.weapon: 'weapon',
  EquipmentType.armor: 'armor',
  EquipmentType.helmet: 'helmet',
  EquipmentType.gloves: 'gloves',
  EquipmentType.boots: 'boots',
  EquipmentType.accessory: 'accessory',
};
