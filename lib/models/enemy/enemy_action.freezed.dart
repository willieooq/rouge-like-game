// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enemy_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EnemyAction {

 String get id;// 行動ID
 String get name;// 行動名稱
 String get description;// 行動描述
 EnemyActionType get type;// 行動類型
 String get skillId;// 對應的技能ID
 int get priority;// 優先級（數字越小越優先）
 bool get isInterruptible;// 是否可被打斷
 bool get isTargetable;// 是否可被選中無效化
 String get color;// 顯示顏色
 String get iconPath;// 圖標路徑
 double get damageMultiplier;// 傷害倍率
 Map<String, dynamic> get parameters;
/// Create a copy of EnemyAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnemyActionCopyWith<EnemyAction> get copyWith => _$EnemyActionCopyWithImpl<EnemyAction>(this as EnemyAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnemyAction&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isInterruptible, isInterruptible) || other.isInterruptible == isInterruptible)&&(identical(other.isTargetable, isTargetable) || other.isTargetable == isTargetable)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.damageMultiplier, damageMultiplier) || other.damageMultiplier == damageMultiplier)&&const DeepCollectionEquality().equals(other.parameters, parameters));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,skillId,priority,isInterruptible,isTargetable,color,iconPath,damageMultiplier,const DeepCollectionEquality().hash(parameters));

@override
String toString() {
  return 'EnemyAction(id: $id, name: $name, description: $description, type: $type, skillId: $skillId, priority: $priority, isInterruptible: $isInterruptible, isTargetable: $isTargetable, color: $color, iconPath: $iconPath, damageMultiplier: $damageMultiplier, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class $EnemyActionCopyWith<$Res>  {
  factory $EnemyActionCopyWith(EnemyAction value, $Res Function(EnemyAction) _then) = _$EnemyActionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, EnemyActionType type, String skillId, int priority, bool isInterruptible, bool isTargetable, String color, String iconPath, double damageMultiplier, Map<String, dynamic> parameters
});




}
/// @nodoc
class _$EnemyActionCopyWithImpl<$Res>
    implements $EnemyActionCopyWith<$Res> {
  _$EnemyActionCopyWithImpl(this._self, this._then);

  final EnemyAction _self;
  final $Res Function(EnemyAction) _then;

/// Create a copy of EnemyAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? skillId = null,Object? priority = null,Object? isInterruptible = null,Object? isTargetable = null,Object? color = null,Object? iconPath = null,Object? damageMultiplier = null,Object? parameters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnemyActionType,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isInterruptible: null == isInterruptible ? _self.isInterruptible : isInterruptible // ignore: cast_nullable_to_non_nullable
as bool,isTargetable: null == isTargetable ? _self.isTargetable : isTargetable // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,damageMultiplier: null == damageMultiplier ? _self.damageMultiplier : damageMultiplier // ignore: cast_nullable_to_non_nullable
as double,parameters: null == parameters ? _self.parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [EnemyAction].
extension EnemyActionPatterns on EnemyAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnemyAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnemyAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnemyAction value)  $default,){
final _that = this;
switch (_that) {
case _EnemyAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnemyAction value)?  $default,){
final _that = this;
switch (_that) {
case _EnemyAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  EnemyActionType type,  String skillId,  int priority,  bool isInterruptible,  bool isTargetable,  String color,  String iconPath,  double damageMultiplier,  Map<String, dynamic> parameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnemyAction() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.skillId,_that.priority,_that.isInterruptible,_that.isTargetable,_that.color,_that.iconPath,_that.damageMultiplier,_that.parameters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  EnemyActionType type,  String skillId,  int priority,  bool isInterruptible,  bool isTargetable,  String color,  String iconPath,  double damageMultiplier,  Map<String, dynamic> parameters)  $default,) {final _that = this;
switch (_that) {
case _EnemyAction():
return $default(_that.id,_that.name,_that.description,_that.type,_that.skillId,_that.priority,_that.isInterruptible,_that.isTargetable,_that.color,_that.iconPath,_that.damageMultiplier,_that.parameters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  EnemyActionType type,  String skillId,  int priority,  bool isInterruptible,  bool isTargetable,  String color,  String iconPath,  double damageMultiplier,  Map<String, dynamic> parameters)?  $default,) {final _that = this;
switch (_that) {
case _EnemyAction() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.skillId,_that.priority,_that.isInterruptible,_that.isTargetable,_that.color,_that.iconPath,_that.damageMultiplier,_that.parameters);case _:
  return null;

}
}

}

/// @nodoc


class _EnemyAction implements EnemyAction {
  const _EnemyAction({required this.id, required this.name, required this.description, required this.type, required this.skillId, this.priority = 1, this.isInterruptible = false, this.isTargetable = true, this.color = '#FF6B6B', this.iconPath = '', this.damageMultiplier = 1.0, final  Map<String, dynamic> parameters = const {}}): _parameters = parameters;
  

@override final  String id;
// 行動ID
@override final  String name;
// 行動名稱
@override final  String description;
// 行動描述
@override final  EnemyActionType type;
// 行動類型
@override final  String skillId;
// 對應的技能ID
@override@JsonKey() final  int priority;
// 優先級（數字越小越優先）
@override@JsonKey() final  bool isInterruptible;
// 是否可被打斷
@override@JsonKey() final  bool isTargetable;
// 是否可被選中無效化
@override@JsonKey() final  String color;
// 顯示顏色
@override@JsonKey() final  String iconPath;
// 圖標路徑
@override@JsonKey() final  double damageMultiplier;
// 傷害倍率
 final  Map<String, dynamic> _parameters;
// 傷害倍率
@override@JsonKey() Map<String, dynamic> get parameters {
  if (_parameters is EqualUnmodifiableMapView) return _parameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_parameters);
}


/// Create a copy of EnemyAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnemyActionCopyWith<_EnemyAction> get copyWith => __$EnemyActionCopyWithImpl<_EnemyAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnemyAction&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isInterruptible, isInterruptible) || other.isInterruptible == isInterruptible)&&(identical(other.isTargetable, isTargetable) || other.isTargetable == isTargetable)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.damageMultiplier, damageMultiplier) || other.damageMultiplier == damageMultiplier)&&const DeepCollectionEquality().equals(other._parameters, _parameters));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,skillId,priority,isInterruptible,isTargetable,color,iconPath,damageMultiplier,const DeepCollectionEquality().hash(_parameters));

@override
String toString() {
  return 'EnemyAction(id: $id, name: $name, description: $description, type: $type, skillId: $skillId, priority: $priority, isInterruptible: $isInterruptible, isTargetable: $isTargetable, color: $color, iconPath: $iconPath, damageMultiplier: $damageMultiplier, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class _$EnemyActionCopyWith<$Res> implements $EnemyActionCopyWith<$Res> {
  factory _$EnemyActionCopyWith(_EnemyAction value, $Res Function(_EnemyAction) _then) = __$EnemyActionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, EnemyActionType type, String skillId, int priority, bool isInterruptible, bool isTargetable, String color, String iconPath, double damageMultiplier, Map<String, dynamic> parameters
});




}
/// @nodoc
class __$EnemyActionCopyWithImpl<$Res>
    implements _$EnemyActionCopyWith<$Res> {
  __$EnemyActionCopyWithImpl(this._self, this._then);

  final _EnemyAction _self;
  final $Res Function(_EnemyAction) _then;

/// Create a copy of EnemyAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? skillId = null,Object? priority = null,Object? isInterruptible = null,Object? isTargetable = null,Object? color = null,Object? iconPath = null,Object? damageMultiplier = null,Object? parameters = null,}) {
  return _then(_EnemyAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnemyActionType,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isInterruptible: null == isInterruptible ? _self.isInterruptible : isInterruptible // ignore: cast_nullable_to_non_nullable
as bool,isTargetable: null == isTargetable ? _self.isTargetable : isTargetable // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,damageMultiplier: null == damageMultiplier ? _self.damageMultiplier : damageMultiplier // ignore: cast_nullable_to_non_nullable
as double,parameters: null == parameters ? _self._parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
mixin _$EnemyActionResult {

 EnemyAction get action; bool get wasExecuted; int get damageDealt; int get healingReceived; List<String> get statusEffectsApplied; String get message;
/// Create a copy of EnemyActionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnemyActionResultCopyWith<EnemyActionResult> get copyWith => _$EnemyActionResultCopyWithImpl<EnemyActionResult>(this as EnemyActionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnemyActionResult&&(identical(other.action, action) || other.action == action)&&(identical(other.wasExecuted, wasExecuted) || other.wasExecuted == wasExecuted)&&(identical(other.damageDealt, damageDealt) || other.damageDealt == damageDealt)&&(identical(other.healingReceived, healingReceived) || other.healingReceived == healingReceived)&&const DeepCollectionEquality().equals(other.statusEffectsApplied, statusEffectsApplied)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,wasExecuted,damageDealt,healingReceived,const DeepCollectionEquality().hash(statusEffectsApplied),message);

@override
String toString() {
  return 'EnemyActionResult(action: $action, wasExecuted: $wasExecuted, damageDealt: $damageDealt, healingReceived: $healingReceived, statusEffectsApplied: $statusEffectsApplied, message: $message)';
}


}

/// @nodoc
abstract mixin class $EnemyActionResultCopyWith<$Res>  {
  factory $EnemyActionResultCopyWith(EnemyActionResult value, $Res Function(EnemyActionResult) _then) = _$EnemyActionResultCopyWithImpl;
@useResult
$Res call({
 EnemyAction action, bool wasExecuted, int damageDealt, int healingReceived, List<String> statusEffectsApplied, String message
});


$EnemyActionCopyWith<$Res> get action;

}
/// @nodoc
class _$EnemyActionResultCopyWithImpl<$Res>
    implements $EnemyActionResultCopyWith<$Res> {
  _$EnemyActionResultCopyWithImpl(this._self, this._then);

  final EnemyActionResult _self;
  final $Res Function(EnemyActionResult) _then;

/// Create a copy of EnemyActionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? wasExecuted = null,Object? damageDealt = null,Object? healingReceived = null,Object? statusEffectsApplied = null,Object? message = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as EnemyAction,wasExecuted: null == wasExecuted ? _self.wasExecuted : wasExecuted // ignore: cast_nullable_to_non_nullable
as bool,damageDealt: null == damageDealt ? _self.damageDealt : damageDealt // ignore: cast_nullable_to_non_nullable
as int,healingReceived: null == healingReceived ? _self.healingReceived : healingReceived // ignore: cast_nullable_to_non_nullable
as int,statusEffectsApplied: null == statusEffectsApplied ? _self.statusEffectsApplied : statusEffectsApplied // ignore: cast_nullable_to_non_nullable
as List<String>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of EnemyActionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyActionCopyWith<$Res> get action {
  
  return $EnemyActionCopyWith<$Res>(_self.action, (value) {
    return _then(_self.copyWith(action: value));
  });
}
}


/// Adds pattern-matching-related methods to [EnemyActionResult].
extension EnemyActionResultPatterns on EnemyActionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnemyActionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnemyActionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnemyActionResult value)  $default,){
final _that = this;
switch (_that) {
case _EnemyActionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnemyActionResult value)?  $default,){
final _that = this;
switch (_that) {
case _EnemyActionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EnemyAction action,  bool wasExecuted,  int damageDealt,  int healingReceived,  List<String> statusEffectsApplied,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnemyActionResult() when $default != null:
return $default(_that.action,_that.wasExecuted,_that.damageDealt,_that.healingReceived,_that.statusEffectsApplied,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EnemyAction action,  bool wasExecuted,  int damageDealt,  int healingReceived,  List<String> statusEffectsApplied,  String message)  $default,) {final _that = this;
switch (_that) {
case _EnemyActionResult():
return $default(_that.action,_that.wasExecuted,_that.damageDealt,_that.healingReceived,_that.statusEffectsApplied,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EnemyAction action,  bool wasExecuted,  int damageDealt,  int healingReceived,  List<String> statusEffectsApplied,  String message)?  $default,) {final _that = this;
switch (_that) {
case _EnemyActionResult() when $default != null:
return $default(_that.action,_that.wasExecuted,_that.damageDealt,_that.healingReceived,_that.statusEffectsApplied,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _EnemyActionResult implements EnemyActionResult {
  const _EnemyActionResult({required this.action, required this.wasExecuted, this.damageDealt = 0, this.healingReceived = 0, final  List<String> statusEffectsApplied = const [], this.message = ''}): _statusEffectsApplied = statusEffectsApplied;
  

@override final  EnemyAction action;
@override final  bool wasExecuted;
@override@JsonKey() final  int damageDealt;
@override@JsonKey() final  int healingReceived;
 final  List<String> _statusEffectsApplied;
@override@JsonKey() List<String> get statusEffectsApplied {
  if (_statusEffectsApplied is EqualUnmodifiableListView) return _statusEffectsApplied;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statusEffectsApplied);
}

@override@JsonKey() final  String message;

/// Create a copy of EnemyActionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnemyActionResultCopyWith<_EnemyActionResult> get copyWith => __$EnemyActionResultCopyWithImpl<_EnemyActionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnemyActionResult&&(identical(other.action, action) || other.action == action)&&(identical(other.wasExecuted, wasExecuted) || other.wasExecuted == wasExecuted)&&(identical(other.damageDealt, damageDealt) || other.damageDealt == damageDealt)&&(identical(other.healingReceived, healingReceived) || other.healingReceived == healingReceived)&&const DeepCollectionEquality().equals(other._statusEffectsApplied, _statusEffectsApplied)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,wasExecuted,damageDealt,healingReceived,const DeepCollectionEquality().hash(_statusEffectsApplied),message);

@override
String toString() {
  return 'EnemyActionResult(action: $action, wasExecuted: $wasExecuted, damageDealt: $damageDealt, healingReceived: $healingReceived, statusEffectsApplied: $statusEffectsApplied, message: $message)';
}


}

/// @nodoc
abstract mixin class _$EnemyActionResultCopyWith<$Res> implements $EnemyActionResultCopyWith<$Res> {
  factory _$EnemyActionResultCopyWith(_EnemyActionResult value, $Res Function(_EnemyActionResult) _then) = __$EnemyActionResultCopyWithImpl;
@override @useResult
$Res call({
 EnemyAction action, bool wasExecuted, int damageDealt, int healingReceived, List<String> statusEffectsApplied, String message
});


@override $EnemyActionCopyWith<$Res> get action;

}
/// @nodoc
class __$EnemyActionResultCopyWithImpl<$Res>
    implements _$EnemyActionResultCopyWith<$Res> {
  __$EnemyActionResultCopyWithImpl(this._self, this._then);

  final _EnemyActionResult _self;
  final $Res Function(_EnemyActionResult) _then;

/// Create a copy of EnemyActionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? wasExecuted = null,Object? damageDealt = null,Object? healingReceived = null,Object? statusEffectsApplied = null,Object? message = null,}) {
  return _then(_EnemyActionResult(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as EnemyAction,wasExecuted: null == wasExecuted ? _self.wasExecuted : wasExecuted // ignore: cast_nullable_to_non_nullable
as bool,damageDealt: null == damageDealt ? _self.damageDealt : damageDealt // ignore: cast_nullable_to_non_nullable
as int,healingReceived: null == healingReceived ? _self.healingReceived : healingReceived // ignore: cast_nullable_to_non_nullable
as int,statusEffectsApplied: null == statusEffectsApplied ? _self._statusEffectsApplied : statusEffectsApplied // ignore: cast_nullable_to_non_nullable
as List<String>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of EnemyActionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnemyActionCopyWith<$Res> get action {
  
  return $EnemyActionCopyWith<$Res>(_self.action, (value) {
    return _then(_self.copyWith(action: value));
  });
}
}

// dart format on
