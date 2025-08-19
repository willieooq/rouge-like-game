// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatusEffect {

 String get id;// 狀態ID（唯一）
 String get name;// 狀態名稱
 String get description;// 狀態描述
 StatusType get type;// 狀態類型
 int get maxDuration;// 最大持續回合數
 int get currentDuration;// 當前剩餘回合數
 int get maxStacks;// 最大層數
 int get currentStacks;// 當前層數
 bool get isStackable;// 是否可累積層數
 bool get isRefreshable;// 是否可重新計時
 bool get isDispellable;// 是否可驅散
 bool get isRemovable;// 是否可消除（時間到期自然消失）
 bool get isDetonable;// 是否可引爆
 StatusScope get scope;// 狀態作用域
// 效果數值
 Map<AttributeType, double> get attributeModifiers;// 屬性修正值
 int get dotDamage;// DOT傷害（每回合）
 int get hotHealing;// HOT治療（每回合）
 double get detonationMultiplier;// 引爆倍率
// 觸發條件
 List<StatusTrigger> get triggers;// 視覺效果
 String get color;// 狀態顏色
 String get iconPath;
/// Create a copy of StatusEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusEffectCopyWith<StatusEffect> get copyWith => _$StatusEffectCopyWithImpl<StatusEffect>(this as StatusEffect, _$identity);

  /// Serializes this StatusEffect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusEffect&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.maxDuration, maxDuration) || other.maxDuration == maxDuration)&&(identical(other.currentDuration, currentDuration) || other.currentDuration == currentDuration)&&(identical(other.maxStacks, maxStacks) || other.maxStacks == maxStacks)&&(identical(other.currentStacks, currentStacks) || other.currentStacks == currentStacks)&&(identical(other.isStackable, isStackable) || other.isStackable == isStackable)&&(identical(other.isRefreshable, isRefreshable) || other.isRefreshable == isRefreshable)&&(identical(other.isDispellable, isDispellable) || other.isDispellable == isDispellable)&&(identical(other.isRemovable, isRemovable) || other.isRemovable == isRemovable)&&(identical(other.isDetonable, isDetonable) || other.isDetonable == isDetonable)&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other.attributeModifiers, attributeModifiers)&&(identical(other.dotDamage, dotDamage) || other.dotDamage == dotDamage)&&(identical(other.hotHealing, hotHealing) || other.hotHealing == hotHealing)&&(identical(other.detonationMultiplier, detonationMultiplier) || other.detonationMultiplier == detonationMultiplier)&&const DeepCollectionEquality().equals(other.triggers, triggers)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,type,maxDuration,currentDuration,maxStacks,currentStacks,isStackable,isRefreshable,isDispellable,isRemovable,isDetonable,scope,const DeepCollectionEquality().hash(attributeModifiers),dotDamage,hotHealing,detonationMultiplier,const DeepCollectionEquality().hash(triggers),color,iconPath]);

@override
String toString() {
  return 'StatusEffect(id: $id, name: $name, description: $description, type: $type, maxDuration: $maxDuration, currentDuration: $currentDuration, maxStacks: $maxStacks, currentStacks: $currentStacks, isStackable: $isStackable, isRefreshable: $isRefreshable, isDispellable: $isDispellable, isRemovable: $isRemovable, isDetonable: $isDetonable, scope: $scope, attributeModifiers: $attributeModifiers, dotDamage: $dotDamage, hotHealing: $hotHealing, detonationMultiplier: $detonationMultiplier, triggers: $triggers, color: $color, iconPath: $iconPath)';
}


}

/// @nodoc
abstract mixin class $StatusEffectCopyWith<$Res>  {
  factory $StatusEffectCopyWith(StatusEffect value, $Res Function(StatusEffect) _then) = _$StatusEffectCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, StatusType type, int maxDuration, int currentDuration, int maxStacks, int currentStacks, bool isStackable, bool isRefreshable, bool isDispellable, bool isRemovable, bool isDetonable, StatusScope scope, Map<AttributeType, double> attributeModifiers, int dotDamage, int hotHealing, double detonationMultiplier, List<StatusTrigger> triggers, String color, String iconPath
});




}
/// @nodoc
class _$StatusEffectCopyWithImpl<$Res>
    implements $StatusEffectCopyWith<$Res> {
  _$StatusEffectCopyWithImpl(this._self, this._then);

  final StatusEffect _self;
  final $Res Function(StatusEffect) _then;

/// Create a copy of StatusEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? maxDuration = null,Object? currentDuration = null,Object? maxStacks = null,Object? currentStacks = null,Object? isStackable = null,Object? isRefreshable = null,Object? isDispellable = null,Object? isRemovable = null,Object? isDetonable = null,Object? scope = null,Object? attributeModifiers = null,Object? dotDamage = null,Object? hotHealing = null,Object? detonationMultiplier = null,Object? triggers = null,Object? color = null,Object? iconPath = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StatusType,maxDuration: null == maxDuration ? _self.maxDuration : maxDuration // ignore: cast_nullable_to_non_nullable
as int,currentDuration: null == currentDuration ? _self.currentDuration : currentDuration // ignore: cast_nullable_to_non_nullable
as int,maxStacks: null == maxStacks ? _self.maxStacks : maxStacks // ignore: cast_nullable_to_non_nullable
as int,currentStacks: null == currentStacks ? _self.currentStacks : currentStacks // ignore: cast_nullable_to_non_nullable
as int,isStackable: null == isStackable ? _self.isStackable : isStackable // ignore: cast_nullable_to_non_nullable
as bool,isRefreshable: null == isRefreshable ? _self.isRefreshable : isRefreshable // ignore: cast_nullable_to_non_nullable
as bool,isDispellable: null == isDispellable ? _self.isDispellable : isDispellable // ignore: cast_nullable_to_non_nullable
as bool,isRemovable: null == isRemovable ? _self.isRemovable : isRemovable // ignore: cast_nullable_to_non_nullable
as bool,isDetonable: null == isDetonable ? _self.isDetonable : isDetonable // ignore: cast_nullable_to_non_nullable
as bool,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as StatusScope,attributeModifiers: null == attributeModifiers ? _self.attributeModifiers : attributeModifiers // ignore: cast_nullable_to_non_nullable
as Map<AttributeType, double>,dotDamage: null == dotDamage ? _self.dotDamage : dotDamage // ignore: cast_nullable_to_non_nullable
as int,hotHealing: null == hotHealing ? _self.hotHealing : hotHealing // ignore: cast_nullable_to_non_nullable
as int,detonationMultiplier: null == detonationMultiplier ? _self.detonationMultiplier : detonationMultiplier // ignore: cast_nullable_to_non_nullable
as double,triggers: null == triggers ? _self.triggers : triggers // ignore: cast_nullable_to_non_nullable
as List<StatusTrigger>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusEffect].
extension StatusEffectPatterns on StatusEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusEffect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusEffect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusEffect value)  $default,){
final _that = this;
switch (_that) {
case _StatusEffect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusEffect value)?  $default,){
final _that = this;
switch (_that) {
case _StatusEffect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  StatusType type,  int maxDuration,  int currentDuration,  int maxStacks,  int currentStacks,  bool isStackable,  bool isRefreshable,  bool isDispellable,  bool isRemovable,  bool isDetonable,  StatusScope scope,  Map<AttributeType, double> attributeModifiers,  int dotDamage,  int hotHealing,  double detonationMultiplier,  List<StatusTrigger> triggers,  String color,  String iconPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusEffect() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.maxDuration,_that.currentDuration,_that.maxStacks,_that.currentStacks,_that.isStackable,_that.isRefreshable,_that.isDispellable,_that.isRemovable,_that.isDetonable,_that.scope,_that.attributeModifiers,_that.dotDamage,_that.hotHealing,_that.detonationMultiplier,_that.triggers,_that.color,_that.iconPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  StatusType type,  int maxDuration,  int currentDuration,  int maxStacks,  int currentStacks,  bool isStackable,  bool isRefreshable,  bool isDispellable,  bool isRemovable,  bool isDetonable,  StatusScope scope,  Map<AttributeType, double> attributeModifiers,  int dotDamage,  int hotHealing,  double detonationMultiplier,  List<StatusTrigger> triggers,  String color,  String iconPath)  $default,) {final _that = this;
switch (_that) {
case _StatusEffect():
return $default(_that.id,_that.name,_that.description,_that.type,_that.maxDuration,_that.currentDuration,_that.maxStacks,_that.currentStacks,_that.isStackable,_that.isRefreshable,_that.isDispellable,_that.isRemovable,_that.isDetonable,_that.scope,_that.attributeModifiers,_that.dotDamage,_that.hotHealing,_that.detonationMultiplier,_that.triggers,_that.color,_that.iconPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  StatusType type,  int maxDuration,  int currentDuration,  int maxStacks,  int currentStacks,  bool isStackable,  bool isRefreshable,  bool isDispellable,  bool isRemovable,  bool isDetonable,  StatusScope scope,  Map<AttributeType, double> attributeModifiers,  int dotDamage,  int hotHealing,  double detonationMultiplier,  List<StatusTrigger> triggers,  String color,  String iconPath)?  $default,) {final _that = this;
switch (_that) {
case _StatusEffect() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.maxDuration,_that.currentDuration,_that.maxStacks,_that.currentStacks,_that.isStackable,_that.isRefreshable,_that.isDispellable,_that.isRemovable,_that.isDetonable,_that.scope,_that.attributeModifiers,_that.dotDamage,_that.hotHealing,_that.detonationMultiplier,_that.triggers,_that.color,_that.iconPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatusEffect implements StatusEffect {
  const _StatusEffect({required this.id, required this.name, required this.description, required this.type, required this.maxDuration, required this.currentDuration, required this.maxStacks, required this.currentStacks, this.isStackable = false, this.isRefreshable = false, this.isDispellable = false, this.isRemovable = true, this.isDetonable = false, this.scope = StatusScope.battleOnly, required final  Map<AttributeType, double> attributeModifiers, this.dotDamage = 0, this.hotHealing = 0, this.detonationMultiplier = 0, final  List<StatusTrigger> triggers = const [], this.color = '#FFFFFF', this.iconPath = ''}): _attributeModifiers = attributeModifiers,_triggers = triggers;
  factory _StatusEffect.fromJson(Map<String, dynamic> json) => _$StatusEffectFromJson(json);

@override final  String id;
// 狀態ID（唯一）
@override final  String name;
// 狀態名稱
@override final  String description;
// 狀態描述
@override final  StatusType type;
// 狀態類型
@override final  int maxDuration;
// 最大持續回合數
@override final  int currentDuration;
// 當前剩餘回合數
@override final  int maxStacks;
// 最大層數
@override final  int currentStacks;
// 當前層數
@override@JsonKey() final  bool isStackable;
// 是否可累積層數
@override@JsonKey() final  bool isRefreshable;
// 是否可重新計時
@override@JsonKey() final  bool isDispellable;
// 是否可驅散
@override@JsonKey() final  bool isRemovable;
// 是否可消除（時間到期自然消失）
@override@JsonKey() final  bool isDetonable;
// 是否可引爆
@override@JsonKey() final  StatusScope scope;
// 狀態作用域
// 效果數值
 final  Map<AttributeType, double> _attributeModifiers;
// 狀態作用域
// 效果數值
@override Map<AttributeType, double> get attributeModifiers {
  if (_attributeModifiers is EqualUnmodifiableMapView) return _attributeModifiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributeModifiers);
}

// 屬性修正值
@override@JsonKey() final  int dotDamage;
// DOT傷害（每回合）
@override@JsonKey() final  int hotHealing;
// HOT治療（每回合）
@override@JsonKey() final  double detonationMultiplier;
// 引爆倍率
// 觸發條件
 final  List<StatusTrigger> _triggers;
// 引爆倍率
// 觸發條件
@override@JsonKey() List<StatusTrigger> get triggers {
  if (_triggers is EqualUnmodifiableListView) return _triggers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_triggers);
}

// 視覺效果
@override@JsonKey() final  String color;
// 狀態顏色
@override@JsonKey() final  String iconPath;

/// Create a copy of StatusEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusEffectCopyWith<_StatusEffect> get copyWith => __$StatusEffectCopyWithImpl<_StatusEffect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusEffectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusEffect&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.maxDuration, maxDuration) || other.maxDuration == maxDuration)&&(identical(other.currentDuration, currentDuration) || other.currentDuration == currentDuration)&&(identical(other.maxStacks, maxStacks) || other.maxStacks == maxStacks)&&(identical(other.currentStacks, currentStacks) || other.currentStacks == currentStacks)&&(identical(other.isStackable, isStackable) || other.isStackable == isStackable)&&(identical(other.isRefreshable, isRefreshable) || other.isRefreshable == isRefreshable)&&(identical(other.isDispellable, isDispellable) || other.isDispellable == isDispellable)&&(identical(other.isRemovable, isRemovable) || other.isRemovable == isRemovable)&&(identical(other.isDetonable, isDetonable) || other.isDetonable == isDetonable)&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other._attributeModifiers, _attributeModifiers)&&(identical(other.dotDamage, dotDamage) || other.dotDamage == dotDamage)&&(identical(other.hotHealing, hotHealing) || other.hotHealing == hotHealing)&&(identical(other.detonationMultiplier, detonationMultiplier) || other.detonationMultiplier == detonationMultiplier)&&const DeepCollectionEquality().equals(other._triggers, _triggers)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,type,maxDuration,currentDuration,maxStacks,currentStacks,isStackable,isRefreshable,isDispellable,isRemovable,isDetonable,scope,const DeepCollectionEquality().hash(_attributeModifiers),dotDamage,hotHealing,detonationMultiplier,const DeepCollectionEquality().hash(_triggers),color,iconPath]);

@override
String toString() {
  return 'StatusEffect(id: $id, name: $name, description: $description, type: $type, maxDuration: $maxDuration, currentDuration: $currentDuration, maxStacks: $maxStacks, currentStacks: $currentStacks, isStackable: $isStackable, isRefreshable: $isRefreshable, isDispellable: $isDispellable, isRemovable: $isRemovable, isDetonable: $isDetonable, scope: $scope, attributeModifiers: $attributeModifiers, dotDamage: $dotDamage, hotHealing: $hotHealing, detonationMultiplier: $detonationMultiplier, triggers: $triggers, color: $color, iconPath: $iconPath)';
}


}

/// @nodoc
abstract mixin class _$StatusEffectCopyWith<$Res> implements $StatusEffectCopyWith<$Res> {
  factory _$StatusEffectCopyWith(_StatusEffect value, $Res Function(_StatusEffect) _then) = __$StatusEffectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, StatusType type, int maxDuration, int currentDuration, int maxStacks, int currentStacks, bool isStackable, bool isRefreshable, bool isDispellable, bool isRemovable, bool isDetonable, StatusScope scope, Map<AttributeType, double> attributeModifiers, int dotDamage, int hotHealing, double detonationMultiplier, List<StatusTrigger> triggers, String color, String iconPath
});




}
/// @nodoc
class __$StatusEffectCopyWithImpl<$Res>
    implements _$StatusEffectCopyWith<$Res> {
  __$StatusEffectCopyWithImpl(this._self, this._then);

  final _StatusEffect _self;
  final $Res Function(_StatusEffect) _then;

/// Create a copy of StatusEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? maxDuration = null,Object? currentDuration = null,Object? maxStacks = null,Object? currentStacks = null,Object? isStackable = null,Object? isRefreshable = null,Object? isDispellable = null,Object? isRemovable = null,Object? isDetonable = null,Object? scope = null,Object? attributeModifiers = null,Object? dotDamage = null,Object? hotHealing = null,Object? detonationMultiplier = null,Object? triggers = null,Object? color = null,Object? iconPath = null,}) {
  return _then(_StatusEffect(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StatusType,maxDuration: null == maxDuration ? _self.maxDuration : maxDuration // ignore: cast_nullable_to_non_nullable
as int,currentDuration: null == currentDuration ? _self.currentDuration : currentDuration // ignore: cast_nullable_to_non_nullable
as int,maxStacks: null == maxStacks ? _self.maxStacks : maxStacks // ignore: cast_nullable_to_non_nullable
as int,currentStacks: null == currentStacks ? _self.currentStacks : currentStacks // ignore: cast_nullable_to_non_nullable
as int,isStackable: null == isStackable ? _self.isStackable : isStackable // ignore: cast_nullable_to_non_nullable
as bool,isRefreshable: null == isRefreshable ? _self.isRefreshable : isRefreshable // ignore: cast_nullable_to_non_nullable
as bool,isDispellable: null == isDispellable ? _self.isDispellable : isDispellable // ignore: cast_nullable_to_non_nullable
as bool,isRemovable: null == isRemovable ? _self.isRemovable : isRemovable // ignore: cast_nullable_to_non_nullable
as bool,isDetonable: null == isDetonable ? _self.isDetonable : isDetonable // ignore: cast_nullable_to_non_nullable
as bool,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as StatusScope,attributeModifiers: null == attributeModifiers ? _self._attributeModifiers : attributeModifiers // ignore: cast_nullable_to_non_nullable
as Map<AttributeType, double>,dotDamage: null == dotDamage ? _self.dotDamage : dotDamage // ignore: cast_nullable_to_non_nullable
as int,hotHealing: null == hotHealing ? _self.hotHealing : hotHealing // ignore: cast_nullable_to_non_nullable
as int,detonationMultiplier: null == detonationMultiplier ? _self.detonationMultiplier : detonationMultiplier // ignore: cast_nullable_to_non_nullable
as double,triggers: null == triggers ? _self._triggers : triggers // ignore: cast_nullable_to_non_nullable
as List<StatusTrigger>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StatusTemplate {

 String get id; String get name; String get description; StatusType get type; int get baseDuration;// 基礎持續時間
 int get maxStacks; bool get isStackable; bool get isRefreshable; bool get isDispellable; bool get isRemovable;// 是否可消除
 bool get isDetonable; StatusScope get scope;// 狀態作用域
// 每層效果數值
 Map<AttributeType, double> get attributePerStack; int get dotDamagePerStack; int get hotHealingPerStack; double get detonationMultiplier; List<StatusTrigger> get triggers; String get color; String get iconPath;
/// Create a copy of StatusTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusTemplateCopyWith<StatusTemplate> get copyWith => _$StatusTemplateCopyWithImpl<StatusTemplate>(this as StatusTemplate, _$identity);

  /// Serializes this StatusTemplate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.baseDuration, baseDuration) || other.baseDuration == baseDuration)&&(identical(other.maxStacks, maxStacks) || other.maxStacks == maxStacks)&&(identical(other.isStackable, isStackable) || other.isStackable == isStackable)&&(identical(other.isRefreshable, isRefreshable) || other.isRefreshable == isRefreshable)&&(identical(other.isDispellable, isDispellable) || other.isDispellable == isDispellable)&&(identical(other.isRemovable, isRemovable) || other.isRemovable == isRemovable)&&(identical(other.isDetonable, isDetonable) || other.isDetonable == isDetonable)&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other.attributePerStack, attributePerStack)&&(identical(other.dotDamagePerStack, dotDamagePerStack) || other.dotDamagePerStack == dotDamagePerStack)&&(identical(other.hotHealingPerStack, hotHealingPerStack) || other.hotHealingPerStack == hotHealingPerStack)&&(identical(other.detonationMultiplier, detonationMultiplier) || other.detonationMultiplier == detonationMultiplier)&&const DeepCollectionEquality().equals(other.triggers, triggers)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,type,baseDuration,maxStacks,isStackable,isRefreshable,isDispellable,isRemovable,isDetonable,scope,const DeepCollectionEquality().hash(attributePerStack),dotDamagePerStack,hotHealingPerStack,detonationMultiplier,const DeepCollectionEquality().hash(triggers),color,iconPath]);

@override
String toString() {
  return 'StatusTemplate(id: $id, name: $name, description: $description, type: $type, baseDuration: $baseDuration, maxStacks: $maxStacks, isStackable: $isStackable, isRefreshable: $isRefreshable, isDispellable: $isDispellable, isRemovable: $isRemovable, isDetonable: $isDetonable, scope: $scope, attributePerStack: $attributePerStack, dotDamagePerStack: $dotDamagePerStack, hotHealingPerStack: $hotHealingPerStack, detonationMultiplier: $detonationMultiplier, triggers: $triggers, color: $color, iconPath: $iconPath)';
}


}

/// @nodoc
abstract mixin class $StatusTemplateCopyWith<$Res>  {
  factory $StatusTemplateCopyWith(StatusTemplate value, $Res Function(StatusTemplate) _then) = _$StatusTemplateCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, StatusType type, int baseDuration, int maxStacks, bool isStackable, bool isRefreshable, bool isDispellable, bool isRemovable, bool isDetonable, StatusScope scope, Map<AttributeType, double> attributePerStack, int dotDamagePerStack, int hotHealingPerStack, double detonationMultiplier, List<StatusTrigger> triggers, String color, String iconPath
});




}
/// @nodoc
class _$StatusTemplateCopyWithImpl<$Res>
    implements $StatusTemplateCopyWith<$Res> {
  _$StatusTemplateCopyWithImpl(this._self, this._then);

  final StatusTemplate _self;
  final $Res Function(StatusTemplate) _then;

/// Create a copy of StatusTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? baseDuration = null,Object? maxStacks = null,Object? isStackable = null,Object? isRefreshable = null,Object? isDispellable = null,Object? isRemovable = null,Object? isDetonable = null,Object? scope = null,Object? attributePerStack = null,Object? dotDamagePerStack = null,Object? hotHealingPerStack = null,Object? detonationMultiplier = null,Object? triggers = null,Object? color = null,Object? iconPath = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StatusType,baseDuration: null == baseDuration ? _self.baseDuration : baseDuration // ignore: cast_nullable_to_non_nullable
as int,maxStacks: null == maxStacks ? _self.maxStacks : maxStacks // ignore: cast_nullable_to_non_nullable
as int,isStackable: null == isStackable ? _self.isStackable : isStackable // ignore: cast_nullable_to_non_nullable
as bool,isRefreshable: null == isRefreshable ? _self.isRefreshable : isRefreshable // ignore: cast_nullable_to_non_nullable
as bool,isDispellable: null == isDispellable ? _self.isDispellable : isDispellable // ignore: cast_nullable_to_non_nullable
as bool,isRemovable: null == isRemovable ? _self.isRemovable : isRemovable // ignore: cast_nullable_to_non_nullable
as bool,isDetonable: null == isDetonable ? _self.isDetonable : isDetonable // ignore: cast_nullable_to_non_nullable
as bool,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as StatusScope,attributePerStack: null == attributePerStack ? _self.attributePerStack : attributePerStack // ignore: cast_nullable_to_non_nullable
as Map<AttributeType, double>,dotDamagePerStack: null == dotDamagePerStack ? _self.dotDamagePerStack : dotDamagePerStack // ignore: cast_nullable_to_non_nullable
as int,hotHealingPerStack: null == hotHealingPerStack ? _self.hotHealingPerStack : hotHealingPerStack // ignore: cast_nullable_to_non_nullable
as int,detonationMultiplier: null == detonationMultiplier ? _self.detonationMultiplier : detonationMultiplier // ignore: cast_nullable_to_non_nullable
as double,triggers: null == triggers ? _self.triggers : triggers // ignore: cast_nullable_to_non_nullable
as List<StatusTrigger>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusTemplate].
extension StatusTemplatePatterns on StatusTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusTemplate value)  $default,){
final _that = this;
switch (_that) {
case _StatusTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _StatusTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  StatusType type,  int baseDuration,  int maxStacks,  bool isStackable,  bool isRefreshable,  bool isDispellable,  bool isRemovable,  bool isDetonable,  StatusScope scope,  Map<AttributeType, double> attributePerStack,  int dotDamagePerStack,  int hotHealingPerStack,  double detonationMultiplier,  List<StatusTrigger> triggers,  String color,  String iconPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusTemplate() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.baseDuration,_that.maxStacks,_that.isStackable,_that.isRefreshable,_that.isDispellable,_that.isRemovable,_that.isDetonable,_that.scope,_that.attributePerStack,_that.dotDamagePerStack,_that.hotHealingPerStack,_that.detonationMultiplier,_that.triggers,_that.color,_that.iconPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  StatusType type,  int baseDuration,  int maxStacks,  bool isStackable,  bool isRefreshable,  bool isDispellable,  bool isRemovable,  bool isDetonable,  StatusScope scope,  Map<AttributeType, double> attributePerStack,  int dotDamagePerStack,  int hotHealingPerStack,  double detonationMultiplier,  List<StatusTrigger> triggers,  String color,  String iconPath)  $default,) {final _that = this;
switch (_that) {
case _StatusTemplate():
return $default(_that.id,_that.name,_that.description,_that.type,_that.baseDuration,_that.maxStacks,_that.isStackable,_that.isRefreshable,_that.isDispellable,_that.isRemovable,_that.isDetonable,_that.scope,_that.attributePerStack,_that.dotDamagePerStack,_that.hotHealingPerStack,_that.detonationMultiplier,_that.triggers,_that.color,_that.iconPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  StatusType type,  int baseDuration,  int maxStacks,  bool isStackable,  bool isRefreshable,  bool isDispellable,  bool isRemovable,  bool isDetonable,  StatusScope scope,  Map<AttributeType, double> attributePerStack,  int dotDamagePerStack,  int hotHealingPerStack,  double detonationMultiplier,  List<StatusTrigger> triggers,  String color,  String iconPath)?  $default,) {final _that = this;
switch (_that) {
case _StatusTemplate() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.baseDuration,_that.maxStacks,_that.isStackable,_that.isRefreshable,_that.isDispellable,_that.isRemovable,_that.isDetonable,_that.scope,_that.attributePerStack,_that.dotDamagePerStack,_that.hotHealingPerStack,_that.detonationMultiplier,_that.triggers,_that.color,_that.iconPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatusTemplate implements StatusTemplate {
  const _StatusTemplate({required this.id, required this.name, required this.description, required this.type, required this.baseDuration, required this.maxStacks, this.isStackable = true, this.isRefreshable = true, this.isDispellable = true, this.isRemovable = true, this.isDetonable = false, this.scope = StatusScope.battleOnly, required final  Map<AttributeType, double> attributePerStack, this.dotDamagePerStack = 0, this.hotHealingPerStack = 0, this.detonationMultiplier = 1.0, final  List<StatusTrigger> triggers = const [], this.color = '#FFFFFF', this.iconPath = ''}): _attributePerStack = attributePerStack,_triggers = triggers;
  factory _StatusTemplate.fromJson(Map<String, dynamic> json) => _$StatusTemplateFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  StatusType type;
@override final  int baseDuration;
// 基礎持續時間
@override final  int maxStacks;
@override@JsonKey() final  bool isStackable;
@override@JsonKey() final  bool isRefreshable;
@override@JsonKey() final  bool isDispellable;
@override@JsonKey() final  bool isRemovable;
// 是否可消除
@override@JsonKey() final  bool isDetonable;
@override@JsonKey() final  StatusScope scope;
// 狀態作用域
// 每層效果數值
 final  Map<AttributeType, double> _attributePerStack;
// 狀態作用域
// 每層效果數值
@override Map<AttributeType, double> get attributePerStack {
  if (_attributePerStack is EqualUnmodifiableMapView) return _attributePerStack;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributePerStack);
}

@override@JsonKey() final  int dotDamagePerStack;
@override@JsonKey() final  int hotHealingPerStack;
@override@JsonKey() final  double detonationMultiplier;
 final  List<StatusTrigger> _triggers;
@override@JsonKey() List<StatusTrigger> get triggers {
  if (_triggers is EqualUnmodifiableListView) return _triggers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_triggers);
}

@override@JsonKey() final  String color;
@override@JsonKey() final  String iconPath;

/// Create a copy of StatusTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusTemplateCopyWith<_StatusTemplate> get copyWith => __$StatusTemplateCopyWithImpl<_StatusTemplate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusTemplateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.baseDuration, baseDuration) || other.baseDuration == baseDuration)&&(identical(other.maxStacks, maxStacks) || other.maxStacks == maxStacks)&&(identical(other.isStackable, isStackable) || other.isStackable == isStackable)&&(identical(other.isRefreshable, isRefreshable) || other.isRefreshable == isRefreshable)&&(identical(other.isDispellable, isDispellable) || other.isDispellable == isDispellable)&&(identical(other.isRemovable, isRemovable) || other.isRemovable == isRemovable)&&(identical(other.isDetonable, isDetonable) || other.isDetonable == isDetonable)&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other._attributePerStack, _attributePerStack)&&(identical(other.dotDamagePerStack, dotDamagePerStack) || other.dotDamagePerStack == dotDamagePerStack)&&(identical(other.hotHealingPerStack, hotHealingPerStack) || other.hotHealingPerStack == hotHealingPerStack)&&(identical(other.detonationMultiplier, detonationMultiplier) || other.detonationMultiplier == detonationMultiplier)&&const DeepCollectionEquality().equals(other._triggers, _triggers)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,type,baseDuration,maxStacks,isStackable,isRefreshable,isDispellable,isRemovable,isDetonable,scope,const DeepCollectionEquality().hash(_attributePerStack),dotDamagePerStack,hotHealingPerStack,detonationMultiplier,const DeepCollectionEquality().hash(_triggers),color,iconPath]);

@override
String toString() {
  return 'StatusTemplate(id: $id, name: $name, description: $description, type: $type, baseDuration: $baseDuration, maxStacks: $maxStacks, isStackable: $isStackable, isRefreshable: $isRefreshable, isDispellable: $isDispellable, isRemovable: $isRemovable, isDetonable: $isDetonable, scope: $scope, attributePerStack: $attributePerStack, dotDamagePerStack: $dotDamagePerStack, hotHealingPerStack: $hotHealingPerStack, detonationMultiplier: $detonationMultiplier, triggers: $triggers, color: $color, iconPath: $iconPath)';
}


}

/// @nodoc
abstract mixin class _$StatusTemplateCopyWith<$Res> implements $StatusTemplateCopyWith<$Res> {
  factory _$StatusTemplateCopyWith(_StatusTemplate value, $Res Function(_StatusTemplate) _then) = __$StatusTemplateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, StatusType type, int baseDuration, int maxStacks, bool isStackable, bool isRefreshable, bool isDispellable, bool isRemovable, bool isDetonable, StatusScope scope, Map<AttributeType, double> attributePerStack, int dotDamagePerStack, int hotHealingPerStack, double detonationMultiplier, List<StatusTrigger> triggers, String color, String iconPath
});




}
/// @nodoc
class __$StatusTemplateCopyWithImpl<$Res>
    implements _$StatusTemplateCopyWith<$Res> {
  __$StatusTemplateCopyWithImpl(this._self, this._then);

  final _StatusTemplate _self;
  final $Res Function(_StatusTemplate) _then;

/// Create a copy of StatusTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? baseDuration = null,Object? maxStacks = null,Object? isStackable = null,Object? isRefreshable = null,Object? isDispellable = null,Object? isRemovable = null,Object? isDetonable = null,Object? scope = null,Object? attributePerStack = null,Object? dotDamagePerStack = null,Object? hotHealingPerStack = null,Object? detonationMultiplier = null,Object? triggers = null,Object? color = null,Object? iconPath = null,}) {
  return _then(_StatusTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StatusType,baseDuration: null == baseDuration ? _self.baseDuration : baseDuration // ignore: cast_nullable_to_non_nullable
as int,maxStacks: null == maxStacks ? _self.maxStacks : maxStacks // ignore: cast_nullable_to_non_nullable
as int,isStackable: null == isStackable ? _self.isStackable : isStackable // ignore: cast_nullable_to_non_nullable
as bool,isRefreshable: null == isRefreshable ? _self.isRefreshable : isRefreshable // ignore: cast_nullable_to_non_nullable
as bool,isDispellable: null == isDispellable ? _self.isDispellable : isDispellable // ignore: cast_nullable_to_non_nullable
as bool,isRemovable: null == isRemovable ? _self.isRemovable : isRemovable // ignore: cast_nullable_to_non_nullable
as bool,isDetonable: null == isDetonable ? _self.isDetonable : isDetonable // ignore: cast_nullable_to_non_nullable
as bool,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as StatusScope,attributePerStack: null == attributePerStack ? _self._attributePerStack : attributePerStack // ignore: cast_nullable_to_non_nullable
as Map<AttributeType, double>,dotDamagePerStack: null == dotDamagePerStack ? _self.dotDamagePerStack : dotDamagePerStack // ignore: cast_nullable_to_non_nullable
as int,hotHealingPerStack: null == hotHealingPerStack ? _self.hotHealingPerStack : hotHealingPerStack // ignore: cast_nullable_to_non_nullable
as int,detonationMultiplier: null == detonationMultiplier ? _self.detonationMultiplier : detonationMultiplier // ignore: cast_nullable_to_non_nullable
as double,triggers: null == triggers ? _self._triggers : triggers // ignore: cast_nullable_to_non_nullable
as List<StatusTrigger>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
