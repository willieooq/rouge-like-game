// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Enemy _$EnemyFromJson(Map<String, dynamic> json) => _Enemy(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$EnemyTypeEnumMap, json['type']),
  aiBehavior: $enumDecode(_$AIBehaviorEnumMap, json['aiBehavior']),
  maxHp: (json['maxHp'] as num).toInt(),
  currentHp: (json['currentHp'] as num).toInt(),
  attack: (json['attack'] as num).toInt(),
  defense: (json['defense'] as num).toInt(),
  speed: (json['speed'] as num).toInt(),
  iconPath: json['iconPath'] as String,
  description: json['description'] as String,
  primaryColor: json['primaryColor'] as String? ?? '#8B0000',
  secondaryColor: json['secondaryColor'] as String? ?? '#FF6347',
  skillIds: (json['skillIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  statusEffects:
      (json['statusEffects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  aggressionLevel: (json['aggressionLevel'] as num?)?.toDouble() ?? 1.0,
  selfPreservation: (json['selfPreservation'] as num?)?.toDouble() ?? 0.5,
  expReward: (json['expReward'] as num?)?.toInt() ?? 0,
  goldReward: (json['goldReward'] as num?)?.toInt() ?? 0,
  lootTable:
      (json['lootTable'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  level: (json['level'] as num?)?.toInt() ?? 1,
  isBoss: json['isBoss'] as bool? ?? false,
);

Map<String, dynamic> _$EnemyToJson(_Enemy instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': _$EnemyTypeEnumMap[instance.type]!,
  'aiBehavior': _$AIBehaviorEnumMap[instance.aiBehavior]!,
  'maxHp': instance.maxHp,
  'currentHp': instance.currentHp,
  'attack': instance.attack,
  'defense': instance.defense,
  'speed': instance.speed,
  'iconPath': instance.iconPath,
  'description': instance.description,
  'primaryColor': instance.primaryColor,
  'secondaryColor': instance.secondaryColor,
  'skillIds': instance.skillIds,
  'statusEffects': instance.statusEffects,
  'aggressionLevel': instance.aggressionLevel,
  'selfPreservation': instance.selfPreservation,
  'expReward': instance.expReward,
  'goldReward': instance.goldReward,
  'lootTable': instance.lootTable,
  'level': instance.level,
  'isBoss': instance.isBoss,
};

const _$EnemyTypeEnumMap = {
  EnemyType.normal: 'normal',
  EnemyType.elite: 'elite',
  EnemyType.boss: 'boss',
};

const _$AIBehaviorEnumMap = {
  AIBehavior.aggressive: 'aggressive',
  AIBehavior.defensive: 'defensive',
  AIBehavior.balanced: 'balanced',
  AIBehavior.support: 'support',
};

_EnemyData _$EnemyDataFromJson(Map<String, dynamic> json) => _EnemyData(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$EnemyTypeEnumMap, json['type']),
  aiBehavior: $enumDecode(_$AIBehaviorEnumMap, json['aiBehavior']),
  baseHp: (json['baseHp'] as num).toInt(),
  baseAttack: (json['baseAttack'] as num).toInt(),
  baseDefense: (json['baseDefense'] as num).toInt(),
  baseSpeed: (json['baseSpeed'] as num).toInt(),
  iconPath: json['iconPath'] as String,
  description: json['description'] as String,
  primaryColor: json['primaryColor'] as String? ?? '#8B0000',
  secondaryColor: json['secondaryColor'] as String? ?? '#FF6347',
  skillIds: (json['skillIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  aggressionLevel: (json['aggressionLevel'] as num?)?.toDouble() ?? 1.0,
  selfPreservation: (json['selfPreservation'] as num?)?.toDouble() ?? 0.5,
  baseExpReward: (json['baseExpReward'] as num?)?.toInt() ?? 0,
  baseGoldReward: (json['baseGoldReward'] as num?)?.toInt() ?? 0,
  lootTable:
      (json['lootTable'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$EnemyDataToJson(_EnemyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$EnemyTypeEnumMap[instance.type]!,
      'aiBehavior': _$AIBehaviorEnumMap[instance.aiBehavior]!,
      'baseHp': instance.baseHp,
      'baseAttack': instance.baseAttack,
      'baseDefense': instance.baseDefense,
      'baseSpeed': instance.baseSpeed,
      'iconPath': instance.iconPath,
      'description': instance.description,
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'skillIds': instance.skillIds,
      'aggressionLevel': instance.aggressionLevel,
      'selfPreservation': instance.selfPreservation,
      'baseExpReward': instance.baseExpReward,
      'baseGoldReward': instance.baseGoldReward,
      'lootTable': instance.lootTable,
    };
