// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_mode_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DisplayState {

 OperationMode get globalMode; Set<String> get skillModeCharacters;
/// Create a copy of DisplayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisplayStateCopyWith<DisplayState> get copyWith => _$DisplayStateCopyWithImpl<DisplayState>(this as DisplayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisplayState&&(identical(other.globalMode, globalMode) || other.globalMode == globalMode)&&const DeepCollectionEquality().equals(other.skillModeCharacters, skillModeCharacters));
}


@override
int get hashCode => Object.hash(runtimeType,globalMode,const DeepCollectionEquality().hash(skillModeCharacters));

@override
String toString() {
  return 'DisplayState(globalMode: $globalMode, skillModeCharacters: $skillModeCharacters)';
}


}

/// @nodoc
abstract mixin class $DisplayStateCopyWith<$Res>  {
  factory $DisplayStateCopyWith(DisplayState value, $Res Function(DisplayState) _then) = _$DisplayStateCopyWithImpl;
@useResult
$Res call({
 OperationMode globalMode, Set<String> skillModeCharacters
});




}
/// @nodoc
class _$DisplayStateCopyWithImpl<$Res>
    implements $DisplayStateCopyWith<$Res> {
  _$DisplayStateCopyWithImpl(this._self, this._then);

  final DisplayState _self;
  final $Res Function(DisplayState) _then;

/// Create a copy of DisplayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? globalMode = null,Object? skillModeCharacters = null,}) {
  return _then(_self.copyWith(
globalMode: null == globalMode ? _self.globalMode : globalMode // ignore: cast_nullable_to_non_nullable
as OperationMode,skillModeCharacters: null == skillModeCharacters ? _self.skillModeCharacters : skillModeCharacters // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DisplayState].
extension DisplayStatePatterns on DisplayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisplayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisplayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisplayState value)  $default,){
final _that = this;
switch (_that) {
case _DisplayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisplayState value)?  $default,){
final _that = this;
switch (_that) {
case _DisplayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OperationMode globalMode,  Set<String> skillModeCharacters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisplayState() when $default != null:
return $default(_that.globalMode,_that.skillModeCharacters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OperationMode globalMode,  Set<String> skillModeCharacters)  $default,) {final _that = this;
switch (_that) {
case _DisplayState():
return $default(_that.globalMode,_that.skillModeCharacters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OperationMode globalMode,  Set<String> skillModeCharacters)?  $default,) {final _that = this;
switch (_that) {
case _DisplayState() when $default != null:
return $default(_that.globalMode,_that.skillModeCharacters);case _:
  return null;

}
}

}

/// @nodoc


class _DisplayState implements DisplayState {
  const _DisplayState({required this.globalMode, required final  Set<String> skillModeCharacters}): _skillModeCharacters = skillModeCharacters;
  

@override final  OperationMode globalMode;
 final  Set<String> _skillModeCharacters;
@override Set<String> get skillModeCharacters {
  if (_skillModeCharacters is EqualUnmodifiableSetView) return _skillModeCharacters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_skillModeCharacters);
}


/// Create a copy of DisplayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisplayStateCopyWith<_DisplayState> get copyWith => __$DisplayStateCopyWithImpl<_DisplayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisplayState&&(identical(other.globalMode, globalMode) || other.globalMode == globalMode)&&const DeepCollectionEquality().equals(other._skillModeCharacters, _skillModeCharacters));
}


@override
int get hashCode => Object.hash(runtimeType,globalMode,const DeepCollectionEquality().hash(_skillModeCharacters));

@override
String toString() {
  return 'DisplayState(globalMode: $globalMode, skillModeCharacters: $skillModeCharacters)';
}


}

/// @nodoc
abstract mixin class _$DisplayStateCopyWith<$Res> implements $DisplayStateCopyWith<$Res> {
  factory _$DisplayStateCopyWith(_DisplayState value, $Res Function(_DisplayState) _then) = __$DisplayStateCopyWithImpl;
@override @useResult
$Res call({
 OperationMode globalMode, Set<String> skillModeCharacters
});




}
/// @nodoc
class __$DisplayStateCopyWithImpl<$Res>
    implements _$DisplayStateCopyWith<$Res> {
  __$DisplayStateCopyWithImpl(this._self, this._then);

  final _DisplayState _self;
  final $Res Function(_DisplayState) _then;

/// Create a copy of DisplayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? globalMode = null,Object? skillModeCharacters = null,}) {
  return _then(_DisplayState(
globalMode: null == globalMode ? _self.globalMode : globalMode // ignore: cast_nullable_to_non_nullable
as OperationMode,skillModeCharacters: null == skillModeCharacters ? _self._skillModeCharacters : skillModeCharacters // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
