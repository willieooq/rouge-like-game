// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BattleState {

// 基本戰鬥狀態
 BattlePhase get currentPhase; BattleResult get result; int get turnNumber; bool get playerHasFirstTurn;// 參戰單位
 Party get party; Enemy get enemy;// 單個敵人
// 狀態效果管理器
 StatusEffectManager get playerStatusManager; StatusEffectManager get enemyStatusManager;// 敵人行動系統
 List<EnemyAction> get enemyActionQueue; int get currentEnemyActionIndex; EnemyAction? get selectedEnemyAction;// 戰鬥統計
 BattleStatistics get statistics;// 戰鬥設定
 bool get canEscape; double get baseEscapeChance;// 為了向後兼容添加的欄位
 Enemy? get selectedEnemy; Enemy? get targetedEnemy; Character? get selectedCharacter; int get currentActionPoints; int get maxActionPoints;
/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BattleStateCopyWith<BattleState> get copyWith => _$BattleStateCopyWithImpl<BattleState>(this as BattleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BattleState&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.result, result) || other.result == result)&&(identical(other.turnNumber, turnNumber) || other.turnNumber == turnNumber)&&(identical(other.playerHasFirstTurn, playerHasFirstTurn) || other.playerHasFirstTurn == playerHasFirstTurn)&&(identical(other.party, party) || other.party == party)&&(identical(other.enemy, enemy) || other.enemy == enemy)&&(identical(other.playerStatusManager, playerStatusManager) || other.playerStatusManager == playerStatusManager)&&(identical(other.enemyStatusManager, enemyStatusManager) || other.enemyStatusManager == enemyStatusManager)&&const DeepCollectionEquality().equals(other.enemyActionQueue, enemyActionQueue)&&(identical(other.currentEnemyActionIndex, currentEnemyActionIndex) || other.currentEnemyActionIndex == currentEnemyActionIndex)&&(identical(other.selectedEnemyAction, selectedEnemyAction) || other.selectedEnemyAction == selectedEnemyAction)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.canEscape, canEscape) || other.canEscape == canEscape)&&(identical(other.baseEscapeChance, baseEscapeChance) || other.baseEscapeChance == baseEscapeChance)&&(identical(other.selectedEnemy, selectedEnemy) || other.selectedEnemy == selectedEnemy)&&(identical(other.targetedEnemy, targetedEnemy) || other.targetedEnemy == targetedEnemy)&&(identical(other.selectedCharacter, selectedCharacter) || other.selectedCharacter == selectedCharacter)&&(identical(other.currentActionPoints, currentActionPoints) || other.currentActionPoints == currentActionPoints)&&(identical(other.maxActionPoints, maxActionPoints) || other.maxActionPoints == maxActionPoints));
}


@override
int get hashCode => Object.hashAll([runtimeType,currentPhase,result,turnNumber,playerHasFirstTurn,party,enemy,playerStatusManager,enemyStatusManager,const DeepCollectionEquality().hash(enemyActionQueue),currentEnemyActionIndex,selectedEnemyAction,statistics,canEscape,baseEscapeChance,selectedEnemy,targetedEnemy,selectedCharacter,currentActionPoints,maxActionPoints]);

@override
String toString() {
  return 'BattleState(currentPhase: $currentPhase, result: $result, turnNumber: $turnNumber, playerHasFirstTurn: $playerHasFirstTurn, party: $party, enemy: $enemy, playerStatusManager: $playerStatusManager, enemyStatusManager: $enemyStatusManager, enemyActionQueue: $enemyActionQueue, currentEnemyActionIndex: $currentEnemyActionIndex, selectedEnemyAction: $selectedEnemyAction, statistics: $statistics, canEscape: $canEscape, baseEscapeChance: $baseEscapeChance, selectedEnemy: $selectedEnemy, targetedEnemy: $targetedEnemy, selectedCharacter: $selectedCharacter, currentActionPoints: $currentActionPoints, maxActionPoints: $maxActionPoints)';
}


}

/// @nodoc
abstract mixin class $BattleStateCopyWith<$Res>  {
  factory $BattleStateCopyWith(BattleState value, $Res Function(BattleState) _then) = _$BattleStateCopyWithImpl;
@useResult
$Res call({
 BattlePhase currentPhase, BattleResult result, int turnNumber, bool playerHasFirstTurn, Party party, Enemy enemy, StatusEffectManager playerStatusManager, StatusEffectManager enemyStatusManager, List<EnemyAction> enemyActionQueue, int currentEnemyActionIndex, EnemyAction? selectedEnemyAction, BattleStatistics statistics, bool canEscape, double baseEscapeChance, Enemy? selectedEnemy, Enemy? targetedEnemy, Character? selectedCharacter, int currentActionPoints, int maxActionPoints
});


$PartyCopyWith<$Res> get party;$EnemyCopyWith<$Res> get enemy;$EnemyActionCopyWith<$Res>? get selectedEnemyAction;$BattleStatisticsCopyWith<$Res> get statistics;$EnemyCopyWith<$Res>? get selectedEnemy;$EnemyCopyWith<$Res>? get targetedEnemy;$CharacterCopyWith<$Res>? get selectedCharacter;

}
/// @nodoc
class _$BattleStateCopyWithImpl<$Res>
    implements $BattleStateCopyWith<$Res> {
  _$BattleStateCopyWithImpl(this._self, this._then);

  final BattleState _self;
  final $Res Function(BattleState) _then;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPhase = null,Object? result = null,Object? turnNumber = null,Object? playerHasFirstTurn = null,Object? party = null,Object? enemy = null,Object? playerStatusManager = null,Object? enemyStatusManager = null,Object? enemyActionQueue = null,Object? currentEnemyActionIndex = null,Object? selectedEnemyAction = freezed,Object? statistics = null,Object? canEscape = null,Object? baseEscapeChance = null,Object? selectedEnemy = freezed,Object? targetedEnemy = freezed,Object? selectedCharacter = freezed,Object? currentActionPoints = null,Object? maxActionPoints = null,}) {
  return _then(_self.copyWith(
currentPhase: null == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as BattlePhase,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as BattleResult,turnNumber: null == turnNumber ? _self.turnNumber : turnNumber // ignore: cast_nullable_to_non_nullable
as int,playerHasFirstTurn: null == playerHasFirstTurn ? _self.playerHasFirstTurn : playerHasFirstTurn // ignore: cast_nullable_to_non_nullable
as bool,party: null == party ? _self.party : party // ignore: cast_nullable_to_non_nullable
as Party,enemy: null == enemy ? _self.enemy : enemy // ignore: cast_nullable_to_non_nullable
as Enemy,playerStatusManager: null == playerStatusManager ? _self.playerStatusManager : playerStatusManager // ignore: cast_nullable_to_non_nullable
as StatusEffectManager,enemyStatusManager: null == enemyStatusManager ? _self.enemyStatusManager : enemyStatusManager // ignore: cast_nullable_to_non_nullable
as StatusEffectManager,enemyActionQueue: null == enemyActionQueue ? _self.enemyActionQueue : enemyActionQueue // ignore: cast_nullable_to_non_nullable
as List<EnemyAction>,currentEnemyActionIndex: null == currentEnemyActionIndex ? _self.currentEnemyActionIndex : currentEnemyActionIndex // ignore: cast_nullable_to_non_nullable
as int,selectedEnemyAction: freezed == selectedEnemyAction ? _self.selectedEnemyAction : selectedEnemyAction // ignore: cast_nullable_to_non_nullable
as EnemyAction?,statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as BattleStatistics,canEscape: null == canEscape ? _self.canEscape : canEscape // ignore: cast_nullable_to_non_nullable
as bool,baseEscapeChance: null == baseEscapeChance ? _self.baseEscapeChance : baseEscapeChance // ignore: cast_nullable_to_non_nullable
as double,selectedEnemy: freezed == selectedEnemy ? _self.selectedEnemy : selectedEnemy // ignore: cast_nullable_to_non_nullable
as Enemy?,targetedEnemy: freezed == targetedEnemy ? _self.targetedEnemy : targetedEnemy // ignore: cast_nullable_to_non_nullable
as Enemy?,selectedCharacter: freezed == selectedCharacter ? _self.selectedCharacter : selectedCharacter // ignore: cast_nullable_to_non_nullable
as Character?,currentActionPoints: null == currentActionPoints ? _self.currentActionPoints : currentActionPoints // ignore: cast_nullable_to_non_nullable
as int,maxActionPoints: null == maxActionPoints ? _self.maxActionPoints : maxActionPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartyCopyWith<$Res> get party {
  
  return $PartyCopyWith<$Res>(_self.party, (value) {
    return _then(_self.copyWith(party: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyCopyWith<$Res> get enemy {
  
  return $EnemyCopyWith<$Res>(_self.enemy, (value) {
    return _then(_self.copyWith(enemy: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyActionCopyWith<$Res>? get selectedEnemyAction {
    if (_self.selectedEnemyAction == null) {
    return null;
  }

  return $EnemyActionCopyWith<$Res>(_self.selectedEnemyAction!, (value) {
    return _then(_self.copyWith(selectedEnemyAction: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BattleStatisticsCopyWith<$Res> get statistics {
  
  return $BattleStatisticsCopyWith<$Res>(_self.statistics, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyCopyWith<$Res>? get selectedEnemy {
    if (_self.selectedEnemy == null) {
    return null;
  }

  return $EnemyCopyWith<$Res>(_self.selectedEnemy!, (value) {
    return _then(_self.copyWith(selectedEnemy: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyCopyWith<$Res>? get targetedEnemy {
    if (_self.targetedEnemy == null) {
    return null;
  }

  return $EnemyCopyWith<$Res>(_self.targetedEnemy!, (value) {
    return _then(_self.copyWith(targetedEnemy: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterCopyWith<$Res>? get selectedCharacter {
    if (_self.selectedCharacter == null) {
    return null;
  }

  return $CharacterCopyWith<$Res>(_self.selectedCharacter!, (value) {
    return _then(_self.copyWith(selectedCharacter: value));
  });
}
}


/// Adds pattern-matching-related methods to [BattleState].
extension BattleStatePatterns on BattleState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BattleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BattleState value)  $default,){
final _that = this;
switch (_that) {
case _BattleState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BattleState value)?  $default,){
final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BattlePhase currentPhase,  BattleResult result,  int turnNumber,  bool playerHasFirstTurn,  Party party,  Enemy enemy,  StatusEffectManager playerStatusManager,  StatusEffectManager enemyStatusManager,  List<EnemyAction> enemyActionQueue,  int currentEnemyActionIndex,  EnemyAction? selectedEnemyAction,  BattleStatistics statistics,  bool canEscape,  double baseEscapeChance,  Enemy? selectedEnemy,  Enemy? targetedEnemy,  Character? selectedCharacter,  int currentActionPoints,  int maxActionPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that.currentPhase,_that.result,_that.turnNumber,_that.playerHasFirstTurn,_that.party,_that.enemy,_that.playerStatusManager,_that.enemyStatusManager,_that.enemyActionQueue,_that.currentEnemyActionIndex,_that.selectedEnemyAction,_that.statistics,_that.canEscape,_that.baseEscapeChance,_that.selectedEnemy,_that.targetedEnemy,_that.selectedCharacter,_that.currentActionPoints,_that.maxActionPoints);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BattlePhase currentPhase,  BattleResult result,  int turnNumber,  bool playerHasFirstTurn,  Party party,  Enemy enemy,  StatusEffectManager playerStatusManager,  StatusEffectManager enemyStatusManager,  List<EnemyAction> enemyActionQueue,  int currentEnemyActionIndex,  EnemyAction? selectedEnemyAction,  BattleStatistics statistics,  bool canEscape,  double baseEscapeChance,  Enemy? selectedEnemy,  Enemy? targetedEnemy,  Character? selectedCharacter,  int currentActionPoints,  int maxActionPoints)  $default,) {final _that = this;
switch (_that) {
case _BattleState():
return $default(_that.currentPhase,_that.result,_that.turnNumber,_that.playerHasFirstTurn,_that.party,_that.enemy,_that.playerStatusManager,_that.enemyStatusManager,_that.enemyActionQueue,_that.currentEnemyActionIndex,_that.selectedEnemyAction,_that.statistics,_that.canEscape,_that.baseEscapeChance,_that.selectedEnemy,_that.targetedEnemy,_that.selectedCharacter,_that.currentActionPoints,_that.maxActionPoints);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BattlePhase currentPhase,  BattleResult result,  int turnNumber,  bool playerHasFirstTurn,  Party party,  Enemy enemy,  StatusEffectManager playerStatusManager,  StatusEffectManager enemyStatusManager,  List<EnemyAction> enemyActionQueue,  int currentEnemyActionIndex,  EnemyAction? selectedEnemyAction,  BattleStatistics statistics,  bool canEscape,  double baseEscapeChance,  Enemy? selectedEnemy,  Enemy? targetedEnemy,  Character? selectedCharacter,  int currentActionPoints,  int maxActionPoints)?  $default,) {final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that.currentPhase,_that.result,_that.turnNumber,_that.playerHasFirstTurn,_that.party,_that.enemy,_that.playerStatusManager,_that.enemyStatusManager,_that.enemyActionQueue,_that.currentEnemyActionIndex,_that.selectedEnemyAction,_that.statistics,_that.canEscape,_that.baseEscapeChance,_that.selectedEnemy,_that.targetedEnemy,_that.selectedCharacter,_that.currentActionPoints,_that.maxActionPoints);case _:
  return null;

}
}

}

/// @nodoc


class _BattleState implements BattleState {
  const _BattleState({required this.currentPhase, required this.result, required this.turnNumber, required this.playerHasFirstTurn, required this.party, required this.enemy, required this.playerStatusManager, required this.enemyStatusManager, required final  List<EnemyAction> enemyActionQueue, required this.currentEnemyActionIndex, this.selectedEnemyAction = null, required this.statistics, required this.canEscape, required this.baseEscapeChance, this.selectedEnemy = null, this.targetedEnemy = null, this.selectedCharacter = null, this.currentActionPoints = 3, this.maxActionPoints = 3}): _enemyActionQueue = enemyActionQueue;
  

// 基本戰鬥狀態
@override final  BattlePhase currentPhase;
@override final  BattleResult result;
@override final  int turnNumber;
@override final  bool playerHasFirstTurn;
// 參戰單位
@override final  Party party;
@override final  Enemy enemy;
// 單個敵人
// 狀態效果管理器
@override final  StatusEffectManager playerStatusManager;
@override final  StatusEffectManager enemyStatusManager;
// 敵人行動系統
 final  List<EnemyAction> _enemyActionQueue;
// 敵人行動系統
@override List<EnemyAction> get enemyActionQueue {
  if (_enemyActionQueue is EqualUnmodifiableListView) return _enemyActionQueue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_enemyActionQueue);
}

@override final  int currentEnemyActionIndex;
@override@JsonKey() final  EnemyAction? selectedEnemyAction;
// 戰鬥統計
@override final  BattleStatistics statistics;
// 戰鬥設定
@override final  bool canEscape;
@override final  double baseEscapeChance;
// 為了向後兼容添加的欄位
@override@JsonKey() final  Enemy? selectedEnemy;
@override@JsonKey() final  Enemy? targetedEnemy;
@override@JsonKey() final  Character? selectedCharacter;
@override@JsonKey() final  int currentActionPoints;
@override@JsonKey() final  int maxActionPoints;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BattleStateCopyWith<_BattleState> get copyWith => __$BattleStateCopyWithImpl<_BattleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BattleState&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.result, result) || other.result == result)&&(identical(other.turnNumber, turnNumber) || other.turnNumber == turnNumber)&&(identical(other.playerHasFirstTurn, playerHasFirstTurn) || other.playerHasFirstTurn == playerHasFirstTurn)&&(identical(other.party, party) || other.party == party)&&(identical(other.enemy, enemy) || other.enemy == enemy)&&(identical(other.playerStatusManager, playerStatusManager) || other.playerStatusManager == playerStatusManager)&&(identical(other.enemyStatusManager, enemyStatusManager) || other.enemyStatusManager == enemyStatusManager)&&const DeepCollectionEquality().equals(other._enemyActionQueue, _enemyActionQueue)&&(identical(other.currentEnemyActionIndex, currentEnemyActionIndex) || other.currentEnemyActionIndex == currentEnemyActionIndex)&&(identical(other.selectedEnemyAction, selectedEnemyAction) || other.selectedEnemyAction == selectedEnemyAction)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.canEscape, canEscape) || other.canEscape == canEscape)&&(identical(other.baseEscapeChance, baseEscapeChance) || other.baseEscapeChance == baseEscapeChance)&&(identical(other.selectedEnemy, selectedEnemy) || other.selectedEnemy == selectedEnemy)&&(identical(other.targetedEnemy, targetedEnemy) || other.targetedEnemy == targetedEnemy)&&(identical(other.selectedCharacter, selectedCharacter) || other.selectedCharacter == selectedCharacter)&&(identical(other.currentActionPoints, currentActionPoints) || other.currentActionPoints == currentActionPoints)&&(identical(other.maxActionPoints, maxActionPoints) || other.maxActionPoints == maxActionPoints));
}


@override
int get hashCode => Object.hashAll([runtimeType,currentPhase,result,turnNumber,playerHasFirstTurn,party,enemy,playerStatusManager,enemyStatusManager,const DeepCollectionEquality().hash(_enemyActionQueue),currentEnemyActionIndex,selectedEnemyAction,statistics,canEscape,baseEscapeChance,selectedEnemy,targetedEnemy,selectedCharacter,currentActionPoints,maxActionPoints]);

@override
String toString() {
  return 'BattleState(currentPhase: $currentPhase, result: $result, turnNumber: $turnNumber, playerHasFirstTurn: $playerHasFirstTurn, party: $party, enemy: $enemy, playerStatusManager: $playerStatusManager, enemyStatusManager: $enemyStatusManager, enemyActionQueue: $enemyActionQueue, currentEnemyActionIndex: $currentEnemyActionIndex, selectedEnemyAction: $selectedEnemyAction, statistics: $statistics, canEscape: $canEscape, baseEscapeChance: $baseEscapeChance, selectedEnemy: $selectedEnemy, targetedEnemy: $targetedEnemy, selectedCharacter: $selectedCharacter, currentActionPoints: $currentActionPoints, maxActionPoints: $maxActionPoints)';
}


}

/// @nodoc
abstract mixin class _$BattleStateCopyWith<$Res> implements $BattleStateCopyWith<$Res> {
  factory _$BattleStateCopyWith(_BattleState value, $Res Function(_BattleState) _then) = __$BattleStateCopyWithImpl;
@override @useResult
$Res call({
 BattlePhase currentPhase, BattleResult result, int turnNumber, bool playerHasFirstTurn, Party party, Enemy enemy, StatusEffectManager playerStatusManager, StatusEffectManager enemyStatusManager, List<EnemyAction> enemyActionQueue, int currentEnemyActionIndex, EnemyAction? selectedEnemyAction, BattleStatistics statistics, bool canEscape, double baseEscapeChance, Enemy? selectedEnemy, Enemy? targetedEnemy, Character? selectedCharacter, int currentActionPoints, int maxActionPoints
});


@override $PartyCopyWith<$Res> get party;@override $EnemyCopyWith<$Res> get enemy;@override $EnemyActionCopyWith<$Res>? get selectedEnemyAction;@override $BattleStatisticsCopyWith<$Res> get statistics;@override $EnemyCopyWith<$Res>? get selectedEnemy;@override $EnemyCopyWith<$Res>? get targetedEnemy;@override $CharacterCopyWith<$Res>? get selectedCharacter;

}
/// @nodoc
class __$BattleStateCopyWithImpl<$Res>
    implements _$BattleStateCopyWith<$Res> {
  __$BattleStateCopyWithImpl(this._self, this._then);

  final _BattleState _self;
  final $Res Function(_BattleState) _then;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPhase = null,Object? result = null,Object? turnNumber = null,Object? playerHasFirstTurn = null,Object? party = null,Object? enemy = null,Object? playerStatusManager = null,Object? enemyStatusManager = null,Object? enemyActionQueue = null,Object? currentEnemyActionIndex = null,Object? selectedEnemyAction = freezed,Object? statistics = null,Object? canEscape = null,Object? baseEscapeChance = null,Object? selectedEnemy = freezed,Object? targetedEnemy = freezed,Object? selectedCharacter = freezed,Object? currentActionPoints = null,Object? maxActionPoints = null,}) {
  return _then(_BattleState(
currentPhase: null == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as BattlePhase,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as BattleResult,turnNumber: null == turnNumber ? _self.turnNumber : turnNumber // ignore: cast_nullable_to_non_nullable
as int,playerHasFirstTurn: null == playerHasFirstTurn ? _self.playerHasFirstTurn : playerHasFirstTurn // ignore: cast_nullable_to_non_nullable
as bool,party: null == party ? _self.party : party // ignore: cast_nullable_to_non_nullable
as Party,enemy: null == enemy ? _self.enemy : enemy // ignore: cast_nullable_to_non_nullable
as Enemy,playerStatusManager: null == playerStatusManager ? _self.playerStatusManager : playerStatusManager // ignore: cast_nullable_to_non_nullable
as StatusEffectManager,enemyStatusManager: null == enemyStatusManager ? _self.enemyStatusManager : enemyStatusManager // ignore: cast_nullable_to_non_nullable
as StatusEffectManager,enemyActionQueue: null == enemyActionQueue ? _self._enemyActionQueue : enemyActionQueue // ignore: cast_nullable_to_non_nullable
as List<EnemyAction>,currentEnemyActionIndex: null == currentEnemyActionIndex ? _self.currentEnemyActionIndex : currentEnemyActionIndex // ignore: cast_nullable_to_non_nullable
as int,selectedEnemyAction: freezed == selectedEnemyAction ? _self.selectedEnemyAction : selectedEnemyAction // ignore: cast_nullable_to_non_nullable
as EnemyAction?,statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as BattleStatistics,canEscape: null == canEscape ? _self.canEscape : canEscape // ignore: cast_nullable_to_non_nullable
as bool,baseEscapeChance: null == baseEscapeChance ? _self.baseEscapeChance : baseEscapeChance // ignore: cast_nullable_to_non_nullable
as double,selectedEnemy: freezed == selectedEnemy ? _self.selectedEnemy : selectedEnemy // ignore: cast_nullable_to_non_nullable
as Enemy?,targetedEnemy: freezed == targetedEnemy ? _self.targetedEnemy : targetedEnemy // ignore: cast_nullable_to_non_nullable
as Enemy?,selectedCharacter: freezed == selectedCharacter ? _self.selectedCharacter : selectedCharacter // ignore: cast_nullable_to_non_nullable
as Character?,currentActionPoints: null == currentActionPoints ? _self.currentActionPoints : currentActionPoints // ignore: cast_nullable_to_non_nullable
as int,maxActionPoints: null == maxActionPoints ? _self.maxActionPoints : maxActionPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartyCopyWith<$Res> get party {
  
  return $PartyCopyWith<$Res>(_self.party, (value) {
    return _then(_self.copyWith(party: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyCopyWith<$Res> get enemy {
  
  return $EnemyCopyWith<$Res>(_self.enemy, (value) {
    return _then(_self.copyWith(enemy: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyActionCopyWith<$Res>? get selectedEnemyAction {
    if (_self.selectedEnemyAction == null) {
    return null;
  }

  return $EnemyActionCopyWith<$Res>(_self.selectedEnemyAction!, (value) {
    return _then(_self.copyWith(selectedEnemyAction: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BattleStatisticsCopyWith<$Res> get statistics {
  
  return $BattleStatisticsCopyWith<$Res>(_self.statistics, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyCopyWith<$Res>? get selectedEnemy {
    if (_self.selectedEnemy == null) {
    return null;
  }

  return $EnemyCopyWith<$Res>(_self.selectedEnemy!, (value) {
    return _then(_self.copyWith(selectedEnemy: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyCopyWith<$Res>? get targetedEnemy {
    if (_self.targetedEnemy == null) {
    return null;
  }

  return $EnemyCopyWith<$Res>(_self.targetedEnemy!, (value) {
    return _then(_self.copyWith(targetedEnemy: value));
  });
}/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterCopyWith<$Res>? get selectedCharacter {
    if (_self.selectedCharacter == null) {
    return null;
  }

  return $CharacterCopyWith<$Res>(_self.selectedCharacter!, (value) {
    return _then(_self.copyWith(selectedCharacter: value));
  });
}
}

/// @nodoc
mixin _$BattleStatistics {

 int get totalDamageDealt; int get totalDamageReceived; int get totalHealingReceived; List<String> get skillsUsed; int get statusEffectsApplied; int get turnCount;
/// Create a copy of BattleStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BattleStatisticsCopyWith<BattleStatistics> get copyWith => _$BattleStatisticsCopyWithImpl<BattleStatistics>(this as BattleStatistics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BattleStatistics&&(identical(other.totalDamageDealt, totalDamageDealt) || other.totalDamageDealt == totalDamageDealt)&&(identical(other.totalDamageReceived, totalDamageReceived) || other.totalDamageReceived == totalDamageReceived)&&(identical(other.totalHealingReceived, totalHealingReceived) || other.totalHealingReceived == totalHealingReceived)&&const DeepCollectionEquality().equals(other.skillsUsed, skillsUsed)&&(identical(other.statusEffectsApplied, statusEffectsApplied) || other.statusEffectsApplied == statusEffectsApplied)&&(identical(other.turnCount, turnCount) || other.turnCount == turnCount));
}


@override
int get hashCode => Object.hash(runtimeType,totalDamageDealt,totalDamageReceived,totalHealingReceived,const DeepCollectionEquality().hash(skillsUsed),statusEffectsApplied,turnCount);

@override
String toString() {
  return 'BattleStatistics(totalDamageDealt: $totalDamageDealt, totalDamageReceived: $totalDamageReceived, totalHealingReceived: $totalHealingReceived, skillsUsed: $skillsUsed, statusEffectsApplied: $statusEffectsApplied, turnCount: $turnCount)';
}


}

/// @nodoc
abstract mixin class $BattleStatisticsCopyWith<$Res>  {
  factory $BattleStatisticsCopyWith(BattleStatistics value, $Res Function(BattleStatistics) _then) = _$BattleStatisticsCopyWithImpl;
@useResult
$Res call({
 int totalDamageDealt, int totalDamageReceived, int totalHealingReceived, List<String> skillsUsed, int statusEffectsApplied, int turnCount
});




}
/// @nodoc
class _$BattleStatisticsCopyWithImpl<$Res>
    implements $BattleStatisticsCopyWith<$Res> {
  _$BattleStatisticsCopyWithImpl(this._self, this._then);

  final BattleStatistics _self;
  final $Res Function(BattleStatistics) _then;

/// Create a copy of BattleStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDamageDealt = null,Object? totalDamageReceived = null,Object? totalHealingReceived = null,Object? skillsUsed = null,Object? statusEffectsApplied = null,Object? turnCount = null,}) {
  return _then(_self.copyWith(
totalDamageDealt: null == totalDamageDealt ? _self.totalDamageDealt : totalDamageDealt // ignore: cast_nullable_to_non_nullable
as int,totalDamageReceived: null == totalDamageReceived ? _self.totalDamageReceived : totalDamageReceived // ignore: cast_nullable_to_non_nullable
as int,totalHealingReceived: null == totalHealingReceived ? _self.totalHealingReceived : totalHealingReceived // ignore: cast_nullable_to_non_nullable
as int,skillsUsed: null == skillsUsed ? _self.skillsUsed : skillsUsed // ignore: cast_nullable_to_non_nullable
as List<String>,statusEffectsApplied: null == statusEffectsApplied ? _self.statusEffectsApplied : statusEffectsApplied // ignore: cast_nullable_to_non_nullable
as int,turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BattleStatistics].
extension BattleStatisticsPatterns on BattleStatistics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BattleStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BattleStatistics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BattleStatistics value)  $default,){
final _that = this;
switch (_that) {
case _BattleStatistics():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BattleStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _BattleStatistics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalDamageDealt,  int totalDamageReceived,  int totalHealingReceived,  List<String> skillsUsed,  int statusEffectsApplied,  int turnCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BattleStatistics() when $default != null:
return $default(_that.totalDamageDealt,_that.totalDamageReceived,_that.totalHealingReceived,_that.skillsUsed,_that.statusEffectsApplied,_that.turnCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalDamageDealt,  int totalDamageReceived,  int totalHealingReceived,  List<String> skillsUsed,  int statusEffectsApplied,  int turnCount)  $default,) {final _that = this;
switch (_that) {
case _BattleStatistics():
return $default(_that.totalDamageDealt,_that.totalDamageReceived,_that.totalHealingReceived,_that.skillsUsed,_that.statusEffectsApplied,_that.turnCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalDamageDealt,  int totalDamageReceived,  int totalHealingReceived,  List<String> skillsUsed,  int statusEffectsApplied,  int turnCount)?  $default,) {final _that = this;
switch (_that) {
case _BattleStatistics() when $default != null:
return $default(_that.totalDamageDealt,_that.totalDamageReceived,_that.totalHealingReceived,_that.skillsUsed,_that.statusEffectsApplied,_that.turnCount);case _:
  return null;

}
}

}

/// @nodoc


class _BattleStatistics implements BattleStatistics {
  const _BattleStatistics({required this.totalDamageDealt, required this.totalDamageReceived, required this.totalHealingReceived, required final  List<String> skillsUsed, required this.statusEffectsApplied, required this.turnCount}): _skillsUsed = skillsUsed;
  

@override final  int totalDamageDealt;
@override final  int totalDamageReceived;
@override final  int totalHealingReceived;
 final  List<String> _skillsUsed;
@override List<String> get skillsUsed {
  if (_skillsUsed is EqualUnmodifiableListView) return _skillsUsed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skillsUsed);
}

@override final  int statusEffectsApplied;
@override final  int turnCount;

/// Create a copy of BattleStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BattleStatisticsCopyWith<_BattleStatistics> get copyWith => __$BattleStatisticsCopyWithImpl<_BattleStatistics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BattleStatistics&&(identical(other.totalDamageDealt, totalDamageDealt) || other.totalDamageDealt == totalDamageDealt)&&(identical(other.totalDamageReceived, totalDamageReceived) || other.totalDamageReceived == totalDamageReceived)&&(identical(other.totalHealingReceived, totalHealingReceived) || other.totalHealingReceived == totalHealingReceived)&&const DeepCollectionEquality().equals(other._skillsUsed, _skillsUsed)&&(identical(other.statusEffectsApplied, statusEffectsApplied) || other.statusEffectsApplied == statusEffectsApplied)&&(identical(other.turnCount, turnCount) || other.turnCount == turnCount));
}


@override
int get hashCode => Object.hash(runtimeType,totalDamageDealt,totalDamageReceived,totalHealingReceived,const DeepCollectionEquality().hash(_skillsUsed),statusEffectsApplied,turnCount);

@override
String toString() {
  return 'BattleStatistics(totalDamageDealt: $totalDamageDealt, totalDamageReceived: $totalDamageReceived, totalHealingReceived: $totalHealingReceived, skillsUsed: $skillsUsed, statusEffectsApplied: $statusEffectsApplied, turnCount: $turnCount)';
}


}

/// @nodoc
abstract mixin class _$BattleStatisticsCopyWith<$Res> implements $BattleStatisticsCopyWith<$Res> {
  factory _$BattleStatisticsCopyWith(_BattleStatistics value, $Res Function(_BattleStatistics) _then) = __$BattleStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int totalDamageDealt, int totalDamageReceived, int totalHealingReceived, List<String> skillsUsed, int statusEffectsApplied, int turnCount
});




}
/// @nodoc
class __$BattleStatisticsCopyWithImpl<$Res>
    implements _$BattleStatisticsCopyWith<$Res> {
  __$BattleStatisticsCopyWithImpl(this._self, this._then);

  final _BattleStatistics _self;
  final $Res Function(_BattleStatistics) _then;

/// Create a copy of BattleStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDamageDealt = null,Object? totalDamageReceived = null,Object? totalHealingReceived = null,Object? skillsUsed = null,Object? statusEffectsApplied = null,Object? turnCount = null,}) {
  return _then(_BattleStatistics(
totalDamageDealt: null == totalDamageDealt ? _self.totalDamageDealt : totalDamageDealt // ignore: cast_nullable_to_non_nullable
as int,totalDamageReceived: null == totalDamageReceived ? _self.totalDamageReceived : totalDamageReceived // ignore: cast_nullable_to_non_nullable
as int,totalHealingReceived: null == totalHealingReceived ? _self.totalHealingReceived : totalHealingReceived // ignore: cast_nullable_to_non_nullable
as int,skillsUsed: null == skillsUsed ? _self._skillsUsed : skillsUsed // ignore: cast_nullable_to_non_nullable
as List<String>,statusEffectsApplied: null == statusEffectsApplied ? _self.statusEffectsApplied : statusEffectsApplied // ignore: cast_nullable_to_non_nullable
as int,turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BattleSummary {

 BattleResult get result; int get turnCount; int get damageDealt; int get damageReceived; int get expGained; int get goldGained;
/// Create a copy of BattleSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BattleSummaryCopyWith<BattleSummary> get copyWith => _$BattleSummaryCopyWithImpl<BattleSummary>(this as BattleSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BattleSummary&&(identical(other.result, result) || other.result == result)&&(identical(other.turnCount, turnCount) || other.turnCount == turnCount)&&(identical(other.damageDealt, damageDealt) || other.damageDealt == damageDealt)&&(identical(other.damageReceived, damageReceived) || other.damageReceived == damageReceived)&&(identical(other.expGained, expGained) || other.expGained == expGained)&&(identical(other.goldGained, goldGained) || other.goldGained == goldGained));
}


@override
int get hashCode => Object.hash(runtimeType,result,turnCount,damageDealt,damageReceived,expGained,goldGained);

@override
String toString() {
  return 'BattleSummary(result: $result, turnCount: $turnCount, damageDealt: $damageDealt, damageReceived: $damageReceived, expGained: $expGained, goldGained: $goldGained)';
}


}

/// @nodoc
abstract mixin class $BattleSummaryCopyWith<$Res>  {
  factory $BattleSummaryCopyWith(BattleSummary value, $Res Function(BattleSummary) _then) = _$BattleSummaryCopyWithImpl;
@useResult
$Res call({
 BattleResult result, int turnCount, int damageDealt, int damageReceived, int expGained, int goldGained
});




}
/// @nodoc
class _$BattleSummaryCopyWithImpl<$Res>
    implements $BattleSummaryCopyWith<$Res> {
  _$BattleSummaryCopyWithImpl(this._self, this._then);

  final BattleSummary _self;
  final $Res Function(BattleSummary) _then;

/// Create a copy of BattleSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? turnCount = null,Object? damageDealt = null,Object? damageReceived = null,Object? expGained = null,Object? goldGained = null,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as BattleResult,turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,damageDealt: null == damageDealt ? _self.damageDealt : damageDealt // ignore: cast_nullable_to_non_nullable
as int,damageReceived: null == damageReceived ? _self.damageReceived : damageReceived // ignore: cast_nullable_to_non_nullable
as int,expGained: null == expGained ? _self.expGained : expGained // ignore: cast_nullable_to_non_nullable
as int,goldGained: null == goldGained ? _self.goldGained : goldGained // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BattleSummary].
extension BattleSummaryPatterns on BattleSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BattleSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BattleSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BattleSummary value)  $default,){
final _that = this;
switch (_that) {
case _BattleSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BattleSummary value)?  $default,){
final _that = this;
switch (_that) {
case _BattleSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BattleResult result,  int turnCount,  int damageDealt,  int damageReceived,  int expGained,  int goldGained)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BattleSummary() when $default != null:
return $default(_that.result,_that.turnCount,_that.damageDealt,_that.damageReceived,_that.expGained,_that.goldGained);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BattleResult result,  int turnCount,  int damageDealt,  int damageReceived,  int expGained,  int goldGained)  $default,) {final _that = this;
switch (_that) {
case _BattleSummary():
return $default(_that.result,_that.turnCount,_that.damageDealt,_that.damageReceived,_that.expGained,_that.goldGained);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BattleResult result,  int turnCount,  int damageDealt,  int damageReceived,  int expGained,  int goldGained)?  $default,) {final _that = this;
switch (_that) {
case _BattleSummary() when $default != null:
return $default(_that.result,_that.turnCount,_that.damageDealt,_that.damageReceived,_that.expGained,_that.goldGained);case _:
  return null;

}
}

}

/// @nodoc


class _BattleSummary implements BattleSummary {
  const _BattleSummary({required this.result, required this.turnCount, required this.damageDealt, required this.damageReceived, required this.expGained, required this.goldGained});
  

@override final  BattleResult result;
@override final  int turnCount;
@override final  int damageDealt;
@override final  int damageReceived;
@override final  int expGained;
@override final  int goldGained;

/// Create a copy of BattleSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BattleSummaryCopyWith<_BattleSummary> get copyWith => __$BattleSummaryCopyWithImpl<_BattleSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BattleSummary&&(identical(other.result, result) || other.result == result)&&(identical(other.turnCount, turnCount) || other.turnCount == turnCount)&&(identical(other.damageDealt, damageDealt) || other.damageDealt == damageDealt)&&(identical(other.damageReceived, damageReceived) || other.damageReceived == damageReceived)&&(identical(other.expGained, expGained) || other.expGained == expGained)&&(identical(other.goldGained, goldGained) || other.goldGained == goldGained));
}


@override
int get hashCode => Object.hash(runtimeType,result,turnCount,damageDealt,damageReceived,expGained,goldGained);

@override
String toString() {
  return 'BattleSummary(result: $result, turnCount: $turnCount, damageDealt: $damageDealt, damageReceived: $damageReceived, expGained: $expGained, goldGained: $goldGained)';
}


}

/// @nodoc
abstract mixin class _$BattleSummaryCopyWith<$Res> implements $BattleSummaryCopyWith<$Res> {
  factory _$BattleSummaryCopyWith(_BattleSummary value, $Res Function(_BattleSummary) _then) = __$BattleSummaryCopyWithImpl;
@override @useResult
$Res call({
 BattleResult result, int turnCount, int damageDealt, int damageReceived, int expGained, int goldGained
});




}
/// @nodoc
class __$BattleSummaryCopyWithImpl<$Res>
    implements _$BattleSummaryCopyWith<$Res> {
  __$BattleSummaryCopyWithImpl(this._self, this._then);

  final _BattleSummary _self;
  final $Res Function(_BattleSummary) _then;

/// Create a copy of BattleSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? turnCount = null,Object? damageDealt = null,Object? damageReceived = null,Object? expGained = null,Object? goldGained = null,}) {
  return _then(_BattleSummary(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as BattleResult,turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,damageDealt: null == damageDealt ? _self.damageDealt : damageDealt // ignore: cast_nullable_to_non_nullable
as int,damageReceived: null == damageReceived ? _self.damageReceived : damageReceived // ignore: cast_nullable_to_non_nullable
as int,expGained: null == expGained ? _self.expGained : expGained // ignore: cast_nullable_to_non_nullable
as int,goldGained: null == goldGained ? _self.goldGained : goldGained // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
