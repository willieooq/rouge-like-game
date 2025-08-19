// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_effect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatusEffect _$StatusEffectFromJson(
  Map<String, dynamic> json,
) => _StatusEffect(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$StatusTypeEnumMap, json['type']),
  maxDuration: (json['maxDuration'] as num).toInt(),
  currentDuration: (json['currentDuration'] as num).toInt(),
  maxStacks: (json['maxStacks'] as num).toInt(),
  currentStacks: (json['currentStacks'] as num).toInt(),
  isStackable: json['isStackable'] as bool? ?? false,
  isRefreshable: json['isRefreshable'] as bool? ?? false,
  isDispellable: json['isDispellable'] as bool? ?? false,
  isRemovable: json['isRemovable'] as bool? ?? true,
  isDetonable: json['isDetonable'] as bool? ?? false,
  scope:
      $enumDecodeNullable(_$StatusScopeEnumMap, json['scope']) ??
      StatusScope.battleOnly,
  attributeModifiers: (json['attributeModifiers'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry($enumDecode(_$AttributeTypeEnumMap, k), (e as num).toDouble()),
  ),
  dotDamage: (json['dotDamage'] as num?)?.toInt() ?? 0,
  hotHealing: (json['hotHealing'] as num?)?.toInt() ?? 0,
  detonationMultiplier: (json['detonationMultiplier'] as num?)?.toDouble() ?? 0,
  triggers:
      (json['triggers'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$StatusTriggerEnumMap, e))
          .toList() ??
      const [],
  color: json['color'] as String? ?? '#FFFFFF',
  iconPath: json['iconPath'] as String? ?? '',
);

Map<String, dynamic> _$StatusEffectToJson(
  _StatusEffect instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': _$StatusTypeEnumMap[instance.type]!,
  'maxDuration': instance.maxDuration,
  'currentDuration': instance.currentDuration,
  'maxStacks': instance.maxStacks,
  'currentStacks': instance.currentStacks,
  'isStackable': instance.isStackable,
  'isRefreshable': instance.isRefreshable,
  'isDispellable': instance.isDispellable,
  'isRemovable': instance.isRemovable,
  'isDetonable': instance.isDetonable,
  'scope': _$StatusScopeEnumMap[instance.scope]!,
  'attributeModifiers': instance.attributeModifiers.map(
    (k, e) => MapEntry(_$AttributeTypeEnumMap[k]!, e),
  ),
  'dotDamage': instance.dotDamage,
  'hotHealing': instance.hotHealing,
  'detonationMultiplier': instance.detonationMultiplier,
  'triggers': instance.triggers.map((e) => _$StatusTriggerEnumMap[e]!).toList(),
  'color': instance.color,
  'iconPath': instance.iconPath,
};

const _$StatusTypeEnumMap = {
  StatusType.buff: 'buff',
  StatusType.debuff: 'debuff',
  StatusType.dot: 'dot',
  StatusType.hot: 'hot',
  StatusType.special: 'special',
};

const _$StatusScopeEnumMap = {
  StatusScope.battleOnly: 'battle_only',
  StatusScope.global: 'global',
};

const _$AttributeTypeEnumMap = {
  AttributeType.attack: 'attack',
  AttributeType.defense: 'defense',
  AttributeType.speed: 'speed',
  AttributeType.hp: 'hp',
  AttributeType.critRate: 'crit_rate',
  AttributeType.critDamage: 'crit_damage',
};

const _$StatusTriggerEnumMap = {
  StatusTrigger.turnStart: 'turn_start',
  StatusTrigger.turnEnd: 'turn_end',
  StatusTrigger.onAttack: 'on_attack',
  StatusTrigger.onDamaged: 'on_damaged',
  StatusTrigger.onHealed: 'on_healed',
  StatusTrigger.onDeath: 'on_death',
};

_StatusTemplate _$StatusTemplateFromJson(
  Map<String, dynamic> json,
) => _StatusTemplate(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$StatusTypeEnumMap, json['type']),
  baseDuration: (json['baseDuration'] as num).toInt(),
  maxStacks: (json['maxStacks'] as num).toInt(),
  isStackable: json['isStackable'] as bool? ?? true,
  isRefreshable: json['isRefreshable'] as bool? ?? true,
  isDispellable: json['isDispellable'] as bool? ?? true,
  isRemovable: json['isRemovable'] as bool? ?? true,
  isDetonable: json['isDetonable'] as bool? ?? false,
  scope:
      $enumDecodeNullable(_$StatusScopeEnumMap, json['scope']) ??
      StatusScope.battleOnly,
  attributePerStack: (json['attributePerStack'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry($enumDecode(_$AttributeTypeEnumMap, k), (e as num).toDouble()),
  ),
  dotDamagePerStack: (json['dotDamagePerStack'] as num?)?.toInt() ?? 0,
  hotHealingPerStack: (json['hotHealingPerStack'] as num?)?.toInt() ?? 0,
  detonationMultiplier:
      (json['detonationMultiplier'] as num?)?.toDouble() ?? 1.0,
  triggers:
      (json['triggers'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$StatusTriggerEnumMap, e))
          .toList() ??
      const [],
  color: json['color'] as String? ?? '#FFFFFF',
  iconPath: json['iconPath'] as String? ?? '',
);

Map<String, dynamic> _$StatusTemplateToJson(
  _StatusTemplate instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': _$StatusTypeEnumMap[instance.type]!,
  'baseDuration': instance.baseDuration,
  'maxStacks': instance.maxStacks,
  'isStackable': instance.isStackable,
  'isRefreshable': instance.isRefreshable,
  'isDispellable': instance.isDispellable,
  'isRemovable': instance.isRemovable,
  'isDetonable': instance.isDetonable,
  'scope': _$StatusScopeEnumMap[instance.scope]!,
  'attributePerStack': instance.attributePerStack.map(
    (k, e) => MapEntry(_$AttributeTypeEnumMap[k]!, e),
  ),
  'dotDamagePerStack': instance.dotDamagePerStack,
  'hotHealingPerStack': instance.hotHealingPerStack,
  'detonationMultiplier': instance.detonationMultiplier,
  'triggers': instance.triggers.map((e) => _$StatusTriggerEnumMap[e]!).toList(),
  'color': instance.color,
  'iconPath': instance.iconPath,
};
