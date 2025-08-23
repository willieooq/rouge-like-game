// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skills.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Skills {

 String get id; String get name; int get cost; int get damage; String get description; String get element; String get type;// "attack", "heal", "support"
// 新增技能相關屬性
 double get damageMultiplier;// 傷害倍率
 List<String> get statusEffects;// 附加的狀態效果ID
 bool get isAOE;// 是否為範圍攻擊
 String get defaultTarget;
/// Create a copy of Skills
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillsCopyWith<Skills> get copyWith => _$SkillsCopyWithImpl<Skills>(this as Skills, _$identity);

  /// Serializes this Skills to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Skills&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.damage, damage) || other.damage == damage)&&(identical(other.description, description) || other.description == description)&&(identical(other.element, element) || other.element == element)&&(identical(other.type, type) || other.type == type)&&(identical(other.damageMultiplier, damageMultiplier) || other.damageMultiplier == damageMultiplier)&&const DeepCollectionEquality().equals(other.statusEffects, statusEffects)&&(identical(other.isAOE, isAOE) || other.isAOE == isAOE)&&(identical(other.defaultTarget, defaultTarget) || other.defaultTarget == defaultTarget));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,cost,damage,description,element,type,damageMultiplier,const DeepCollectionEquality().hash(statusEffects),isAOE,defaultTarget);

@override
String toString() {
  return 'Skills(id: $id, name: $name, cost: $cost, damage: $damage, description: $description, element: $element, type: $type, damageMultiplier: $damageMultiplier, statusEffects: $statusEffects, isAOE: $isAOE, defaultTarget: $defaultTarget)';
}


}

/// @nodoc
abstract mixin class $SkillsCopyWith<$Res>  {
  factory $SkillsCopyWith(Skills value, $Res Function(Skills) _then) = _$SkillsCopyWithImpl;
@useResult
$Res call({
 String id, String name, int cost, int damage, String description, String element, String type, double damageMultiplier, List<String> statusEffects, bool isAOE, String defaultTarget
});




}
/// @nodoc
class _$SkillsCopyWithImpl<$Res>
    implements $SkillsCopyWith<$Res> {
  _$SkillsCopyWithImpl(this._self, this._then);

  final Skills _self;
  final $Res Function(Skills) _then;

/// Create a copy of Skills
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? cost = null,Object? damage = null,Object? description = null,Object? element = null,Object? type = null,Object? damageMultiplier = null,Object? statusEffects = null,Object? isAOE = null,Object? defaultTarget = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,damage: null == damage ? _self.damage : damage // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,damageMultiplier: null == damageMultiplier ? _self.damageMultiplier : damageMultiplier // ignore: cast_nullable_to_non_nullable
as double,statusEffects: null == statusEffects ? _self.statusEffects : statusEffects // ignore: cast_nullable_to_non_nullable
as List<String>,isAOE: null == isAOE ? _self.isAOE : isAOE // ignore: cast_nullable_to_non_nullable
as bool,defaultTarget: null == defaultTarget ? _self.defaultTarget : defaultTarget // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Skills].
extension SkillsPatterns on Skills {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Skills value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Skills() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Skills value)  $default,){
final _that = this;
switch (_that) {
case _Skills():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Skills value)?  $default,){
final _that = this;
switch (_that) {
case _Skills() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int cost,  int damage,  String description,  String element,  String type,  double damageMultiplier,  List<String> statusEffects,  bool isAOE,  String defaultTarget)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Skills() when $default != null:
return $default(_that.id,_that.name,_that.cost,_that.damage,_that.description,_that.element,_that.type,_that.damageMultiplier,_that.statusEffects,_that.isAOE,_that.defaultTarget);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int cost,  int damage,  String description,  String element,  String type,  double damageMultiplier,  List<String> statusEffects,  bool isAOE,  String defaultTarget)  $default,) {final _that = this;
switch (_that) {
case _Skills():
return $default(_that.id,_that.name,_that.cost,_that.damage,_that.description,_that.element,_that.type,_that.damageMultiplier,_that.statusEffects,_that.isAOE,_that.defaultTarget);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int cost,  int damage,  String description,  String element,  String type,  double damageMultiplier,  List<String> statusEffects,  bool isAOE,  String defaultTarget)?  $default,) {final _that = this;
switch (_that) {
case _Skills() when $default != null:
return $default(_that.id,_that.name,_that.cost,_that.damage,_that.description,_that.element,_that.type,_that.damageMultiplier,_that.statusEffects,_that.isAOE,_that.defaultTarget);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Skills extends Skills {
  const _Skills({required this.id, required this.name, required this.cost, required this.damage, required this.description, required this.element, required this.type, this.damageMultiplier = 0.0, final  List<String> statusEffects = const [], this.isAOE = false, this.defaultTarget = "enemy"}): _statusEffects = statusEffects,super._();
  factory _Skills.fromJson(Map<String, dynamic> json) => _$SkillsFromJson(json);

@override final  String id;
@override final  String name;
@override final  int cost;
@override final  int damage;
@override final  String description;
@override final  String element;
@override final  String type;
// "attack", "heal", "support"
// 新增技能相關屬性
@override@JsonKey() final  double damageMultiplier;
// 傷害倍率
 final  List<String> _statusEffects;
// 傷害倍率
@override@JsonKey() List<String> get statusEffects {
  if (_statusEffects is EqualUnmodifiableListView) return _statusEffects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statusEffects);
}

// 附加的狀態效果ID
@override@JsonKey() final  bool isAOE;
// 是否為範圍攻擊
@override@JsonKey() final  String defaultTarget;

/// Create a copy of Skills
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillsCopyWith<_Skills> get copyWith => __$SkillsCopyWithImpl<_Skills>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Skills&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.damage, damage) || other.damage == damage)&&(identical(other.description, description) || other.description == description)&&(identical(other.element, element) || other.element == element)&&(identical(other.type, type) || other.type == type)&&(identical(other.damageMultiplier, damageMultiplier) || other.damageMultiplier == damageMultiplier)&&const DeepCollectionEquality().equals(other._statusEffects, _statusEffects)&&(identical(other.isAOE, isAOE) || other.isAOE == isAOE)&&(identical(other.defaultTarget, defaultTarget) || other.defaultTarget == defaultTarget));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,cost,damage,description,element,type,damageMultiplier,const DeepCollectionEquality().hash(_statusEffects),isAOE,defaultTarget);

@override
String toString() {
  return 'Skills(id: $id, name: $name, cost: $cost, damage: $damage, description: $description, element: $element, type: $type, damageMultiplier: $damageMultiplier, statusEffects: $statusEffects, isAOE: $isAOE, defaultTarget: $defaultTarget)';
}


}

/// @nodoc
abstract mixin class _$SkillsCopyWith<$Res> implements $SkillsCopyWith<$Res> {
  factory _$SkillsCopyWith(_Skills value, $Res Function(_Skills) _then) = __$SkillsCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int cost, int damage, String description, String element, String type, double damageMultiplier, List<String> statusEffects, bool isAOE, String defaultTarget
});




}
/// @nodoc
class __$SkillsCopyWithImpl<$Res>
    implements _$SkillsCopyWith<$Res> {
  __$SkillsCopyWithImpl(this._self, this._then);

  final _Skills _self;
  final $Res Function(_Skills) _then;

/// Create a copy of Skills
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? cost = null,Object? damage = null,Object? description = null,Object? element = null,Object? type = null,Object? damageMultiplier = null,Object? statusEffects = null,Object? isAOE = null,Object? defaultTarget = null,}) {
  return _then(_Skills(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,damage: null == damage ? _self.damage : damage // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,damageMultiplier: null == damageMultiplier ? _self.damageMultiplier : damageMultiplier // ignore: cast_nullable_to_non_nullable
as double,statusEffects: null == statusEffects ? _self._statusEffects : statusEffects // ignore: cast_nullable_to_non_nullable
as List<String>,isAOE: null == isAOE ? _self.isAOE : isAOE // ignore: cast_nullable_to_non_nullable
as bool,defaultTarget: null == defaultTarget ? _self.defaultTarget : defaultTarget // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
