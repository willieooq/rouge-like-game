// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EquipmentEffect {

 String get id; String get name; String get description; Map<String, dynamic> get parameters;
/// Create a copy of EquipmentEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipmentEffectCopyWith<EquipmentEffect> get copyWith => _$EquipmentEffectCopyWithImpl<EquipmentEffect>(this as EquipmentEffect, _$identity);

  /// Serializes this EquipmentEffect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipmentEffect&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.parameters, parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(parameters));

@override
String toString() {
  return 'EquipmentEffect(id: $id, name: $name, description: $description, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class $EquipmentEffectCopyWith<$Res>  {
  factory $EquipmentEffectCopyWith(EquipmentEffect value, $Res Function(EquipmentEffect) _then) = _$EquipmentEffectCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, Map<String, dynamic> parameters
});




}
/// @nodoc
class _$EquipmentEffectCopyWithImpl<$Res>
    implements $EquipmentEffectCopyWith<$Res> {
  _$EquipmentEffectCopyWithImpl(this._self, this._then);

  final EquipmentEffect _self;
  final $Res Function(EquipmentEffect) _then;

/// Create a copy of EquipmentEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? parameters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,parameters: null == parameters ? _self.parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [EquipmentEffect].
extension EquipmentEffectPatterns on EquipmentEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipmentEffect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipmentEffect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipmentEffect value)  $default,){
final _that = this;
switch (_that) {
case _EquipmentEffect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipmentEffect value)?  $default,){
final _that = this;
switch (_that) {
case _EquipmentEffect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  Map<String, dynamic> parameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipmentEffect() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.parameters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  Map<String, dynamic> parameters)  $default,) {final _that = this;
switch (_that) {
case _EquipmentEffect():
return $default(_that.id,_that.name,_that.description,_that.parameters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  Map<String, dynamic> parameters)?  $default,) {final _that = this;
switch (_that) {
case _EquipmentEffect() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.parameters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipmentEffect implements EquipmentEffect {
  const _EquipmentEffect({required this.id, required this.name, required this.description, final  Map<String, dynamic> parameters = const {}}): _parameters = parameters;
  factory _EquipmentEffect.fromJson(Map<String, dynamic> json) => _$EquipmentEffectFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
 final  Map<String, dynamic> _parameters;
@override@JsonKey() Map<String, dynamic> get parameters {
  if (_parameters is EqualUnmodifiableMapView) return _parameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_parameters);
}


/// Create a copy of EquipmentEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipmentEffectCopyWith<_EquipmentEffect> get copyWith => __$EquipmentEffectCopyWithImpl<_EquipmentEffect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipmentEffectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipmentEffect&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._parameters, _parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_parameters));

@override
String toString() {
  return 'EquipmentEffect(id: $id, name: $name, description: $description, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class _$EquipmentEffectCopyWith<$Res> implements $EquipmentEffectCopyWith<$Res> {
  factory _$EquipmentEffectCopyWith(_EquipmentEffect value, $Res Function(_EquipmentEffect) _then) = __$EquipmentEffectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, Map<String, dynamic> parameters
});




}
/// @nodoc
class __$EquipmentEffectCopyWithImpl<$Res>
    implements _$EquipmentEffectCopyWith<$Res> {
  __$EquipmentEffectCopyWithImpl(this._self, this._then);

  final _EquipmentEffect _self;
  final $Res Function(_EquipmentEffect) _then;

/// Create a copy of EquipmentEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? parameters = null,}) {
  return _then(_EquipmentEffect(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,parameters: null == parameters ? _self._parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$Equipment {

 String get id; String get name; Rarity get rare; String get description; EquipmentType get type; int get atk;// 攻擊力
 int get hp;// 生命值
 List<EquipmentEffect> get effect;// 特殊效果
 int get price; String get iconPath; int get level;// 裝備等級
 int get durability;// 耐久度（0表示不消耗）
 int get maxDurability;
/// Create a copy of Equipment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipmentCopyWith<Equipment> get copyWith => _$EquipmentCopyWithImpl<Equipment>(this as Equipment, _$identity);

  /// Serializes this Equipment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Equipment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rare, rare) || other.rare == rare)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.atk, atk) || other.atk == atk)&&(identical(other.hp, hp) || other.hp == hp)&&const DeepCollectionEquality().equals(other.effect, effect)&&(identical(other.price, price) || other.price == price)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.level, level) || other.level == level)&&(identical(other.durability, durability) || other.durability == durability)&&(identical(other.maxDurability, maxDurability) || other.maxDurability == maxDurability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rare,description,type,atk,hp,const DeepCollectionEquality().hash(effect),price,iconPath,level,durability,maxDurability);

@override
String toString() {
  return 'Equipment(id: $id, name: $name, rare: $rare, description: $description, type: $type, atk: $atk, hp: $hp, effect: $effect, price: $price, iconPath: $iconPath, level: $level, durability: $durability, maxDurability: $maxDurability)';
}


}

/// @nodoc
abstract mixin class $EquipmentCopyWith<$Res>  {
  factory $EquipmentCopyWith(Equipment value, $Res Function(Equipment) _then) = _$EquipmentCopyWithImpl;
@useResult
$Res call({
 String id, String name, Rarity rare, String description, EquipmentType type, int atk, int hp, List<EquipmentEffect> effect, int price, String iconPath, int level, int durability, int maxDurability
});




}
/// @nodoc
class _$EquipmentCopyWithImpl<$Res>
    implements $EquipmentCopyWith<$Res> {
  _$EquipmentCopyWithImpl(this._self, this._then);

  final Equipment _self;
  final $Res Function(Equipment) _then;

/// Create a copy of Equipment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? rare = null,Object? description = null,Object? type = null,Object? atk = null,Object? hp = null,Object? effect = null,Object? price = null,Object? iconPath = null,Object? level = null,Object? durability = null,Object? maxDurability = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rare: null == rare ? _self.rare : rare // ignore: cast_nullable_to_non_nullable
as Rarity,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EquipmentType,atk: null == atk ? _self.atk : atk // ignore: cast_nullable_to_non_nullable
as int,hp: null == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as List<EquipmentEffect>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,durability: null == durability ? _self.durability : durability // ignore: cast_nullable_to_non_nullable
as int,maxDurability: null == maxDurability ? _self.maxDurability : maxDurability // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Equipment].
extension EquipmentPatterns on Equipment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Equipment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Equipment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Equipment value)  $default,){
final _that = this;
switch (_that) {
case _Equipment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Equipment value)?  $default,){
final _that = this;
switch (_that) {
case _Equipment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Rarity rare,  String description,  EquipmentType type,  int atk,  int hp,  List<EquipmentEffect> effect,  int price,  String iconPath,  int level,  int durability,  int maxDurability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Equipment() when $default != null:
return $default(_that.id,_that.name,_that.rare,_that.description,_that.type,_that.atk,_that.hp,_that.effect,_that.price,_that.iconPath,_that.level,_that.durability,_that.maxDurability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Rarity rare,  String description,  EquipmentType type,  int atk,  int hp,  List<EquipmentEffect> effect,  int price,  String iconPath,  int level,  int durability,  int maxDurability)  $default,) {final _that = this;
switch (_that) {
case _Equipment():
return $default(_that.id,_that.name,_that.rare,_that.description,_that.type,_that.atk,_that.hp,_that.effect,_that.price,_that.iconPath,_that.level,_that.durability,_that.maxDurability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Rarity rare,  String description,  EquipmentType type,  int atk,  int hp,  List<EquipmentEffect> effect,  int price,  String iconPath,  int level,  int durability,  int maxDurability)?  $default,) {final _that = this;
switch (_that) {
case _Equipment() when $default != null:
return $default(_that.id,_that.name,_that.rare,_that.description,_that.type,_that.atk,_that.hp,_that.effect,_that.price,_that.iconPath,_that.level,_that.durability,_that.maxDurability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Equipment implements Equipment {
  const _Equipment({required this.id, required this.name, required this.rare, required this.description, required this.type, required this.atk, required this.hp, required final  List<EquipmentEffect> effect, required this.price, this.iconPath = '', this.level = 1, this.durability = 0, this.maxDurability = 0}): _effect = effect;
  factory _Equipment.fromJson(Map<String, dynamic> json) => _$EquipmentFromJson(json);

@override final  String id;
@override final  String name;
@override final  Rarity rare;
@override final  String description;
@override final  EquipmentType type;
@override final  int atk;
// 攻擊力
@override final  int hp;
// 生命值
 final  List<EquipmentEffect> _effect;
// 生命值
@override List<EquipmentEffect> get effect {
  if (_effect is EqualUnmodifiableListView) return _effect;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_effect);
}

// 特殊效果
@override final  int price;
@override@JsonKey() final  String iconPath;
@override@JsonKey() final  int level;
// 裝備等級
@override@JsonKey() final  int durability;
// 耐久度（0表示不消耗）
@override@JsonKey() final  int maxDurability;

/// Create a copy of Equipment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipmentCopyWith<_Equipment> get copyWith => __$EquipmentCopyWithImpl<_Equipment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Equipment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rare, rare) || other.rare == rare)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.atk, atk) || other.atk == atk)&&(identical(other.hp, hp) || other.hp == hp)&&const DeepCollectionEquality().equals(other._effect, _effect)&&(identical(other.price, price) || other.price == price)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.level, level) || other.level == level)&&(identical(other.durability, durability) || other.durability == durability)&&(identical(other.maxDurability, maxDurability) || other.maxDurability == maxDurability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rare,description,type,atk,hp,const DeepCollectionEquality().hash(_effect),price,iconPath,level,durability,maxDurability);

@override
String toString() {
  return 'Equipment(id: $id, name: $name, rare: $rare, description: $description, type: $type, atk: $atk, hp: $hp, effect: $effect, price: $price, iconPath: $iconPath, level: $level, durability: $durability, maxDurability: $maxDurability)';
}


}

/// @nodoc
abstract mixin class _$EquipmentCopyWith<$Res> implements $EquipmentCopyWith<$Res> {
  factory _$EquipmentCopyWith(_Equipment value, $Res Function(_Equipment) _then) = __$EquipmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Rarity rare, String description, EquipmentType type, int atk, int hp, List<EquipmentEffect> effect, int price, String iconPath, int level, int durability, int maxDurability
});




}
/// @nodoc
class __$EquipmentCopyWithImpl<$Res>
    implements _$EquipmentCopyWith<$Res> {
  __$EquipmentCopyWithImpl(this._self, this._then);

  final _Equipment _self;
  final $Res Function(_Equipment) _then;

/// Create a copy of Equipment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? rare = null,Object? description = null,Object? type = null,Object? atk = null,Object? hp = null,Object? effect = null,Object? price = null,Object? iconPath = null,Object? level = null,Object? durability = null,Object? maxDurability = null,}) {
  return _then(_Equipment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rare: null == rare ? _self.rare : rare // ignore: cast_nullable_to_non_nullable
as Rarity,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EquipmentType,atk: null == atk ? _self.atk : atk // ignore: cast_nullable_to_non_nullable
as int,hp: null == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int,effect: null == effect ? _self._effect : effect // ignore: cast_nullable_to_non_nullable
as List<EquipmentEffect>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,durability: null == durability ? _self.durability : durability // ignore: cast_nullable_to_non_nullable
as int,maxDurability: null == maxDurability ? _self.maxDurability : maxDurability // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
