// lib/models/item/equipment.dart
import 'package:freezed_annotation/freezed_annotation.dart';

import 'item.dart'; // 引用稀有度

part 'equipment.freezed.dart';
part 'equipment.g.dart';

/// 裝備類型
enum EquipmentType {
  @JsonValue('weapon')
  weapon, // 武器
  @JsonValue('armor')
  armor, // 護甲
  @JsonValue('helmet')
  helmet, // 頭盔
  @JsonValue('gloves')
  gloves, // 手套
  @JsonValue('boots')
  boots, // 靴子
  @JsonValue('accessory')
  accessory, // 飾品
}

/// 裝備特殊效果（預留架構）
@freezed
abstract class EquipmentEffect with _$EquipmentEffect {
  const factory EquipmentEffect({
    required String id,
    required String name,
    required String description,
    @Default({}) Map<String, dynamic> parameters,
  }) = _EquipmentEffect;

  factory EquipmentEffect.fromJson(Map<String, dynamic> json) =>
      _$EquipmentEffectFromJson(json);
}

/// 裝備模型
@freezed
abstract class Equipment with _$Equipment {
  const factory Equipment({
    required String id,
    required String name,
    required Rarity rare,
    required String description,
    required EquipmentType type,
    required int atk, // 攻擊力
    required int hp, // 生命值
    required List<EquipmentEffect> effect, // 特殊效果
    required int price,
    @Default('') String iconPath,
    @Default(1) int level, // 裝備等級
    @Default(0) int durability, // 耐久度（0表示不消耗）
    @Default(0) int maxDurability, // 最大耐久度
  }) = _Equipment;

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);
}

/// 裝備擴展方法
extension EquipmentExtension on Equipment {
  /// 獲取稀有度顏色
  String get rarityColor {
    switch (rare) {
      case Rarity.common:
        return '#FFFFFF';
      case Rarity.uncommon:
        return '#1EFF00';
      case Rarity.rare:
        return '#0070DD';
      case Rarity.epic:
        return '#A335EE';
      case Rarity.legendary:
        return '#FF8000';
    }
  }

  /// 獲取稀有度中文名
  String get rarityName {
    switch (rare) {
      case Rarity.common:
        return '常見';
      case Rarity.uncommon:
        return '不常見';
      case Rarity.rare:
        return '稀有';
      case Rarity.epic:
        return '史詩';
      case Rarity.legendary:
        return '傳說';
    }
  }

  /// 獲取裝備類型中文名
  String get typeName {
    switch (type) {
      case EquipmentType.weapon:
        return '武器';
      case EquipmentType.armor:
        return '護甲';
      case EquipmentType.helmet:
        return '頭盔';
      case EquipmentType.gloves:
        return '手套';
      case EquipmentType.boots:
        return '靴子';
      case EquipmentType.accessory:
        return '飾品';
    }
  }

  /// 是否損壞
  bool get isBroken => maxDurability > 0 && durability <= 0;

  /// 耐久度百分比
  double get durabilityPercentage {
    if (maxDurability <= 0) return 1.0;
    return durability / maxDurability;
  }

  /// 計算總攻擊力（考慮耐久度）
  int get effectiveAtk {
    if (isBroken) return (atk * 0.5).round(); // 損壞時效果減半
    return atk;
  }

  /// 計算總生命值（考慮耐久度）
  int get effectiveHp {
    if (isBroken) return (hp * 0.5).round(); // 損壞時效果減半
    return hp;
  }
}
