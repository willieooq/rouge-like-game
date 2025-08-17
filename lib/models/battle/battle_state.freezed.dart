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

 List<Character> get party; int get currentTurnCost;// @Default = Java的default value
 int get maxTurnCost; bool get isPlayerTurn; int get turnNumber;
/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BattleStateCopyWith<BattleState> get copyWith => _$BattleStateCopyWithImpl<BattleState>(this as BattleState, _$identity);

  /// Serializes this BattleState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BattleState&&const DeepCollectionEquality().equals(other.party, party)&&(identical(other.currentTurnCost, currentTurnCost) || other.currentTurnCost == currentTurnCost)&&(identical(other.maxTurnCost, maxTurnCost) || other.maxTurnCost == maxTurnCost)&&(identical(other.isPlayerTurn, isPlayerTurn) || other.isPlayerTurn == isPlayerTurn)&&(identical(other.turnNumber, turnNumber) || other.turnNumber == turnNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(party),currentTurnCost,maxTurnCost,isPlayerTurn,turnNumber);

@override
String toString() {
  return 'BattleState(party: $party, currentTurnCost: $currentTurnCost, maxTurnCost: $maxTurnCost, isPlayerTurn: $isPlayerTurn, turnNumber: $turnNumber)';
}


}

/// @nodoc
abstract mixin class $BattleStateCopyWith<$Res>  {
  factory $BattleStateCopyWith(BattleState value, $Res Function(BattleState) _then) = _$BattleStateCopyWithImpl;
@useResult
$Res call({
 List<Character> party, int currentTurnCost, int maxTurnCost, bool isPlayerTurn, int turnNumber
});




}
/// @nodoc
class _$BattleStateCopyWithImpl<$Res>
    implements $BattleStateCopyWith<$Res> {
  _$BattleStateCopyWithImpl(this._self, this._then);

  final BattleState _self;
  final $Res Function(BattleState) _then;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? party = null,Object? currentTurnCost = null,Object? maxTurnCost = null,Object? isPlayerTurn = null,Object? turnNumber = null,}) {
  return _then(_self.copyWith(
party: null == party ? _self.party : party // ignore: cast_nullable_to_non_nullable
as List<Character>,currentTurnCost: null == currentTurnCost ? _self.currentTurnCost : currentTurnCost // ignore: cast_nullable_to_non_nullable
as int,maxTurnCost: null == maxTurnCost ? _self.maxTurnCost : maxTurnCost // ignore: cast_nullable_to_non_nullable
as int,isPlayerTurn: null == isPlayerTurn ? _self.isPlayerTurn : isPlayerTurn // ignore: cast_nullable_to_non_nullable
as bool,turnNumber: null == turnNumber ? _self.turnNumber : turnNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Character> party,  int currentTurnCost,  int maxTurnCost,  bool isPlayerTurn,  int turnNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that.party,_that.currentTurnCost,_that.maxTurnCost,_that.isPlayerTurn,_that.turnNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Character> party,  int currentTurnCost,  int maxTurnCost,  bool isPlayerTurn,  int turnNumber)  $default,) {final _that = this;
switch (_that) {
case _BattleState():
return $default(_that.party,_that.currentTurnCost,_that.maxTurnCost,_that.isPlayerTurn,_that.turnNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Character> party,  int currentTurnCost,  int maxTurnCost,  bool isPlayerTurn,  int turnNumber)?  $default,) {final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that.party,_that.currentTurnCost,_that.maxTurnCost,_that.isPlayerTurn,_that.turnNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BattleState extends BattleState {
  const _BattleState({required final  List<Character> party, this.currentTurnCost = 6, this.maxTurnCost = 6, this.isPlayerTurn = true, this.turnNumber = 1}): _party = party,super._();
  factory _BattleState.fromJson(Map<String, dynamic> json) => _$BattleStateFromJson(json);

 final  List<Character> _party;
@override List<Character> get party {
  if (_party is EqualUnmodifiableListView) return _party;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_party);
}

@override@JsonKey() final  int currentTurnCost;
// @Default = Java的default value
@override@JsonKey() final  int maxTurnCost;
@override@JsonKey() final  bool isPlayerTurn;
@override@JsonKey() final  int turnNumber;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BattleStateCopyWith<_BattleState> get copyWith => __$BattleStateCopyWithImpl<_BattleState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BattleStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BattleState&&const DeepCollectionEquality().equals(other._party, _party)&&(identical(other.currentTurnCost, currentTurnCost) || other.currentTurnCost == currentTurnCost)&&(identical(other.maxTurnCost, maxTurnCost) || other.maxTurnCost == maxTurnCost)&&(identical(other.isPlayerTurn, isPlayerTurn) || other.isPlayerTurn == isPlayerTurn)&&(identical(other.turnNumber, turnNumber) || other.turnNumber == turnNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_party),currentTurnCost,maxTurnCost,isPlayerTurn,turnNumber);

@override
String toString() {
  return 'BattleState(party: $party, currentTurnCost: $currentTurnCost, maxTurnCost: $maxTurnCost, isPlayerTurn: $isPlayerTurn, turnNumber: $turnNumber)';
}


}

/// @nodoc
abstract mixin class _$BattleStateCopyWith<$Res> implements $BattleStateCopyWith<$Res> {
  factory _$BattleStateCopyWith(_BattleState value, $Res Function(_BattleState) _then) = __$BattleStateCopyWithImpl;
@override @useResult
$Res call({
 List<Character> party, int currentTurnCost, int maxTurnCost, bool isPlayerTurn, int turnNumber
});




}
/// @nodoc
class __$BattleStateCopyWithImpl<$Res>
    implements _$BattleStateCopyWith<$Res> {
  __$BattleStateCopyWithImpl(this._self, this._then);

  final _BattleState _self;
  final $Res Function(_BattleState) _then;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? party = null,Object? currentTurnCost = null,Object? maxTurnCost = null,Object? isPlayerTurn = null,Object? turnNumber = null,}) {
  return _then(_BattleState(
party: null == party ? _self._party : party // ignore: cast_nullable_to_non_nullable
as List<Character>,currentTurnCost: null == currentTurnCost ? _self.currentTurnCost : currentTurnCost // ignore: cast_nullable_to_non_nullable
as int,maxTurnCost: null == maxTurnCost ? _self.maxTurnCost : maxTurnCost // ignore: cast_nullable_to_non_nullable
as int,isPlayerTurn: null == isPlayerTurn ? _self.isPlayerTurn : isPlayerTurn // ignore: cast_nullable_to_non_nullable
as bool,turnNumber: null == turnNumber ? _self.turnNumber : turnNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
