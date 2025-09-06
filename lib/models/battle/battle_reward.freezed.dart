// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_reward.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardItem {

 int get quantity;
/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardItemCopyWith<RewardItem> get copyWith => _$RewardItemCopyWithImpl<RewardItem>(this as RewardItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardItem&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,quantity);

@override
String toString() {
  return 'RewardItem(quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $RewardItemCopyWith<$Res>  {
  factory $RewardItemCopyWith(RewardItem value, $Res Function(RewardItem) _then) = _$RewardItemCopyWithImpl;
@useResult
$Res call({
 int quantity
});




}
/// @nodoc
class _$RewardItemCopyWithImpl<$Res>
    implements $RewardItemCopyWith<$Res> {
  _$RewardItemCopyWithImpl(this._self, this._then);

  final RewardItem _self;
  final $Res Function(RewardItem) _then;

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quantity = null,}) {
  return _then(_self.copyWith(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardItem].
extension RewardItemPatterns on RewardItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RewardItemItem value)?  item,TResult Function( _RewardItemEquipment value)?  equipment,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardItemItem() when item != null:
return item(_that);case _RewardItemEquipment() when equipment != null:
return equipment(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RewardItemItem value)  item,required TResult Function( _RewardItemEquipment value)  equipment,}){
final _that = this;
switch (_that) {
case _RewardItemItem():
return item(_that);case _RewardItemEquipment():
return equipment(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RewardItemItem value)?  item,TResult? Function( _RewardItemEquipment value)?  equipment,}){
final _that = this;
switch (_that) {
case _RewardItemItem() when item != null:
return item(_that);case _RewardItemEquipment() when equipment != null:
return equipment(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Item item,  int quantity)?  item,TResult Function( Equipment equipment,  int quantity)?  equipment,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardItemItem() when item != null:
return item(_that.item,_that.quantity);case _RewardItemEquipment() when equipment != null:
return equipment(_that.equipment,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Item item,  int quantity)  item,required TResult Function( Equipment equipment,  int quantity)  equipment,}) {final _that = this;
switch (_that) {
case _RewardItemItem():
return item(_that.item,_that.quantity);case _RewardItemEquipment():
return equipment(_that.equipment,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Item item,  int quantity)?  item,TResult? Function( Equipment equipment,  int quantity)?  equipment,}) {final _that = this;
switch (_that) {
case _RewardItemItem() when item != null:
return item(_that.item,_that.quantity);case _RewardItemEquipment() when equipment != null:
return equipment(_that.equipment,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc


class _RewardItemItem implements RewardItem {
  const _RewardItemItem({required this.item, required this.quantity});
  

 final  Item item;
@override final  int quantity;

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardItemItemCopyWith<_RewardItemItem> get copyWith => __$RewardItemItemCopyWithImpl<_RewardItemItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardItemItem&&(identical(other.item, item) || other.item == item)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,item,quantity);

@override
String toString() {
  return 'RewardItem.item(item: $item, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$RewardItemItemCopyWith<$Res> implements $RewardItemCopyWith<$Res> {
  factory _$RewardItemItemCopyWith(_RewardItemItem value, $Res Function(_RewardItemItem) _then) = __$RewardItemItemCopyWithImpl;
@override @useResult
$Res call({
 Item item, int quantity
});


$ItemCopyWith<$Res> get item;

}
/// @nodoc
class __$RewardItemItemCopyWithImpl<$Res>
    implements _$RewardItemItemCopyWith<$Res> {
  __$RewardItemItemCopyWithImpl(this._self, this._then);

  final _RewardItemItem _self;
  final $Res Function(_RewardItemItem) _then;

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? quantity = null,}) {
  return _then(_RewardItemItem(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as Item,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemCopyWith<$Res> get item {
  
  return $ItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc


class _RewardItemEquipment implements RewardItem {
  const _RewardItemEquipment({required this.equipment, this.quantity = 1});
  

 final  Equipment equipment;
@override@JsonKey() final  int quantity;

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardItemEquipmentCopyWith<_RewardItemEquipment> get copyWith => __$RewardItemEquipmentCopyWithImpl<_RewardItemEquipment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardItemEquipment&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,equipment,quantity);

@override
String toString() {
  return 'RewardItem.equipment(equipment: $equipment, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$RewardItemEquipmentCopyWith<$Res> implements $RewardItemCopyWith<$Res> {
  factory _$RewardItemEquipmentCopyWith(_RewardItemEquipment value, $Res Function(_RewardItemEquipment) _then) = __$RewardItemEquipmentCopyWithImpl;
@override @useResult
$Res call({
 Equipment equipment, int quantity
});


$EquipmentCopyWith<$Res> get equipment;

}
/// @nodoc
class __$RewardItemEquipmentCopyWithImpl<$Res>
    implements _$RewardItemEquipmentCopyWith<$Res> {
  __$RewardItemEquipmentCopyWithImpl(this._self, this._then);

  final _RewardItemEquipment _self;
  final $Res Function(_RewardItemEquipment) _then;

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? equipment = null,Object? quantity = null,}) {
  return _then(_RewardItemEquipment(
equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as Equipment,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipmentCopyWith<$Res> get equipment {
  
  return $EquipmentCopyWith<$Res>(_self.equipment, (value) {
    return _then(_self.copyWith(equipment: value));
  });
}
}

/// @nodoc
mixin _$BattleRewards {

 int get baseExp; int get bonusExp; int get baseGold; int get bonusGold; List<RewardItem> get items;// 物品和裝備獎勵
 List<String> get unlockedSkills; double get expMultiplier; double get goldMultiplier; String get battleSummary;
/// Create a copy of BattleRewards
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BattleRewardsCopyWith<BattleRewards> get copyWith => _$BattleRewardsCopyWithImpl<BattleRewards>(this as BattleRewards, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BattleRewards&&(identical(other.baseExp, baseExp) || other.baseExp == baseExp)&&(identical(other.bonusExp, bonusExp) || other.bonusExp == bonusExp)&&(identical(other.baseGold, baseGold) || other.baseGold == baseGold)&&(identical(other.bonusGold, bonusGold) || other.bonusGold == bonusGold)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.unlockedSkills, unlockedSkills)&&(identical(other.expMultiplier, expMultiplier) || other.expMultiplier == expMultiplier)&&(identical(other.goldMultiplier, goldMultiplier) || other.goldMultiplier == goldMultiplier)&&(identical(other.battleSummary, battleSummary) || other.battleSummary == battleSummary));
}


@override
int get hashCode => Object.hash(runtimeType,baseExp,bonusExp,baseGold,bonusGold,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(unlockedSkills),expMultiplier,goldMultiplier,battleSummary);

@override
String toString() {
  return 'BattleRewards(baseExp: $baseExp, bonusExp: $bonusExp, baseGold: $baseGold, bonusGold: $bonusGold, items: $items, unlockedSkills: $unlockedSkills, expMultiplier: $expMultiplier, goldMultiplier: $goldMultiplier, battleSummary: $battleSummary)';
}


}

/// @nodoc
abstract mixin class $BattleRewardsCopyWith<$Res>  {
  factory $BattleRewardsCopyWith(BattleRewards value, $Res Function(BattleRewards) _then) = _$BattleRewardsCopyWithImpl;
@useResult
$Res call({
 int baseExp, int bonusExp, int baseGold, int bonusGold, List<RewardItem> items, List<String> unlockedSkills, double expMultiplier, double goldMultiplier, String battleSummary
});




}
/// @nodoc
class _$BattleRewardsCopyWithImpl<$Res>
    implements $BattleRewardsCopyWith<$Res> {
  _$BattleRewardsCopyWithImpl(this._self, this._then);

  final BattleRewards _self;
  final $Res Function(BattleRewards) _then;

/// Create a copy of BattleRewards
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseExp = null,Object? bonusExp = null,Object? baseGold = null,Object? bonusGold = null,Object? items = null,Object? unlockedSkills = null,Object? expMultiplier = null,Object? goldMultiplier = null,Object? battleSummary = null,}) {
  return _then(_self.copyWith(
baseExp: null == baseExp ? _self.baseExp : baseExp // ignore: cast_nullable_to_non_nullable
as int,bonusExp: null == bonusExp ? _self.bonusExp : bonusExp // ignore: cast_nullable_to_non_nullable
as int,baseGold: null == baseGold ? _self.baseGold : baseGold // ignore: cast_nullable_to_non_nullable
as int,bonusGold: null == bonusGold ? _self.bonusGold : bonusGold // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RewardItem>,unlockedSkills: null == unlockedSkills ? _self.unlockedSkills : unlockedSkills // ignore: cast_nullable_to_non_nullable
as List<String>,expMultiplier: null == expMultiplier ? _self.expMultiplier : expMultiplier // ignore: cast_nullable_to_non_nullable
as double,goldMultiplier: null == goldMultiplier ? _self.goldMultiplier : goldMultiplier // ignore: cast_nullable_to_non_nullable
as double,battleSummary: null == battleSummary ? _self.battleSummary : battleSummary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BattleRewards].
extension BattleRewardsPatterns on BattleRewards {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BattleRewards value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BattleRewards() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BattleRewards value)  $default,){
final _that = this;
switch (_that) {
case _BattleRewards():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BattleRewards value)?  $default,){
final _that = this;
switch (_that) {
case _BattleRewards() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int baseExp,  int bonusExp,  int baseGold,  int bonusGold,  List<RewardItem> items,  List<String> unlockedSkills,  double expMultiplier,  double goldMultiplier,  String battleSummary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BattleRewards() when $default != null:
return $default(_that.baseExp,_that.bonusExp,_that.baseGold,_that.bonusGold,_that.items,_that.unlockedSkills,_that.expMultiplier,_that.goldMultiplier,_that.battleSummary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int baseExp,  int bonusExp,  int baseGold,  int bonusGold,  List<RewardItem> items,  List<String> unlockedSkills,  double expMultiplier,  double goldMultiplier,  String battleSummary)  $default,) {final _that = this;
switch (_that) {
case _BattleRewards():
return $default(_that.baseExp,_that.bonusExp,_that.baseGold,_that.bonusGold,_that.items,_that.unlockedSkills,_that.expMultiplier,_that.goldMultiplier,_that.battleSummary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int baseExp,  int bonusExp,  int baseGold,  int bonusGold,  List<RewardItem> items,  List<String> unlockedSkills,  double expMultiplier,  double goldMultiplier,  String battleSummary)?  $default,) {final _that = this;
switch (_that) {
case _BattleRewards() when $default != null:
return $default(_that.baseExp,_that.bonusExp,_that.baseGold,_that.bonusGold,_that.items,_that.unlockedSkills,_that.expMultiplier,_that.goldMultiplier,_that.battleSummary);case _:
  return null;

}
}

}

/// @nodoc


class _BattleRewards implements BattleRewards {
  const _BattleRewards({required this.baseExp, required this.bonusExp, required this.baseGold, required this.bonusGold, required final  List<RewardItem> items, required final  List<String> unlockedSkills, this.expMultiplier = 1.0, this.goldMultiplier = 1.0, this.battleSummary = ''}): _items = items,_unlockedSkills = unlockedSkills;
  

@override final  int baseExp;
@override final  int bonusExp;
@override final  int baseGold;
@override final  int bonusGold;
 final  List<RewardItem> _items;
@override List<RewardItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

// 物品和裝備獎勵
 final  List<String> _unlockedSkills;
// 物品和裝備獎勵
@override List<String> get unlockedSkills {
  if (_unlockedSkills is EqualUnmodifiableListView) return _unlockedSkills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unlockedSkills);
}

@override@JsonKey() final  double expMultiplier;
@override@JsonKey() final  double goldMultiplier;
@override@JsonKey() final  String battleSummary;

/// Create a copy of BattleRewards
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BattleRewardsCopyWith<_BattleRewards> get copyWith => __$BattleRewardsCopyWithImpl<_BattleRewards>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BattleRewards&&(identical(other.baseExp, baseExp) || other.baseExp == baseExp)&&(identical(other.bonusExp, bonusExp) || other.bonusExp == bonusExp)&&(identical(other.baseGold, baseGold) || other.baseGold == baseGold)&&(identical(other.bonusGold, bonusGold) || other.bonusGold == bonusGold)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._unlockedSkills, _unlockedSkills)&&(identical(other.expMultiplier, expMultiplier) || other.expMultiplier == expMultiplier)&&(identical(other.goldMultiplier, goldMultiplier) || other.goldMultiplier == goldMultiplier)&&(identical(other.battleSummary, battleSummary) || other.battleSummary == battleSummary));
}


@override
int get hashCode => Object.hash(runtimeType,baseExp,bonusExp,baseGold,bonusGold,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_unlockedSkills),expMultiplier,goldMultiplier,battleSummary);

@override
String toString() {
  return 'BattleRewards(baseExp: $baseExp, bonusExp: $bonusExp, baseGold: $baseGold, bonusGold: $bonusGold, items: $items, unlockedSkills: $unlockedSkills, expMultiplier: $expMultiplier, goldMultiplier: $goldMultiplier, battleSummary: $battleSummary)';
}


}

/// @nodoc
abstract mixin class _$BattleRewardsCopyWith<$Res> implements $BattleRewardsCopyWith<$Res> {
  factory _$BattleRewardsCopyWith(_BattleRewards value, $Res Function(_BattleRewards) _then) = __$BattleRewardsCopyWithImpl;
@override @useResult
$Res call({
 int baseExp, int bonusExp, int baseGold, int bonusGold, List<RewardItem> items, List<String> unlockedSkills, double expMultiplier, double goldMultiplier, String battleSummary
});




}
/// @nodoc
class __$BattleRewardsCopyWithImpl<$Res>
    implements _$BattleRewardsCopyWith<$Res> {
  __$BattleRewardsCopyWithImpl(this._self, this._then);

  final _BattleRewards _self;
  final $Res Function(_BattleRewards) _then;

/// Create a copy of BattleRewards
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseExp = null,Object? bonusExp = null,Object? baseGold = null,Object? bonusGold = null,Object? items = null,Object? unlockedSkills = null,Object? expMultiplier = null,Object? goldMultiplier = null,Object? battleSummary = null,}) {
  return _then(_BattleRewards(
baseExp: null == baseExp ? _self.baseExp : baseExp // ignore: cast_nullable_to_non_nullable
as int,bonusExp: null == bonusExp ? _self.bonusExp : bonusExp // ignore: cast_nullable_to_non_nullable
as int,baseGold: null == baseGold ? _self.baseGold : baseGold // ignore: cast_nullable_to_non_nullable
as int,bonusGold: null == bonusGold ? _self.bonusGold : bonusGold // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RewardItem>,unlockedSkills: null == unlockedSkills ? _self._unlockedSkills : unlockedSkills // ignore: cast_nullable_to_non_nullable
as List<String>,expMultiplier: null == expMultiplier ? _self.expMultiplier : expMultiplier // ignore: cast_nullable_to_non_nullable
as double,goldMultiplier: null == goldMultiplier ? _self.goldMultiplier : goldMultiplier // ignore: cast_nullable_to_non_nullable
as double,battleSummary: null == battleSummary ? _self.battleSummary : battleSummary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BattleResultSummary {

 int get turnCount; int get totalDamageDealt; int get totalDamageReceived; int get totalHealingDone; List<String> get skillsUsed; Map<String, int> get statusEffectsApplied; int get perfectTurns;// 沒有受到傷害的回合數
 bool get flawlessVictory;
/// Create a copy of BattleResultSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BattleResultSummaryCopyWith<BattleResultSummary> get copyWith => _$BattleResultSummaryCopyWithImpl<BattleResultSummary>(this as BattleResultSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BattleResultSummary&&(identical(other.turnCount, turnCount) || other.turnCount == turnCount)&&(identical(other.totalDamageDealt, totalDamageDealt) || other.totalDamageDealt == totalDamageDealt)&&(identical(other.totalDamageReceived, totalDamageReceived) || other.totalDamageReceived == totalDamageReceived)&&(identical(other.totalHealingDone, totalHealingDone) || other.totalHealingDone == totalHealingDone)&&const DeepCollectionEquality().equals(other.skillsUsed, skillsUsed)&&const DeepCollectionEquality().equals(other.statusEffectsApplied, statusEffectsApplied)&&(identical(other.perfectTurns, perfectTurns) || other.perfectTurns == perfectTurns)&&(identical(other.flawlessVictory, flawlessVictory) || other.flawlessVictory == flawlessVictory));
}


@override
int get hashCode => Object.hash(runtimeType,turnCount,totalDamageDealt,totalDamageReceived,totalHealingDone,const DeepCollectionEquality().hash(skillsUsed),const DeepCollectionEquality().hash(statusEffectsApplied),perfectTurns,flawlessVictory);

@override
String toString() {
  return 'BattleResultSummary(turnCount: $turnCount, totalDamageDealt: $totalDamageDealt, totalDamageReceived: $totalDamageReceived, totalHealingDone: $totalHealingDone, skillsUsed: $skillsUsed, statusEffectsApplied: $statusEffectsApplied, perfectTurns: $perfectTurns, flawlessVictory: $flawlessVictory)';
}


}

/// @nodoc
abstract mixin class $BattleResultSummaryCopyWith<$Res>  {
  factory $BattleResultSummaryCopyWith(BattleResultSummary value, $Res Function(BattleResultSummary) _then) = _$BattleResultSummaryCopyWithImpl;
@useResult
$Res call({
 int turnCount, int totalDamageDealt, int totalDamageReceived, int totalHealingDone, List<String> skillsUsed, Map<String, int> statusEffectsApplied, int perfectTurns, bool flawlessVictory
});




}
/// @nodoc
class _$BattleResultSummaryCopyWithImpl<$Res>
    implements $BattleResultSummaryCopyWith<$Res> {
  _$BattleResultSummaryCopyWithImpl(this._self, this._then);

  final BattleResultSummary _self;
  final $Res Function(BattleResultSummary) _then;

/// Create a copy of BattleResultSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? turnCount = null,Object? totalDamageDealt = null,Object? totalDamageReceived = null,Object? totalHealingDone = null,Object? skillsUsed = null,Object? statusEffectsApplied = null,Object? perfectTurns = null,Object? flawlessVictory = null,}) {
  return _then(_self.copyWith(
turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,totalDamageDealt: null == totalDamageDealt ? _self.totalDamageDealt : totalDamageDealt // ignore: cast_nullable_to_non_nullable
as int,totalDamageReceived: null == totalDamageReceived ? _self.totalDamageReceived : totalDamageReceived // ignore: cast_nullable_to_non_nullable
as int,totalHealingDone: null == totalHealingDone ? _self.totalHealingDone : totalHealingDone // ignore: cast_nullable_to_non_nullable
as int,skillsUsed: null == skillsUsed ? _self.skillsUsed : skillsUsed // ignore: cast_nullable_to_non_nullable
as List<String>,statusEffectsApplied: null == statusEffectsApplied ? _self.statusEffectsApplied : statusEffectsApplied // ignore: cast_nullable_to_non_nullable
as Map<String, int>,perfectTurns: null == perfectTurns ? _self.perfectTurns : perfectTurns // ignore: cast_nullable_to_non_nullable
as int,flawlessVictory: null == flawlessVictory ? _self.flawlessVictory : flawlessVictory // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BattleResultSummary].
extension BattleResultSummaryPatterns on BattleResultSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BattleResultSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BattleResultSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BattleResultSummary value)  $default,){
final _that = this;
switch (_that) {
case _BattleResultSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BattleResultSummary value)?  $default,){
final _that = this;
switch (_that) {
case _BattleResultSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int turnCount,  int totalDamageDealt,  int totalDamageReceived,  int totalHealingDone,  List<String> skillsUsed,  Map<String, int> statusEffectsApplied,  int perfectTurns,  bool flawlessVictory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BattleResultSummary() when $default != null:
return $default(_that.turnCount,_that.totalDamageDealt,_that.totalDamageReceived,_that.totalHealingDone,_that.skillsUsed,_that.statusEffectsApplied,_that.perfectTurns,_that.flawlessVictory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int turnCount,  int totalDamageDealt,  int totalDamageReceived,  int totalHealingDone,  List<String> skillsUsed,  Map<String, int> statusEffectsApplied,  int perfectTurns,  bool flawlessVictory)  $default,) {final _that = this;
switch (_that) {
case _BattleResultSummary():
return $default(_that.turnCount,_that.totalDamageDealt,_that.totalDamageReceived,_that.totalHealingDone,_that.skillsUsed,_that.statusEffectsApplied,_that.perfectTurns,_that.flawlessVictory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int turnCount,  int totalDamageDealt,  int totalDamageReceived,  int totalHealingDone,  List<String> skillsUsed,  Map<String, int> statusEffectsApplied,  int perfectTurns,  bool flawlessVictory)?  $default,) {final _that = this;
switch (_that) {
case _BattleResultSummary() when $default != null:
return $default(_that.turnCount,_that.totalDamageDealt,_that.totalDamageReceived,_that.totalHealingDone,_that.skillsUsed,_that.statusEffectsApplied,_that.perfectTurns,_that.flawlessVictory);case _:
  return null;

}
}

}

/// @nodoc


class _BattleResultSummary implements BattleResultSummary {
  const _BattleResultSummary({required this.turnCount, required this.totalDamageDealt, required this.totalDamageReceived, required this.totalHealingDone, required final  List<String> skillsUsed, required final  Map<String, int> statusEffectsApplied, required this.perfectTurns, required this.flawlessVictory}): _skillsUsed = skillsUsed,_statusEffectsApplied = statusEffectsApplied;
  

@override final  int turnCount;
@override final  int totalDamageDealt;
@override final  int totalDamageReceived;
@override final  int totalHealingDone;
 final  List<String> _skillsUsed;
@override List<String> get skillsUsed {
  if (_skillsUsed is EqualUnmodifiableListView) return _skillsUsed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skillsUsed);
}

 final  Map<String, int> _statusEffectsApplied;
@override Map<String, int> get statusEffectsApplied {
  if (_statusEffectsApplied is EqualUnmodifiableMapView) return _statusEffectsApplied;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statusEffectsApplied);
}

@override final  int perfectTurns;
// 沒有受到傷害的回合數
@override final  bool flawlessVictory;

/// Create a copy of BattleResultSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BattleResultSummaryCopyWith<_BattleResultSummary> get copyWith => __$BattleResultSummaryCopyWithImpl<_BattleResultSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BattleResultSummary&&(identical(other.turnCount, turnCount) || other.turnCount == turnCount)&&(identical(other.totalDamageDealt, totalDamageDealt) || other.totalDamageDealt == totalDamageDealt)&&(identical(other.totalDamageReceived, totalDamageReceived) || other.totalDamageReceived == totalDamageReceived)&&(identical(other.totalHealingDone, totalHealingDone) || other.totalHealingDone == totalHealingDone)&&const DeepCollectionEquality().equals(other._skillsUsed, _skillsUsed)&&const DeepCollectionEquality().equals(other._statusEffectsApplied, _statusEffectsApplied)&&(identical(other.perfectTurns, perfectTurns) || other.perfectTurns == perfectTurns)&&(identical(other.flawlessVictory, flawlessVictory) || other.flawlessVictory == flawlessVictory));
}


@override
int get hashCode => Object.hash(runtimeType,turnCount,totalDamageDealt,totalDamageReceived,totalHealingDone,const DeepCollectionEquality().hash(_skillsUsed),const DeepCollectionEquality().hash(_statusEffectsApplied),perfectTurns,flawlessVictory);

@override
String toString() {
  return 'BattleResultSummary(turnCount: $turnCount, totalDamageDealt: $totalDamageDealt, totalDamageReceived: $totalDamageReceived, totalHealingDone: $totalHealingDone, skillsUsed: $skillsUsed, statusEffectsApplied: $statusEffectsApplied, perfectTurns: $perfectTurns, flawlessVictory: $flawlessVictory)';
}


}

/// @nodoc
abstract mixin class _$BattleResultSummaryCopyWith<$Res> implements $BattleResultSummaryCopyWith<$Res> {
  factory _$BattleResultSummaryCopyWith(_BattleResultSummary value, $Res Function(_BattleResultSummary) _then) = __$BattleResultSummaryCopyWithImpl;
@override @useResult
$Res call({
 int turnCount, int totalDamageDealt, int totalDamageReceived, int totalHealingDone, List<String> skillsUsed, Map<String, int> statusEffectsApplied, int perfectTurns, bool flawlessVictory
});




}
/// @nodoc
class __$BattleResultSummaryCopyWithImpl<$Res>
    implements _$BattleResultSummaryCopyWith<$Res> {
  __$BattleResultSummaryCopyWithImpl(this._self, this._then);

  final _BattleResultSummary _self;
  final $Res Function(_BattleResultSummary) _then;

/// Create a copy of BattleResultSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? turnCount = null,Object? totalDamageDealt = null,Object? totalDamageReceived = null,Object? totalHealingDone = null,Object? skillsUsed = null,Object? statusEffectsApplied = null,Object? perfectTurns = null,Object? flawlessVictory = null,}) {
  return _then(_BattleResultSummary(
turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,totalDamageDealt: null == totalDamageDealt ? _self.totalDamageDealt : totalDamageDealt // ignore: cast_nullable_to_non_nullable
as int,totalDamageReceived: null == totalDamageReceived ? _self.totalDamageReceived : totalDamageReceived // ignore: cast_nullable_to_non_nullable
as int,totalHealingDone: null == totalHealingDone ? _self.totalHealingDone : totalHealingDone // ignore: cast_nullable_to_non_nullable
as int,skillsUsed: null == skillsUsed ? _self._skillsUsed : skillsUsed // ignore: cast_nullable_to_non_nullable
as List<String>,statusEffectsApplied: null == statusEffectsApplied ? _self._statusEffectsApplied : statusEffectsApplied // ignore: cast_nullable_to_non_nullable
as Map<String, int>,perfectTurns: null == perfectTurns ? _self.perfectTurns : perfectTurns // ignore: cast_nullable_to_non_nullable
as int,flawlessVictory: null == flawlessVictory ? _self.flawlessVictory : flawlessVictory // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$LootTemplate {

 String get id; String get name; LootType get type; Rarity get rarity; int get minQuantity; int get maxQuantity; double get dropWeight; String get description; String get iconPath; List<String> get tags;
/// Create a copy of LootTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LootTemplateCopyWith<LootTemplate> get copyWith => _$LootTemplateCopyWithImpl<LootTemplate>(this as LootTemplate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LootTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.minQuantity, minQuantity) || other.minQuantity == minQuantity)&&(identical(other.maxQuantity, maxQuantity) || other.maxQuantity == maxQuantity)&&(identical(other.dropWeight, dropWeight) || other.dropWeight == dropWeight)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,rarity,minQuantity,maxQuantity,dropWeight,description,iconPath,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'LootTemplate(id: $id, name: $name, type: $type, rarity: $rarity, minQuantity: $minQuantity, maxQuantity: $maxQuantity, dropWeight: $dropWeight, description: $description, iconPath: $iconPath, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $LootTemplateCopyWith<$Res>  {
  factory $LootTemplateCopyWith(LootTemplate value, $Res Function(LootTemplate) _then) = _$LootTemplateCopyWithImpl;
@useResult
$Res call({
 String id, String name, LootType type, Rarity rarity, int minQuantity, int maxQuantity, double dropWeight, String description, String iconPath, List<String> tags
});




}
/// @nodoc
class _$LootTemplateCopyWithImpl<$Res>
    implements $LootTemplateCopyWith<$Res> {
  _$LootTemplateCopyWithImpl(this._self, this._then);

  final LootTemplate _self;
  final $Res Function(LootTemplate) _then;

/// Create a copy of LootTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? rarity = null,Object? minQuantity = null,Object? maxQuantity = null,Object? dropWeight = null,Object? description = null,Object? iconPath = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LootType,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,minQuantity: null == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int,maxQuantity: null == maxQuantity ? _self.maxQuantity : maxQuantity // ignore: cast_nullable_to_non_nullable
as int,dropWeight: null == dropWeight ? _self.dropWeight : dropWeight // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LootTemplate].
extension LootTemplatePatterns on LootTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LootTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LootTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LootTemplate value)  $default,){
final _that = this;
switch (_that) {
case _LootTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LootTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _LootTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  LootType type,  Rarity rarity,  int minQuantity,  int maxQuantity,  double dropWeight,  String description,  String iconPath,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LootTemplate() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.rarity,_that.minQuantity,_that.maxQuantity,_that.dropWeight,_that.description,_that.iconPath,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  LootType type,  Rarity rarity,  int minQuantity,  int maxQuantity,  double dropWeight,  String description,  String iconPath,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _LootTemplate():
return $default(_that.id,_that.name,_that.type,_that.rarity,_that.minQuantity,_that.maxQuantity,_that.dropWeight,_that.description,_that.iconPath,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  LootType type,  Rarity rarity,  int minQuantity,  int maxQuantity,  double dropWeight,  String description,  String iconPath,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _LootTemplate() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.rarity,_that.minQuantity,_that.maxQuantity,_that.dropWeight,_that.description,_that.iconPath,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _LootTemplate implements LootTemplate {
  const _LootTemplate({required this.id, required this.name, required this.type, required this.rarity, required this.minQuantity, required this.maxQuantity, required this.dropWeight, this.description = '', this.iconPath = '', final  List<String> tags = const []}): _tags = tags;
  

@override final  String id;
@override final  String name;
@override final  LootType type;
@override final  Rarity rarity;
@override final  int minQuantity;
@override final  int maxQuantity;
@override final  double dropWeight;
@override@JsonKey() final  String description;
@override@JsonKey() final  String iconPath;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of LootTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LootTemplateCopyWith<_LootTemplate> get copyWith => __$LootTemplateCopyWithImpl<_LootTemplate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LootTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.minQuantity, minQuantity) || other.minQuantity == minQuantity)&&(identical(other.maxQuantity, maxQuantity) || other.maxQuantity == maxQuantity)&&(identical(other.dropWeight, dropWeight) || other.dropWeight == dropWeight)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,rarity,minQuantity,maxQuantity,dropWeight,description,iconPath,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'LootTemplate(id: $id, name: $name, type: $type, rarity: $rarity, minQuantity: $minQuantity, maxQuantity: $maxQuantity, dropWeight: $dropWeight, description: $description, iconPath: $iconPath, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$LootTemplateCopyWith<$Res> implements $LootTemplateCopyWith<$Res> {
  factory _$LootTemplateCopyWith(_LootTemplate value, $Res Function(_LootTemplate) _then) = __$LootTemplateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, LootType type, Rarity rarity, int minQuantity, int maxQuantity, double dropWeight, String description, String iconPath, List<String> tags
});




}
/// @nodoc
class __$LootTemplateCopyWithImpl<$Res>
    implements _$LootTemplateCopyWith<$Res> {
  __$LootTemplateCopyWithImpl(this._self, this._then);

  final _LootTemplate _self;
  final $Res Function(_LootTemplate) _then;

/// Create a copy of LootTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? rarity = null,Object? minQuantity = null,Object? maxQuantity = null,Object? dropWeight = null,Object? description = null,Object? iconPath = null,Object? tags = null,}) {
  return _then(_LootTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LootType,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,minQuantity: null == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int,maxQuantity: null == maxQuantity ? _self.maxQuantity : maxQuantity // ignore: cast_nullable_to_non_nullable
as int,dropWeight: null == dropWeight ? _self.dropWeight : dropWeight // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$LootGroup {

 String get id; String get name; List<String> get itemIds; double get dropChance; bool get guaranteedDrop;
/// Create a copy of LootGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LootGroupCopyWith<LootGroup> get copyWith => _$LootGroupCopyWithImpl<LootGroup>(this as LootGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LootGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.itemIds, itemIds)&&(identical(other.dropChance, dropChance) || other.dropChance == dropChance)&&(identical(other.guaranteedDrop, guaranteedDrop) || other.guaranteedDrop == guaranteedDrop));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(itemIds),dropChance,guaranteedDrop);

@override
String toString() {
  return 'LootGroup(id: $id, name: $name, itemIds: $itemIds, dropChance: $dropChance, guaranteedDrop: $guaranteedDrop)';
}


}

/// @nodoc
abstract mixin class $LootGroupCopyWith<$Res>  {
  factory $LootGroupCopyWith(LootGroup value, $Res Function(LootGroup) _then) = _$LootGroupCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> itemIds, double dropChance, bool guaranteedDrop
});




}
/// @nodoc
class _$LootGroupCopyWithImpl<$Res>
    implements $LootGroupCopyWith<$Res> {
  _$LootGroupCopyWithImpl(this._self, this._then);

  final LootGroup _self;
  final $Res Function(LootGroup) _then;

/// Create a copy of LootGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? itemIds = null,Object? dropChance = null,Object? guaranteedDrop = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,itemIds: null == itemIds ? _self.itemIds : itemIds // ignore: cast_nullable_to_non_nullable
as List<String>,dropChance: null == dropChance ? _self.dropChance : dropChance // ignore: cast_nullable_to_non_nullable
as double,guaranteedDrop: null == guaranteedDrop ? _self.guaranteedDrop : guaranteedDrop // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LootGroup].
extension LootGroupPatterns on LootGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LootGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LootGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LootGroup value)  $default,){
final _that = this;
switch (_that) {
case _LootGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LootGroup value)?  $default,){
final _that = this;
switch (_that) {
case _LootGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> itemIds,  double dropChance,  bool guaranteedDrop)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LootGroup() when $default != null:
return $default(_that.id,_that.name,_that.itemIds,_that.dropChance,_that.guaranteedDrop);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> itemIds,  double dropChance,  bool guaranteedDrop)  $default,) {final _that = this;
switch (_that) {
case _LootGroup():
return $default(_that.id,_that.name,_that.itemIds,_that.dropChance,_that.guaranteedDrop);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> itemIds,  double dropChance,  bool guaranteedDrop)?  $default,) {final _that = this;
switch (_that) {
case _LootGroup() when $default != null:
return $default(_that.id,_that.name,_that.itemIds,_that.dropChance,_that.guaranteedDrop);case _:
  return null;

}
}

}

/// @nodoc


class _LootGroup implements LootGroup {
  const _LootGroup({required this.id, required this.name, required final  List<String> itemIds, required this.dropChance, this.guaranteedDrop = false}): _itemIds = itemIds;
  

@override final  String id;
@override final  String name;
 final  List<String> _itemIds;
@override List<String> get itemIds {
  if (_itemIds is EqualUnmodifiableListView) return _itemIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemIds);
}

@override final  double dropChance;
@override@JsonKey() final  bool guaranteedDrop;

/// Create a copy of LootGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LootGroupCopyWith<_LootGroup> get copyWith => __$LootGroupCopyWithImpl<_LootGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LootGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._itemIds, _itemIds)&&(identical(other.dropChance, dropChance) || other.dropChance == dropChance)&&(identical(other.guaranteedDrop, guaranteedDrop) || other.guaranteedDrop == guaranteedDrop));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_itemIds),dropChance,guaranteedDrop);

@override
String toString() {
  return 'LootGroup(id: $id, name: $name, itemIds: $itemIds, dropChance: $dropChance, guaranteedDrop: $guaranteedDrop)';
}


}

/// @nodoc
abstract mixin class _$LootGroupCopyWith<$Res> implements $LootGroupCopyWith<$Res> {
  factory _$LootGroupCopyWith(_LootGroup value, $Res Function(_LootGroup) _then) = __$LootGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> itemIds, double dropChance, bool guaranteedDrop
});




}
/// @nodoc
class __$LootGroupCopyWithImpl<$Res>
    implements _$LootGroupCopyWith<$Res> {
  __$LootGroupCopyWithImpl(this._self, this._then);

  final _LootGroup _self;
  final $Res Function(_LootGroup) _then;

/// Create a copy of LootGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? itemIds = null,Object? dropChance = null,Object? guaranteedDrop = null,}) {
  return _then(_LootGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,itemIds: null == itemIds ? _self._itemIds : itemIds // ignore: cast_nullable_to_non_nullable
as List<String>,dropChance: null == dropChance ? _self.dropChance : dropChance // ignore: cast_nullable_to_non_nullable
as double,guaranteedDrop: null == guaranteedDrop ? _self.guaranteedDrop : guaranteedDrop // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
