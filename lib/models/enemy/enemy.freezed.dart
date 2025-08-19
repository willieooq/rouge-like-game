// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enemy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Enemy {

 String get id; String get name; EnemyType get type; AIBehavior get aiBehavior;// 基礎屬性
 int get maxHp; int get currentHp; int get attack; int get defense; int get speed;// 視覺相關
 String get iconPath; String get description; String get primaryColor;// 深紅色作為默認敵人色
 String get secondaryColor;// 番茄紅作為輔助色
// 戰鬥相關
 List<String> get skillIds;// 敵人可使用的技能ID列表
 List<String> get statusEffects;// 當前狀態效果
// AI相關
 double get aggressionLevel;// 攻擊傾向 0.0-2.0
 double get selfPreservation;// 自保傾向 0.0-1.0
// 戰利品相關
 int get expReward; int get goldReward; List<String> get lootTable;// 可能掉落的道具ID
// 元數據
 int get level; bool get isBoss;
/// Create a copy of Enemy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnemyCopyWith<Enemy> get copyWith => _$EnemyCopyWithImpl<Enemy>(this as Enemy, _$identity);

  /// Serializes this Enemy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Enemy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.aiBehavior, aiBehavior) || other.aiBehavior == aiBehavior)&&(identical(other.maxHp, maxHp) || other.maxHp == maxHp)&&(identical(other.currentHp, currentHp) || other.currentHp == currentHp)&&(identical(other.attack, attack) || other.attack == attack)&&(identical(other.defense, defense) || other.defense == defense)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.description, description) || other.description == description)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&const DeepCollectionEquality().equals(other.skillIds, skillIds)&&const DeepCollectionEquality().equals(other.statusEffects, statusEffects)&&(identical(other.aggressionLevel, aggressionLevel) || other.aggressionLevel == aggressionLevel)&&(identical(other.selfPreservation, selfPreservation) || other.selfPreservation == selfPreservation)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.goldReward, goldReward) || other.goldReward == goldReward)&&const DeepCollectionEquality().equals(other.lootTable, lootTable)&&(identical(other.level, level) || other.level == level)&&(identical(other.isBoss, isBoss) || other.isBoss == isBoss));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,type,aiBehavior,maxHp,currentHp,attack,defense,speed,iconPath,description,primaryColor,secondaryColor,const DeepCollectionEquality().hash(skillIds),const DeepCollectionEquality().hash(statusEffects),aggressionLevel,selfPreservation,expReward,goldReward,const DeepCollectionEquality().hash(lootTable),level,isBoss]);

@override
String toString() {
  return 'Enemy(id: $id, name: $name, type: $type, aiBehavior: $aiBehavior, maxHp: $maxHp, currentHp: $currentHp, attack: $attack, defense: $defense, speed: $speed, iconPath: $iconPath, description: $description, primaryColor: $primaryColor, secondaryColor: $secondaryColor, skillIds: $skillIds, statusEffects: $statusEffects, aggressionLevel: $aggressionLevel, selfPreservation: $selfPreservation, expReward: $expReward, goldReward: $goldReward, lootTable: $lootTable, level: $level, isBoss: $isBoss)';
}


}

/// @nodoc
abstract mixin class $EnemyCopyWith<$Res>  {
  factory $EnemyCopyWith(Enemy value, $Res Function(Enemy) _then) = _$EnemyCopyWithImpl;
@useResult
$Res call({
 String id, String name, EnemyType type, AIBehavior aiBehavior, int maxHp, int currentHp, int attack, int defense, int speed, String iconPath, String description, String primaryColor, String secondaryColor, List<String> skillIds, List<String> statusEffects, double aggressionLevel, double selfPreservation, int expReward, int goldReward, List<String> lootTable, int level, bool isBoss
});




}
/// @nodoc
class _$EnemyCopyWithImpl<$Res>
    implements $EnemyCopyWith<$Res> {
  _$EnemyCopyWithImpl(this._self, this._then);

  final Enemy _self;
  final $Res Function(Enemy) _then;

/// Create a copy of Enemy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? aiBehavior = null,Object? maxHp = null,Object? currentHp = null,Object? attack = null,Object? defense = null,Object? speed = null,Object? iconPath = null,Object? description = null,Object? primaryColor = null,Object? secondaryColor = null,Object? skillIds = null,Object? statusEffects = null,Object? aggressionLevel = null,Object? selfPreservation = null,Object? expReward = null,Object? goldReward = null,Object? lootTable = null,Object? level = null,Object? isBoss = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnemyType,aiBehavior: null == aiBehavior ? _self.aiBehavior : aiBehavior // ignore: cast_nullable_to_non_nullable
as AIBehavior,maxHp: null == maxHp ? _self.maxHp : maxHp // ignore: cast_nullable_to_non_nullable
as int,currentHp: null == currentHp ? _self.currentHp : currentHp // ignore: cast_nullable_to_non_nullable
as int,attack: null == attack ? _self.attack : attack // ignore: cast_nullable_to_non_nullable
as int,defense: null == defense ? _self.defense : defense // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as int,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,skillIds: null == skillIds ? _self.skillIds : skillIds // ignore: cast_nullable_to_non_nullable
as List<String>,statusEffects: null == statusEffects ? _self.statusEffects : statusEffects // ignore: cast_nullable_to_non_nullable
as List<String>,aggressionLevel: null == aggressionLevel ? _self.aggressionLevel : aggressionLevel // ignore: cast_nullable_to_non_nullable
as double,selfPreservation: null == selfPreservation ? _self.selfPreservation : selfPreservation // ignore: cast_nullable_to_non_nullable
as double,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,goldReward: null == goldReward ? _self.goldReward : goldReward // ignore: cast_nullable_to_non_nullable
as int,lootTable: null == lootTable ? _self.lootTable : lootTable // ignore: cast_nullable_to_non_nullable
as List<String>,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,isBoss: null == isBoss ? _self.isBoss : isBoss // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Enemy].
extension EnemyPatterns on Enemy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Enemy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Enemy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Enemy value)  $default,){
final _that = this;
switch (_that) {
case _Enemy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Enemy value)?  $default,){
final _that = this;
switch (_that) {
case _Enemy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  EnemyType type,  AIBehavior aiBehavior,  int maxHp,  int currentHp,  int attack,  int defense,  int speed,  String iconPath,  String description,  String primaryColor,  String secondaryColor,  List<String> skillIds,  List<String> statusEffects,  double aggressionLevel,  double selfPreservation,  int expReward,  int goldReward,  List<String> lootTable,  int level,  bool isBoss)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Enemy() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.aiBehavior,_that.maxHp,_that.currentHp,_that.attack,_that.defense,_that.speed,_that.iconPath,_that.description,_that.primaryColor,_that.secondaryColor,_that.skillIds,_that.statusEffects,_that.aggressionLevel,_that.selfPreservation,_that.expReward,_that.goldReward,_that.lootTable,_that.level,_that.isBoss);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  EnemyType type,  AIBehavior aiBehavior,  int maxHp,  int currentHp,  int attack,  int defense,  int speed,  String iconPath,  String description,  String primaryColor,  String secondaryColor,  List<String> skillIds,  List<String> statusEffects,  double aggressionLevel,  double selfPreservation,  int expReward,  int goldReward,  List<String> lootTable,  int level,  bool isBoss)  $default,) {final _that = this;
switch (_that) {
case _Enemy():
return $default(_that.id,_that.name,_that.type,_that.aiBehavior,_that.maxHp,_that.currentHp,_that.attack,_that.defense,_that.speed,_that.iconPath,_that.description,_that.primaryColor,_that.secondaryColor,_that.skillIds,_that.statusEffects,_that.aggressionLevel,_that.selfPreservation,_that.expReward,_that.goldReward,_that.lootTable,_that.level,_that.isBoss);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  EnemyType type,  AIBehavior aiBehavior,  int maxHp,  int currentHp,  int attack,  int defense,  int speed,  String iconPath,  String description,  String primaryColor,  String secondaryColor,  List<String> skillIds,  List<String> statusEffects,  double aggressionLevel,  double selfPreservation,  int expReward,  int goldReward,  List<String> lootTable,  int level,  bool isBoss)?  $default,) {final _that = this;
switch (_that) {
case _Enemy() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.aiBehavior,_that.maxHp,_that.currentHp,_that.attack,_that.defense,_that.speed,_that.iconPath,_that.description,_that.primaryColor,_that.secondaryColor,_that.skillIds,_that.statusEffects,_that.aggressionLevel,_that.selfPreservation,_that.expReward,_that.goldReward,_that.lootTable,_that.level,_that.isBoss);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Enemy implements Enemy {
  const _Enemy({required this.id, required this.name, required this.type, required this.aiBehavior, required this.maxHp, required this.currentHp, required this.attack, required this.defense, required this.speed, required this.iconPath, required this.description, this.primaryColor = '#8B0000', this.secondaryColor = '#FF6347', required final  List<String> skillIds, final  List<String> statusEffects = const [], this.aggressionLevel = 1.0, this.selfPreservation = 0.5, this.expReward = 0, this.goldReward = 0, final  List<String> lootTable = const [], this.level = 1, this.isBoss = false}): _skillIds = skillIds,_statusEffects = statusEffects,_lootTable = lootTable;
  factory _Enemy.fromJson(Map<String, dynamic> json) => _$EnemyFromJson(json);

@override final  String id;
@override final  String name;
@override final  EnemyType type;
@override final  AIBehavior aiBehavior;
// 基礎屬性
@override final  int maxHp;
@override final  int currentHp;
@override final  int attack;
@override final  int defense;
@override final  int speed;
// 視覺相關
@override final  String iconPath;
@override final  String description;
@override@JsonKey() final  String primaryColor;
// 深紅色作為默認敵人色
@override@JsonKey() final  String secondaryColor;
// 番茄紅作為輔助色
// 戰鬥相關
 final  List<String> _skillIds;
// 番茄紅作為輔助色
// 戰鬥相關
@override List<String> get skillIds {
  if (_skillIds is EqualUnmodifiableListView) return _skillIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skillIds);
}

// 敵人可使用的技能ID列表
 final  List<String> _statusEffects;
// 敵人可使用的技能ID列表
@override@JsonKey() List<String> get statusEffects {
  if (_statusEffects is EqualUnmodifiableListView) return _statusEffects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statusEffects);
}

// 當前狀態效果
// AI相關
@override@JsonKey() final  double aggressionLevel;
// 攻擊傾向 0.0-2.0
@override@JsonKey() final  double selfPreservation;
// 自保傾向 0.0-1.0
// 戰利品相關
@override@JsonKey() final  int expReward;
@override@JsonKey() final  int goldReward;
 final  List<String> _lootTable;
@override@JsonKey() List<String> get lootTable {
  if (_lootTable is EqualUnmodifiableListView) return _lootTable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lootTable);
}

// 可能掉落的道具ID
// 元數據
@override@JsonKey() final  int level;
@override@JsonKey() final  bool isBoss;

/// Create a copy of Enemy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnemyCopyWith<_Enemy> get copyWith => __$EnemyCopyWithImpl<_Enemy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnemyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Enemy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.aiBehavior, aiBehavior) || other.aiBehavior == aiBehavior)&&(identical(other.maxHp, maxHp) || other.maxHp == maxHp)&&(identical(other.currentHp, currentHp) || other.currentHp == currentHp)&&(identical(other.attack, attack) || other.attack == attack)&&(identical(other.defense, defense) || other.defense == defense)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.description, description) || other.description == description)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&const DeepCollectionEquality().equals(other._skillIds, _skillIds)&&const DeepCollectionEquality().equals(other._statusEffects, _statusEffects)&&(identical(other.aggressionLevel, aggressionLevel) || other.aggressionLevel == aggressionLevel)&&(identical(other.selfPreservation, selfPreservation) || other.selfPreservation == selfPreservation)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.goldReward, goldReward) || other.goldReward == goldReward)&&const DeepCollectionEquality().equals(other._lootTable, _lootTable)&&(identical(other.level, level) || other.level == level)&&(identical(other.isBoss, isBoss) || other.isBoss == isBoss));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,type,aiBehavior,maxHp,currentHp,attack,defense,speed,iconPath,description,primaryColor,secondaryColor,const DeepCollectionEquality().hash(_skillIds),const DeepCollectionEquality().hash(_statusEffects),aggressionLevel,selfPreservation,expReward,goldReward,const DeepCollectionEquality().hash(_lootTable),level,isBoss]);

@override
String toString() {
  return 'Enemy(id: $id, name: $name, type: $type, aiBehavior: $aiBehavior, maxHp: $maxHp, currentHp: $currentHp, attack: $attack, defense: $defense, speed: $speed, iconPath: $iconPath, description: $description, primaryColor: $primaryColor, secondaryColor: $secondaryColor, skillIds: $skillIds, statusEffects: $statusEffects, aggressionLevel: $aggressionLevel, selfPreservation: $selfPreservation, expReward: $expReward, goldReward: $goldReward, lootTable: $lootTable, level: $level, isBoss: $isBoss)';
}


}

/// @nodoc
abstract mixin class _$EnemyCopyWith<$Res> implements $EnemyCopyWith<$Res> {
  factory _$EnemyCopyWith(_Enemy value, $Res Function(_Enemy) _then) = __$EnemyCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, EnemyType type, AIBehavior aiBehavior, int maxHp, int currentHp, int attack, int defense, int speed, String iconPath, String description, String primaryColor, String secondaryColor, List<String> skillIds, List<String> statusEffects, double aggressionLevel, double selfPreservation, int expReward, int goldReward, List<String> lootTable, int level, bool isBoss
});




}
/// @nodoc
class __$EnemyCopyWithImpl<$Res>
    implements _$EnemyCopyWith<$Res> {
  __$EnemyCopyWithImpl(this._self, this._then);

  final _Enemy _self;
  final $Res Function(_Enemy) _then;

/// Create a copy of Enemy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? aiBehavior = null,Object? maxHp = null,Object? currentHp = null,Object? attack = null,Object? defense = null,Object? speed = null,Object? iconPath = null,Object? description = null,Object? primaryColor = null,Object? secondaryColor = null,Object? skillIds = null,Object? statusEffects = null,Object? aggressionLevel = null,Object? selfPreservation = null,Object? expReward = null,Object? goldReward = null,Object? lootTable = null,Object? level = null,Object? isBoss = null,}) {
  return _then(_Enemy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnemyType,aiBehavior: null == aiBehavior ? _self.aiBehavior : aiBehavior // ignore: cast_nullable_to_non_nullable
as AIBehavior,maxHp: null == maxHp ? _self.maxHp : maxHp // ignore: cast_nullable_to_non_nullable
as int,currentHp: null == currentHp ? _self.currentHp : currentHp // ignore: cast_nullable_to_non_nullable
as int,attack: null == attack ? _self.attack : attack // ignore: cast_nullable_to_non_nullable
as int,defense: null == defense ? _self.defense : defense // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as int,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,skillIds: null == skillIds ? _self._skillIds : skillIds // ignore: cast_nullable_to_non_nullable
as List<String>,statusEffects: null == statusEffects ? _self._statusEffects : statusEffects // ignore: cast_nullable_to_non_nullable
as List<String>,aggressionLevel: null == aggressionLevel ? _self.aggressionLevel : aggressionLevel // ignore: cast_nullable_to_non_nullable
as double,selfPreservation: null == selfPreservation ? _self.selfPreservation : selfPreservation // ignore: cast_nullable_to_non_nullable
as double,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,goldReward: null == goldReward ? _self.goldReward : goldReward // ignore: cast_nullable_to_non_nullable
as int,lootTable: null == lootTable ? _self._lootTable : lootTable // ignore: cast_nullable_to_non_nullable
as List<String>,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,isBoss: null == isBoss ? _self.isBoss : isBoss // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EnemyData {

 String get id; String get name; EnemyType get type; AIBehavior get aiBehavior; int get baseHp; int get baseAttack; int get baseDefense; int get baseSpeed; String get iconPath; String get description; String get primaryColor; String get secondaryColor; List<String> get skillIds; double get aggressionLevel; double get selfPreservation; int get baseExpReward; int get baseGoldReward; List<String> get lootTable;
/// Create a copy of EnemyData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnemyDataCopyWith<EnemyData> get copyWith => _$EnemyDataCopyWithImpl<EnemyData>(this as EnemyData, _$identity);

  /// Serializes this EnemyData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnemyData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.aiBehavior, aiBehavior) || other.aiBehavior == aiBehavior)&&(identical(other.baseHp, baseHp) || other.baseHp == baseHp)&&(identical(other.baseAttack, baseAttack) || other.baseAttack == baseAttack)&&(identical(other.baseDefense, baseDefense) || other.baseDefense == baseDefense)&&(identical(other.baseSpeed, baseSpeed) || other.baseSpeed == baseSpeed)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.description, description) || other.description == description)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&const DeepCollectionEquality().equals(other.skillIds, skillIds)&&(identical(other.aggressionLevel, aggressionLevel) || other.aggressionLevel == aggressionLevel)&&(identical(other.selfPreservation, selfPreservation) || other.selfPreservation == selfPreservation)&&(identical(other.baseExpReward, baseExpReward) || other.baseExpReward == baseExpReward)&&(identical(other.baseGoldReward, baseGoldReward) || other.baseGoldReward == baseGoldReward)&&const DeepCollectionEquality().equals(other.lootTable, lootTable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,aiBehavior,baseHp,baseAttack,baseDefense,baseSpeed,iconPath,description,primaryColor,secondaryColor,const DeepCollectionEquality().hash(skillIds),aggressionLevel,selfPreservation,baseExpReward,baseGoldReward,const DeepCollectionEquality().hash(lootTable));

@override
String toString() {
  return 'EnemyData(id: $id, name: $name, type: $type, aiBehavior: $aiBehavior, baseHp: $baseHp, baseAttack: $baseAttack, baseDefense: $baseDefense, baseSpeed: $baseSpeed, iconPath: $iconPath, description: $description, primaryColor: $primaryColor, secondaryColor: $secondaryColor, skillIds: $skillIds, aggressionLevel: $aggressionLevel, selfPreservation: $selfPreservation, baseExpReward: $baseExpReward, baseGoldReward: $baseGoldReward, lootTable: $lootTable)';
}


}

/// @nodoc
abstract mixin class $EnemyDataCopyWith<$Res>  {
  factory $EnemyDataCopyWith(EnemyData value, $Res Function(EnemyData) _then) = _$EnemyDataCopyWithImpl;
@useResult
$Res call({
 String id, String name, EnemyType type, AIBehavior aiBehavior, int baseHp, int baseAttack, int baseDefense, int baseSpeed, String iconPath, String description, String primaryColor, String secondaryColor, List<String> skillIds, double aggressionLevel, double selfPreservation, int baseExpReward, int baseGoldReward, List<String> lootTable
});




}
/// @nodoc
class _$EnemyDataCopyWithImpl<$Res>
    implements $EnemyDataCopyWith<$Res> {
  _$EnemyDataCopyWithImpl(this._self, this._then);

  final EnemyData _self;
  final $Res Function(EnemyData) _then;

/// Create a copy of EnemyData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? aiBehavior = null,Object? baseHp = null,Object? baseAttack = null,Object? baseDefense = null,Object? baseSpeed = null,Object? iconPath = null,Object? description = null,Object? primaryColor = null,Object? secondaryColor = null,Object? skillIds = null,Object? aggressionLevel = null,Object? selfPreservation = null,Object? baseExpReward = null,Object? baseGoldReward = null,Object? lootTable = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnemyType,aiBehavior: null == aiBehavior ? _self.aiBehavior : aiBehavior // ignore: cast_nullable_to_non_nullable
as AIBehavior,baseHp: null == baseHp ? _self.baseHp : baseHp // ignore: cast_nullable_to_non_nullable
as int,baseAttack: null == baseAttack ? _self.baseAttack : baseAttack // ignore: cast_nullable_to_non_nullable
as int,baseDefense: null == baseDefense ? _self.baseDefense : baseDefense // ignore: cast_nullable_to_non_nullable
as int,baseSpeed: null == baseSpeed ? _self.baseSpeed : baseSpeed // ignore: cast_nullable_to_non_nullable
as int,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,skillIds: null == skillIds ? _self.skillIds : skillIds // ignore: cast_nullable_to_non_nullable
as List<String>,aggressionLevel: null == aggressionLevel ? _self.aggressionLevel : aggressionLevel // ignore: cast_nullable_to_non_nullable
as double,selfPreservation: null == selfPreservation ? _self.selfPreservation : selfPreservation // ignore: cast_nullable_to_non_nullable
as double,baseExpReward: null == baseExpReward ? _self.baseExpReward : baseExpReward // ignore: cast_nullable_to_non_nullable
as int,baseGoldReward: null == baseGoldReward ? _self.baseGoldReward : baseGoldReward // ignore: cast_nullable_to_non_nullable
as int,lootTable: null == lootTable ? _self.lootTable : lootTable // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EnemyData].
extension EnemyDataPatterns on EnemyData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnemyData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnemyData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnemyData value)  $default,){
final _that = this;
switch (_that) {
case _EnemyData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnemyData value)?  $default,){
final _that = this;
switch (_that) {
case _EnemyData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  EnemyType type,  AIBehavior aiBehavior,  int baseHp,  int baseAttack,  int baseDefense,  int baseSpeed,  String iconPath,  String description,  String primaryColor,  String secondaryColor,  List<String> skillIds,  double aggressionLevel,  double selfPreservation,  int baseExpReward,  int baseGoldReward,  List<String> lootTable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnemyData() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.aiBehavior,_that.baseHp,_that.baseAttack,_that.baseDefense,_that.baseSpeed,_that.iconPath,_that.description,_that.primaryColor,_that.secondaryColor,_that.skillIds,_that.aggressionLevel,_that.selfPreservation,_that.baseExpReward,_that.baseGoldReward,_that.lootTable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  EnemyType type,  AIBehavior aiBehavior,  int baseHp,  int baseAttack,  int baseDefense,  int baseSpeed,  String iconPath,  String description,  String primaryColor,  String secondaryColor,  List<String> skillIds,  double aggressionLevel,  double selfPreservation,  int baseExpReward,  int baseGoldReward,  List<String> lootTable)  $default,) {final _that = this;
switch (_that) {
case _EnemyData():
return $default(_that.id,_that.name,_that.type,_that.aiBehavior,_that.baseHp,_that.baseAttack,_that.baseDefense,_that.baseSpeed,_that.iconPath,_that.description,_that.primaryColor,_that.secondaryColor,_that.skillIds,_that.aggressionLevel,_that.selfPreservation,_that.baseExpReward,_that.baseGoldReward,_that.lootTable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  EnemyType type,  AIBehavior aiBehavior,  int baseHp,  int baseAttack,  int baseDefense,  int baseSpeed,  String iconPath,  String description,  String primaryColor,  String secondaryColor,  List<String> skillIds,  double aggressionLevel,  double selfPreservation,  int baseExpReward,  int baseGoldReward,  List<String> lootTable)?  $default,) {final _that = this;
switch (_that) {
case _EnemyData() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.aiBehavior,_that.baseHp,_that.baseAttack,_that.baseDefense,_that.baseSpeed,_that.iconPath,_that.description,_that.primaryColor,_that.secondaryColor,_that.skillIds,_that.aggressionLevel,_that.selfPreservation,_that.baseExpReward,_that.baseGoldReward,_that.lootTable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnemyData implements EnemyData {
  const _EnemyData({required this.id, required this.name, required this.type, required this.aiBehavior, required this.baseHp, required this.baseAttack, required this.baseDefense, required this.baseSpeed, required this.iconPath, required this.description, this.primaryColor = '#8B0000', this.secondaryColor = '#FF6347', required final  List<String> skillIds, this.aggressionLevel = 1.0, this.selfPreservation = 0.5, this.baseExpReward = 0, this.baseGoldReward = 0, final  List<String> lootTable = const []}): _skillIds = skillIds,_lootTable = lootTable;
  factory _EnemyData.fromJson(Map<String, dynamic> json) => _$EnemyDataFromJson(json);

@override final  String id;
@override final  String name;
@override final  EnemyType type;
@override final  AIBehavior aiBehavior;
@override final  int baseHp;
@override final  int baseAttack;
@override final  int baseDefense;
@override final  int baseSpeed;
@override final  String iconPath;
@override final  String description;
@override@JsonKey() final  String primaryColor;
@override@JsonKey() final  String secondaryColor;
 final  List<String> _skillIds;
@override List<String> get skillIds {
  if (_skillIds is EqualUnmodifiableListView) return _skillIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skillIds);
}

@override@JsonKey() final  double aggressionLevel;
@override@JsonKey() final  double selfPreservation;
@override@JsonKey() final  int baseExpReward;
@override@JsonKey() final  int baseGoldReward;
 final  List<String> _lootTable;
@override@JsonKey() List<String> get lootTable {
  if (_lootTable is EqualUnmodifiableListView) return _lootTable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lootTable);
}


/// Create a copy of EnemyData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnemyDataCopyWith<_EnemyData> get copyWith => __$EnemyDataCopyWithImpl<_EnemyData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnemyDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnemyData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.aiBehavior, aiBehavior) || other.aiBehavior == aiBehavior)&&(identical(other.baseHp, baseHp) || other.baseHp == baseHp)&&(identical(other.baseAttack, baseAttack) || other.baseAttack == baseAttack)&&(identical(other.baseDefense, baseDefense) || other.baseDefense == baseDefense)&&(identical(other.baseSpeed, baseSpeed) || other.baseSpeed == baseSpeed)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.description, description) || other.description == description)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&const DeepCollectionEquality().equals(other._skillIds, _skillIds)&&(identical(other.aggressionLevel, aggressionLevel) || other.aggressionLevel == aggressionLevel)&&(identical(other.selfPreservation, selfPreservation) || other.selfPreservation == selfPreservation)&&(identical(other.baseExpReward, baseExpReward) || other.baseExpReward == baseExpReward)&&(identical(other.baseGoldReward, baseGoldReward) || other.baseGoldReward == baseGoldReward)&&const DeepCollectionEquality().equals(other._lootTable, _lootTable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,aiBehavior,baseHp,baseAttack,baseDefense,baseSpeed,iconPath,description,primaryColor,secondaryColor,const DeepCollectionEquality().hash(_skillIds),aggressionLevel,selfPreservation,baseExpReward,baseGoldReward,const DeepCollectionEquality().hash(_lootTable));

@override
String toString() {
  return 'EnemyData(id: $id, name: $name, type: $type, aiBehavior: $aiBehavior, baseHp: $baseHp, baseAttack: $baseAttack, baseDefense: $baseDefense, baseSpeed: $baseSpeed, iconPath: $iconPath, description: $description, primaryColor: $primaryColor, secondaryColor: $secondaryColor, skillIds: $skillIds, aggressionLevel: $aggressionLevel, selfPreservation: $selfPreservation, baseExpReward: $baseExpReward, baseGoldReward: $baseGoldReward, lootTable: $lootTable)';
}


}

/// @nodoc
abstract mixin class _$EnemyDataCopyWith<$Res> implements $EnemyDataCopyWith<$Res> {
  factory _$EnemyDataCopyWith(_EnemyData value, $Res Function(_EnemyData) _then) = __$EnemyDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, EnemyType type, AIBehavior aiBehavior, int baseHp, int baseAttack, int baseDefense, int baseSpeed, String iconPath, String description, String primaryColor, String secondaryColor, List<String> skillIds, double aggressionLevel, double selfPreservation, int baseExpReward, int baseGoldReward, List<String> lootTable
});




}
/// @nodoc
class __$EnemyDataCopyWithImpl<$Res>
    implements _$EnemyDataCopyWith<$Res> {
  __$EnemyDataCopyWithImpl(this._self, this._then);

  final _EnemyData _self;
  final $Res Function(_EnemyData) _then;

/// Create a copy of EnemyData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? aiBehavior = null,Object? baseHp = null,Object? baseAttack = null,Object? baseDefense = null,Object? baseSpeed = null,Object? iconPath = null,Object? description = null,Object? primaryColor = null,Object? secondaryColor = null,Object? skillIds = null,Object? aggressionLevel = null,Object? selfPreservation = null,Object? baseExpReward = null,Object? baseGoldReward = null,Object? lootTable = null,}) {
  return _then(_EnemyData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnemyType,aiBehavior: null == aiBehavior ? _self.aiBehavior : aiBehavior // ignore: cast_nullable_to_non_nullable
as AIBehavior,baseHp: null == baseHp ? _self.baseHp : baseHp // ignore: cast_nullable_to_non_nullable
as int,baseAttack: null == baseAttack ? _self.baseAttack : baseAttack // ignore: cast_nullable_to_non_nullable
as int,baseDefense: null == baseDefense ? _self.baseDefense : baseDefense // ignore: cast_nullable_to_non_nullable
as int,baseSpeed: null == baseSpeed ? _self.baseSpeed : baseSpeed // ignore: cast_nullable_to_non_nullable
as int,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,skillIds: null == skillIds ? _self._skillIds : skillIds // ignore: cast_nullable_to_non_nullable
as List<String>,aggressionLevel: null == aggressionLevel ? _self.aggressionLevel : aggressionLevel // ignore: cast_nullable_to_non_nullable
as double,selfPreservation: null == selfPreservation ? _self.selfPreservation : selfPreservation // ignore: cast_nullable_to_non_nullable
as double,baseExpReward: null == baseExpReward ? _self.baseExpReward : baseExpReward // ignore: cast_nullable_to_non_nullable
as int,baseGoldReward: null == baseGoldReward ? _self.baseGoldReward : baseGoldReward // ignore: cast_nullable_to_non_nullable
as int,lootTable: null == lootTable ? _self._lootTable : lootTable // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
