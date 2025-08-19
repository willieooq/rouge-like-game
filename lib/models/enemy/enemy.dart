// lib/models/enemy/enemy.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'enemy.freezed.dart';
part 'enemy.g.dart';

/// 敵人類型枚舉
enum EnemyType {
  @JsonValue('normal')
  normal,
  @JsonValue('elite')
  elite,
  @JsonValue('boss')
  boss,
}

/// 敵人AI行為模式
enum AIBehavior {
  @JsonValue('aggressive')
  aggressive, // 攻擊性：優先攻擊低血量角色
  @JsonValue('defensive')
  defensive, // 防守型：優先使用防禦技能
  @JsonValue('balanced')
  balanced, // 平衡型：隨機選擇行動
  @JsonValue('support')
  support, // 輔助型：優先治療盟友
}

/// 敵人數據模型
@freezed
abstract class Enemy with _$Enemy {
  const factory Enemy({
    required String id,
    required String name,
    required EnemyType type,
    required AIBehavior aiBehavior,

    // 基礎屬性
    required int maxHp,
    required int currentHp,
    required int attack,
    required int defense,
    required int speed,

    // 視覺相關
    required String iconPath,
    required String description,
    @Default('#8B0000') String primaryColor, // 深紅色作為默認敵人色
    @Default('#FF6347') String secondaryColor, // 番茄紅作為輔助色
    // 戰鬥相關
    required List<String> skillIds, // 敵人可使用的技能ID列表
    @Default([]) List<String> statusEffects, // 當前狀態效果
    // AI相關
    @Default(1.0) double aggressionLevel, // 攻擊傾向 0.0-2.0
    @Default(0.5) double selfPreservation, // 自保傾向 0.0-1.0
    // 戰利品相關
    @Default(0) int expReward,
    @Default(0) int goldReward,
    @Default([]) List<String> lootTable, // 可能掉落的道具ID
    // 元數據
    @Default(1) int level,
    @Default(false) bool isBoss,
  }) = _Enemy;

  factory Enemy.fromJson(Map<String, dynamic> json) => _$EnemyFromJson(json);
}

/// 敵人數據配置 (用於從JSON加載)
@freezed
abstract class EnemyData with _$EnemyData {
  const factory EnemyData({
    required String id,
    required String name,
    required EnemyType type,
    required AIBehavior aiBehavior,
    required int baseHp,
    required int baseAttack,
    required int baseDefense,
    required int baseSpeed,
    required String iconPath,
    required String description,
    @Default('#8B0000') String primaryColor,
    @Default('#FF6347') String secondaryColor,
    required List<String> skillIds,
    @Default(1.0) double aggressionLevel,
    @Default(0.5) double selfPreservation,
    @Default(0) int baseExpReward,
    @Default(0) int baseGoldReward,
    @Default([]) List<String> lootTable,
  }) = _EnemyData;

  factory EnemyData.fromJson(Map<String, dynamic> json) =>
      _$EnemyDataFromJson(json);
}

/// 敵人擴展方法
extension EnemyExtension on Enemy {
  /// 檢查是否死亡
  bool get isDead => currentHp <= 0;

  /// 檢查是否滿血
  bool get isFullHp => currentHp >= maxHp;

  /// 血量百分比
  double get hpPercentage => currentHp / maxHp;

  /// 是否處於危險狀態 (血量低於30%)
  bool get isInDanger => hpPercentage < 0.3;

  /// 是否為精英或Boss
  bool get isEliteOrBoss => type == EnemyType.elite || type == EnemyType.boss;

  /// 根據等級縮放屬性
  Enemy scaleByLevel(int targetLevel) {
    if (targetLevel <= level) return this;

    double scaleFactor = 1.0 + ((targetLevel - level) * 0.15);

    return copyWith(
      level: targetLevel,
      maxHp: (maxHp * scaleFactor).round(),
      currentHp: (maxHp * scaleFactor).round(),
      attack: (attack * scaleFactor).round(),
      defense: (defense * scaleFactor).round(),
      expReward: (expReward * scaleFactor).round(),
      goldReward: (goldReward * scaleFactor).round(),
    );
  }

  /// 受到傷害
  Enemy takeDamage(int damage) {
    int actualDamage = (damage - defense).clamp(1, damage);
    int newHp = (currentHp - actualDamage).clamp(0, maxHp);
    return copyWith(currentHp: newHp);
  }

  /// 治療
  Enemy heal(int amount) {
    int newHp = (currentHp + amount).clamp(0, maxHp);
    return copyWith(currentHp: newHp);
  }

  /// 添加狀態效果
  Enemy addStatusEffect(String effect) {
    if (statusEffects.contains(effect)) return this;
    return copyWith(statusEffects: [...statusEffects, effect]);
  }

  /// 移除狀態效果
  Enemy removeStatusEffect(String effect) {
    return copyWith(
      statusEffects: statusEffects.where((e) => e != effect).toList(),
    );
  }
}

/// 從EnemyData創建Enemy實例的工廠方法
extension EnemyDataExtension on EnemyData {
  Enemy createEnemyInstance({int? overrideLevel}) {
    int actualLevel = overrideLevel ?? 1;

    return Enemy(
      id: id,
      name: name,
      type: type,
      aiBehavior: aiBehavior,
      maxHp: baseHp,
      currentHp: baseHp,
      attack: baseAttack,
      defense: baseDefense,
      speed: baseSpeed,
      iconPath: iconPath,
      description: description,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      skillIds: skillIds,
      aggressionLevel: aggressionLevel,
      selfPreservation: selfPreservation,
      expReward: baseExpReward,
      goldReward: baseGoldReward,
      lootTable: lootTable,
      level: actualLevel,
      isBoss: type == EnemyType.boss,
    ).scaleByLevel(actualLevel);
  }
}
