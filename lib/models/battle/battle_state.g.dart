// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BattleState _$BattleStateFromJson(Map<String, dynamic> json) => _BattleState(
  party: (json['party'] as List<dynamic>)
      .map((e) => Character.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentTurnCost: (json['currentTurnCost'] as num?)?.toInt() ?? 6,
  maxTurnCost: (json['maxTurnCost'] as num?)?.toInt() ?? 6,
  isPlayerTurn: json['isPlayerTurn'] as bool? ?? true,
  turnNumber: (json['turnNumber'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$BattleStateToJson(_BattleState instance) =>
    <String, dynamic>{
      'party': instance.party,
      'currentTurnCost': instance.currentTurnCost,
      'maxTurnCost': instance.maxTurnCost,
      'isPlayerTurn': instance.isPlayerTurn,
      'turnNumber': instance.turnNumber,
    };
