// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Party {

 List<Character> get characters;// 5個角色
 int get sharedHp;// 共享生命值
 int get maxHp;// 最大生命值
 int get currentTurnCost;// 當前回合Cost
 int get maxTurnCost;
/// Create a copy of Party
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartyCopyWith<Party> get copyWith => _$PartyCopyWithImpl<Party>(this as Party, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Party&&const DeepCollectionEquality().equals(other.characters, characters)&&(identical(other.sharedHp, sharedHp) || other.sharedHp == sharedHp)&&(identical(other.maxHp, maxHp) || other.maxHp == maxHp)&&(identical(other.currentTurnCost, currentTurnCost) || other.currentTurnCost == currentTurnCost)&&(identical(other.maxTurnCost, maxTurnCost) || other.maxTurnCost == maxTurnCost));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(characters),sharedHp,maxHp,currentTurnCost,maxTurnCost);

@override
String toString() {
  return 'Party(characters: $characters, sharedHp: $sharedHp, maxHp: $maxHp, currentTurnCost: $currentTurnCost, maxTurnCost: $maxTurnCost)';
}


}

/// @nodoc
abstract mixin class $PartyCopyWith<$Res>  {
  factory $PartyCopyWith(Party value, $Res Function(Party) _then) = _$PartyCopyWithImpl;
@useResult
$Res call({
 List<Character> characters, int sharedHp, int maxHp, int currentTurnCost, int maxTurnCost
});




}
/// @nodoc
class _$PartyCopyWithImpl<$Res>
    implements $PartyCopyWith<$Res> {
  _$PartyCopyWithImpl(this._self, this._then);

  final Party _self;
  final $Res Function(Party) _then;

/// Create a copy of Party
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? characters = null,Object? sharedHp = null,Object? maxHp = null,Object? currentTurnCost = null,Object? maxTurnCost = null,}) {
  return _then(_self.copyWith(
characters: null == characters ? _self.characters : characters // ignore: cast_nullable_to_non_nullable
as List<Character>,sharedHp: null == sharedHp ? _self.sharedHp : sharedHp // ignore: cast_nullable_to_non_nullable
as int,maxHp: null == maxHp ? _self.maxHp : maxHp // ignore: cast_nullable_to_non_nullable
as int,currentTurnCost: null == currentTurnCost ? _self.currentTurnCost : currentTurnCost // ignore: cast_nullable_to_non_nullable
as int,maxTurnCost: null == maxTurnCost ? _self.maxTurnCost : maxTurnCost // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Party].
extension PartyPatterns on Party {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Party value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Party() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Party value)  $default,){
final _that = this;
switch (_that) {
case _Party():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Party value)?  $default,){
final _that = this;
switch (_that) {
case _Party() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Character> characters,  int sharedHp,  int maxHp,  int currentTurnCost,  int maxTurnCost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Party() when $default != null:
return $default(_that.characters,_that.sharedHp,_that.maxHp,_that.currentTurnCost,_that.maxTurnCost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Character> characters,  int sharedHp,  int maxHp,  int currentTurnCost,  int maxTurnCost)  $default,) {final _that = this;
switch (_that) {
case _Party():
return $default(_that.characters,_that.sharedHp,_that.maxHp,_that.currentTurnCost,_that.maxTurnCost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Character> characters,  int sharedHp,  int maxHp,  int currentTurnCost,  int maxTurnCost)?  $default,) {final _that = this;
switch (_that) {
case _Party() when $default != null:
return $default(_that.characters,_that.sharedHp,_that.maxHp,_that.currentTurnCost,_that.maxTurnCost);case _:
  return null;

}
}

}

/// @nodoc


class _Party implements Party {
  const _Party({required final  List<Character> characters, required this.sharedHp, required this.maxHp, required this.currentTurnCost, required this.maxTurnCost}): _characters = characters;
  

 final  List<Character> _characters;
@override List<Character> get characters {
  if (_characters is EqualUnmodifiableListView) return _characters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_characters);
}

// 5個角色
@override final  int sharedHp;
// 共享生命值
@override final  int maxHp;
// 最大生命值
@override final  int currentTurnCost;
// 當前回合Cost
@override final  int maxTurnCost;

/// Create a copy of Party
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartyCopyWith<_Party> get copyWith => __$PartyCopyWithImpl<_Party>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Party&&const DeepCollectionEquality().equals(other._characters, _characters)&&(identical(other.sharedHp, sharedHp) || other.sharedHp == sharedHp)&&(identical(other.maxHp, maxHp) || other.maxHp == maxHp)&&(identical(other.currentTurnCost, currentTurnCost) || other.currentTurnCost == currentTurnCost)&&(identical(other.maxTurnCost, maxTurnCost) || other.maxTurnCost == maxTurnCost));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_characters),sharedHp,maxHp,currentTurnCost,maxTurnCost);

@override
String toString() {
  return 'Party(characters: $characters, sharedHp: $sharedHp, maxHp: $maxHp, currentTurnCost: $currentTurnCost, maxTurnCost: $maxTurnCost)';
}


}

/// @nodoc
abstract mixin class _$PartyCopyWith<$Res> implements $PartyCopyWith<$Res> {
  factory _$PartyCopyWith(_Party value, $Res Function(_Party) _then) = __$PartyCopyWithImpl;
@override @useResult
$Res call({
 List<Character> characters, int sharedHp, int maxHp, int currentTurnCost, int maxTurnCost
});




}
/// @nodoc
class __$PartyCopyWithImpl<$Res>
    implements _$PartyCopyWith<$Res> {
  __$PartyCopyWithImpl(this._self, this._then);

  final _Party _self;
  final $Res Function(_Party) _then;

/// Create a copy of Party
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? characters = null,Object? sharedHp = null,Object? maxHp = null,Object? currentTurnCost = null,Object? maxTurnCost = null,}) {
  return _then(_Party(
characters: null == characters ? _self._characters : characters // ignore: cast_nullable_to_non_nullable
as List<Character>,sharedHp: null == sharedHp ? _self.sharedHp : sharedHp // ignore: cast_nullable_to_non_nullable
as int,maxHp: null == maxHp ? _self.maxHp : maxHp // ignore: cast_nullable_to_non_nullable
as int,currentTurnCost: null == currentTurnCost ? _self.currentTurnCost : currentTurnCost // ignore: cast_nullable_to_non_nullable
as int,maxTurnCost: null == maxTurnCost ? _self.maxTurnCost : maxTurnCost // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
