// // lib/models/battle/battle_reward.dart
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// import '../item/equipment.dart';
// import '../item/item.dart';
//
// part 'battle_reward.freezed.dart';
//
// /// 獎勵物品（統一包裝）
// @freezed
// abstract class RewardItem with _$RewardItem {
//   const factory RewardItem.item({required Item item, required int quantity}) =
//       _RewardItemItem;
//
//   const factory RewardItem.equipment({
//     required Equipment equipment,
//     @Default(1) int quantity,
//   }) = _RewardItemEquipment;
// }
//
// /// 戰鬥獎勵結果
// @freezed
// abstract class BattleRewards with _$BattleRewards {
//   const factory BattleRewards({
//     required int baseExp,
//     required int bonusExp,
//     required int baseGold,
//     required int bonusGold,
//     required List<RewardItem> items, // 物品和裝備獎勵
//     required List<String> unlockedSkills,
//     @Default(1.0) double expMultiplier,
//     @Default(1.0) double goldMultiplier,
//     @Default('') String battleSummary,
//   }) = _BattleRewards;
// }
//
// /// 戰鬥結算統計
// @freezed
// abstract class BattleResultSummary with _$BattleResultSummary {
//   const factory BattleResultSummary({
//     required int turnCount,
//     required int totalDamageDealt,
//     required int totalDamageReceived,
//     required int totalHealingDone,
//     required List<String> skillsUsed,
//     required Map<String, int> statusEffectsApplied,
//     required int perfectTurns, // 沒有受到傷害的回合數
//     required bool flawlessVictory, // 完美勝利（沒有受傷）
//   }) = _BattleResultSummary;
// }
//
// /// 戰利品類型
// enum LootType { item, equipment }
//
// /// 戰利品模板
// @freezed
// abstract class LootTemplate with _$LootTemplate {
//   const factory LootTemplate({
//     required String id,
//     required String name,
//     required LootType type,
//     required Rarity rarity,
//     required int minQuantity,
//     required int maxQuantity,
//     required double dropWeight,
//     @Default('') String description,
//     @Default('') String iconPath,
//     @Default([]) List<String> tags,
//   }) = _LootTemplate;
// }
//
// /// 戰利品組合（套裝掉落）
// @freezed
// abstract class LootGroup with _$LootGroup {
//   const factory LootGroup({
//     required String id,
//     required String name,
//     required List<String> itemIds,
//     required double dropChance,
//     @Default(false) bool guaranteedDrop,
//   }) = _LootGroup;
// }
//
// /// 戰敗預設
// BattleRewards defaultBattleRewards() {
//   return const BattleRewards(
//     baseExp: 0,
//     bonusExp: 0,
//     baseGold: 0,
//     bonusGold: 0,
//     items: [],
//     unlockedSkills: [],
//     battleSummary: '戰鬥失敗，無獎勵',
//   );
// }
