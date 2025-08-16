// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkillData {

 String get id; String get name; int get cost; int get damage; String get description; String get element;// 技能屬性
 String get type;
/// Create a copy of SkillData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillDataCopyWith<SkillData> get copyWith => _$SkillDataCopyWithImpl<SkillData>(this as SkillData, _$identity);

  /// Serializes this SkillData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.damage, damage) || other.damage == damage)&&(identical(other.description, description) || other.description == description)&&(identical(other.element, element) || other.element == element)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,cost,damage,description,element,type);

@override
String toString() {
  return 'SkillData(id: $id, name: $name, cost: $cost, damage: $damage, description: $description, element: $element, type: $type)';
}


}

/// @nodoc
abstract mixin class $SkillDataCopyWith<$Res>  {
  factory $SkillDataCopyWith(SkillData value, $Res Function(SkillData) _then) = _$SkillDataCopyWithImpl;
@useResult
$Res call({
 String id, String name, int cost, int damage, String description, String element, String type
});




}
/// @nodoc
class _$SkillDataCopyWithImpl<$Res>
    implements $SkillDataCopyWith<$Res> {
  _$SkillDataCopyWithImpl(this._self, this._then);

  final SkillData _self;
  final $Res Function(SkillData) _then;

/// Create a copy of SkillData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? cost = null,Object? damage = null,Object? description = null,Object? element = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,damage: null == damage ? _self.damage : damage // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillData].
extension SkillDataPatterns on SkillData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillData value)  $default,){
final _that = this;
switch (_that) {
case _SkillData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillData value)?  $default,){
final _that = this;
switch (_that) {
case _SkillData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int cost,  int damage,  String description,  String element,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillData() when $default != null:
return $default(_that.id,_that.name,_that.cost,_that.damage,_that.description,_that.element,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int cost,  int damage,  String description,  String element,  String type)  $default,) {final _that = this;
switch (_that) {
case _SkillData():
return $default(_that.id,_that.name,_that.cost,_that.damage,_that.description,_that.element,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int cost,  int damage,  String description,  String element,  String type)?  $default,) {final _that = this;
switch (_that) {
case _SkillData() when $default != null:
return $default(_that.id,_that.name,_that.cost,_that.damage,_that.description,_that.element,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillData implements SkillData {
  const _SkillData({required this.id, required this.name, required this.cost, required this.damage, required this.description, required this.element, required this.type});
  factory _SkillData.fromJson(Map<String, dynamic> json) => _$SkillDataFromJson(json);

@override final  String id;
@override final  String name;
@override final  int cost;
@override final  int damage;
@override final  String description;
@override final  String element;
// 技能屬性
@override final  String type;

/// Create a copy of SkillData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillDataCopyWith<_SkillData> get copyWith => __$SkillDataCopyWithImpl<_SkillData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.damage, damage) || other.damage == damage)&&(identical(other.description, description) || other.description == description)&&(identical(other.element, element) || other.element == element)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,cost,damage,description,element,type);

@override
String toString() {
  return 'SkillData(id: $id, name: $name, cost: $cost, damage: $damage, description: $description, element: $element, type: $type)';
}


}

/// @nodoc
abstract mixin class _$SkillDataCopyWith<$Res> implements $SkillDataCopyWith<$Res> {
  factory _$SkillDataCopyWith(_SkillData value, $Res Function(_SkillData) _then) = __$SkillDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int cost, int damage, String description, String element, String type
});




}
/// @nodoc
class __$SkillDataCopyWithImpl<$Res>
    implements _$SkillDataCopyWith<$Res> {
  __$SkillDataCopyWithImpl(this._self, this._then);

  final _SkillData _self;
  final $Res Function(_SkillData) _then;

/// Create a copy of SkillData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? cost = null,Object? damage = null,Object? description = null,Object? element = null,Object? type = null,}) {
  return _then(_SkillData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,damage: null == damage ? _self.damage : damage // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
