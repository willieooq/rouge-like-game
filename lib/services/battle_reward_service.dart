import 'dart:math';

import '../models/battle/battle_reward.dart';
import '../models/battle/battle_state.dart';
import '../models/enemy/enemy.dart';
import '../models/item/equipment.dart';
import '../models/item/item.dart';
import '../shared/beans/weighted_loot_entry.dart';

/// 戰鬥結算服務
class BattleRewardService {
  /// 計算戰鬥獎勵
  static BattleRewards calculateRewards({
    required Enemy enemy,
    required BattleResultSummary summary,
    required BattleResult result,
  }) {
    if (result != BattleResult.victory) {
      return const BattleRewards(
        baseExp: 0,
        bonusExp: 0,
        baseGold: 0,
        bonusGold: 0,
        items: [],
        unlockedSkills: [],
        battleSummary: '戰鬥失敗，無獎勵',
      );
    }

    // 基礎獎勵
    int baseExp = enemy.expReward;
    int baseGold = enemy.goldReward;

    // 計算獎勵倍率
    double expMultiplier = 1.0;
    double goldMultiplier = 1.0;

    // 完美勝利獎勵
    if (summary.flawlessVictory) {
      expMultiplier += 0.5;
      goldMultiplier += 0.3;
    }

    // 快速勝利獎勵（回合數少）
    if (summary.turnCount <= 3) {
      expMultiplier += 0.2;
      goldMultiplier += 0.2;
    }

    // 精英和Boss額外獎勵
    if (enemy.type == EnemyType.elite) {
      expMultiplier += 0.3;
      goldMultiplier += 0.5;
    } else if (enemy.type == EnemyType.boss) {
      expMultiplier += 0.8;
      goldMultiplier += 1.0;
    }

    // 計算最終獎勵
    int finalExp = (baseExp * expMultiplier).round();
    int finalGold = (baseGold * goldMultiplier).round();
    int bonusExp = finalExp - baseExp;
    int bonusGold = finalGold - baseGold;

    // 生成戰利品
    final items = _generateLootItems(enemy, summary);

    // 技能解鎖（基於戰鬥表現）
    final unlockedSkills = _checkSkillUnlocks(summary);

    // 生成戰鬥總結
    final battleSummary = _generateBattleSummary(summary, enemy);

    return BattleRewards(
      baseExp: baseExp,
      bonusExp: bonusExp,
      baseGold: baseGold,
      bonusGold: bonusGold,
      items: items,
      unlockedSkills: unlockedSkills,
      expMultiplier: expMultiplier,
      goldMultiplier: goldMultiplier,
      battleSummary: battleSummary,
    );
  }

  /// 生成戰利品
  static List<RewardItem> _generateLootItems(
    Enemy enemy,
    BattleResultSummary summary,
  ) {
    final items = <RewardItem>[];
    final random = Random();

    // 基礎掉落機率修正
    double dropChanceModifier = 1.0;
    if (summary.flawlessVictory) dropChanceModifier += 0.3;
    if (summary.turnCount <= 3) dropChanceModifier += 0.2;

    // 先檢查組合掉落（套裝）
    final groupDrops = _rollLootGroups(enemy, dropChanceModifier, random);
    items.addAll(groupDrops);

    // 然後處理單獨物品掉落
    final individualDrops = _rollIndividualLoot(
      enemy,
      dropChanceModifier,
      random,
      excludeGroupItems: groupDrops
          .map(
            (e) => e.when(
              item: (item, quantity) => item.id,
              equipment: (equipment, quantity) => equipment.id,
            ),
          )
          .toSet(),
    );
    items.addAll(individualDrops);

    return items;
  }

  /// 檢查組合掉落
  static List<RewardItem> _rollLootGroups(
    Enemy enemy,
    double modifier,
    Random random,
  ) {
    final items = <RewardItem>[];
    final lootGroups = _getLootGroups(enemy);

    for (final group in lootGroups) {
      double finalChance = group.dropChance * modifier;

      if (group.guaranteedDrop || random.nextDouble() < finalChance) {
        // 掉落整個組合
        for (final itemId in group.itemIds) {
          final template = _getLootTemplate(itemId);
          if (template != null) {
            items.add(_createItemFromTemplate(template, random));
          }
        }
        print('組合掉落觸發: ${group.name}');
      }
    }

    return items;
  }

  /// 檢查單獨物品掉落
  static List<RewardItem> _rollIndividualLoot(
    Enemy enemy,
    double modifier,
    Random random, {
    Set<String> excludeGroupItems = const {},
  }) {
    final items = <RewardItem>[];
    final availableTemplates = _getEnemyLootTemplates(
      enemy,
    ).where((t) => !excludeGroupItems.contains(t.id)).toList();

    // 權重抽獎系統
    final weightedPool = _createWeightedPool(availableTemplates, modifier);
    final dropCount = _calculateDropCount(enemy, modifier, random);

    for (int i = 0; i < dropCount; i++) {
      final selectedTemplate = _selectFromWeightedPool(weightedPool, random);
      if (selectedTemplate != null) {
        items.add(_createItemFromTemplate(selectedTemplate, random));
      }
    }

    return items;
  }

  /// 創建權重池
  static List<WeightedLootEntry> _createWeightedPool(
    List<LootTemplate> templates,
    double modifier,
  ) {
    return templates.map((template) {
      double finalWeight = template.dropWeight * modifier;

      // 稀有度影響權重
      switch (template.rarity) {
        case Rarity.common:
          finalWeight *= 1.0;
          break;
        case Rarity.uncommon:
          finalWeight *= 0.6;
          break;
        case Rarity.rare:
          finalWeight *= 0.3;
          break;
        case Rarity.epic:
          finalWeight *= 0.1;
          break;
        case Rarity.legendary:
          finalWeight *= 0.02;
          break;
      }

      return WeightedLootEntry(template: template, weight: finalWeight);
    }).toList();
  }

  /// 從權重池中選擇
  static LootTemplate? _selectFromWeightedPool(
    List<WeightedLootEntry> pool,
    Random random,
  ) {
    final totalWeight = pool.fold(0.0, (sum, entry) => sum + entry.weight);
    if (totalWeight <= 0) return null;

    double randomValue = random.nextDouble() * totalWeight;
    double currentWeight = 0.0;

    for (final entry in pool) {
      currentWeight += entry.weight;
      if (randomValue <= currentWeight) {
        return entry.template;
      }
    }

    return pool.isNotEmpty ? pool.last.template : null;
  }

  /// 計算掉落數量
  static int _calculateDropCount(Enemy enemy, double modifier, Random random) {
    int baseCount = 1;

    // 根據敵人類型調整基礎掉落數
    switch (enemy.type) {
      case EnemyType.normal:
        baseCount = 1;
        break;
      case EnemyType.elite:
        baseCount = 2;
        break;
      case EnemyType.boss:
        baseCount = 3;
        break;
    }

    // 額外掉落機會
    double extraDropChance = (modifier - 1.0) * 0.5;
    while (extraDropChance > 0) {
      if (random.nextDouble() < extraDropChance) {
        baseCount++;
      }
      extraDropChance -= 1.0;
    }

    return baseCount.clamp(0, 10); // 最多10個物品
  }

  /// 從模板創建物品
  static RewardItem _createItemFromTemplate(
    LootTemplate template,
    Random random,
  ) {
    final quantity =
        template.minQuantity +
        random.nextInt(template.maxQuantity - template.minQuantity + 1);

    if (template.type == LootType.item) {
      final item = _getItemById(template.id);
      if (item != null) {
        return RewardItem.item(item: item, quantity: quantity);
      }
    } else if (template.type == LootType.equipment) {
      final equipment = _getEquipmentById(template.id);
      if (equipment != null) {
        return RewardItem.equipment(equipment: equipment, quantity: quantity);
      }
    }

    // 如果找不到對應的物品，創建一個默認項目
    final fallbackItem = Item(
      id: template.id,
      name: template.name,
      rare: template.rarity,
      description: template.description,
      type: ItemType.misc,
      price: 10,
    );
    return RewardItem.item(item: fallbackItem, quantity: quantity);
  }

  /// 獲取敵人的組合掉落
  static List<LootGroup> _getLootGroups(Enemy enemy) {
    switch (enemy.id) {
      case 'orc_berserker':
        return [
          const LootGroup(
            id: 'berserker_set',
            name: '狂戰士套裝',
            itemIds: ['berserker_helm', 'orc_axe'],
            dropChance: 0.15,
          ),
        ];
      case 'ancient_dragon':
        return [
          const LootGroup(
            id: 'dragon_treasure',
            name: '龍之寶藏',
            itemIds: ['dragon_scale', 'ancient_treasure', 'dragon_heart'],
            dropChance: 0.8,
            guaranteedDrop: true,
          ),
        ];
      default:
        return [];
    }
  }

  /// 獲取戰利品模板
  static LootTemplate? _getLootTemplate(String id) {
    return _lootTemplates[id];
  }

  /// 獲取敵人的戰利品模板列表
  static List<LootTemplate> _getEnemyLootTemplates(Enemy enemy) {
    return enemy.lootTable
        .map((id) => _getLootTemplate(id))
        .whereType<LootTemplate>()
        .toList();
  }

  /// 獲取物品數據
  static Item? _getItemById(String id) {
    return _itemDatabase[id];
  }

  /// 獲取裝備數據
  static Equipment? _getEquipmentById(String id) {
    return _equipmentDatabase[id];
  }

  /// 檢查技能解鎖
  static List<String> _checkSkillUnlocks(BattleResultSummary summary) {
    final unlockedSkills = <String>[];

    // 基於戰鬥表現解鎖技能
    if (summary.flawlessVictory) {
      unlockedSkills.add('perfect_guard'); // 完美防禦技能
    }

    if (summary.totalDamageDealt > 500) {
      unlockedSkills.add('berserker_rage'); // 狂戰士技能
    }

    if (summary.statusEffectsApplied.length > 3) {
      unlockedSkills.add('status_master'); // 狀態大師技能
    }

    return unlockedSkills;
  }

  /// 生成戰鬥總結
  static String _generateBattleSummary(
    BattleResultSummary summary,
    Enemy enemy,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('擊敗了 ${enemy.name}！');
    buffer.writeln('回合數: ${summary.turnCount}');
    buffer.writeln('造成傷害: ${summary.totalDamageDealt}');
    buffer.writeln('受到傷害: ${summary.totalDamageReceived}');

    if (summary.flawlessVictory) {
      buffer.writeln('完美勝利！');
    }

    return buffer.toString();
  }

  /// 戰利品模板數據庫
  static final Map<String, LootTemplate> _lootTemplates = {
    // 一般物品
    'small_potion': const LootTemplate(
      id: 'small_potion',
      name: '小型治療藥水',
      type: LootType.item,
      rarity: Rarity.common,
      minQuantity: 1,
      maxQuantity: 3,
      dropWeight: 100.0,
    ),
    'spider_silk': const LootTemplate(
      id: 'spider_silk',
      name: '蜘蛛絲',
      type: LootType.item,
      rarity: Rarity.common,
      minQuantity: 2,
      maxQuantity: 5,
      dropWeight: 80.0,
    ),
    'strength_potion': const LootTemplate(
      id: 'strength_potion',
      name: '力量藥水',
      type: LootType.item,
      rarity: Rarity.uncommon,
      minQuantity: 1,
      maxQuantity: 2,
      dropWeight: 40.0,
    ),
    'poison_vial': const LootTemplate(
      id: 'poison_vial',
      name: '毒藥瓶',
      type: LootType.item,
      rarity: Rarity.uncommon,
      minQuantity: 1,
      maxQuantity: 3,
      dropWeight: 35.0,
    ),
    'ancient_treasure': const LootTemplate(
      id: 'ancient_treasure',
      name: '遠古寶物',
      type: LootType.item,
      rarity: Rarity.epic,
      minQuantity: 1,
      maxQuantity: 1,
      dropWeight: 3.0,
      tags: ['treasure', 'dragon_treasure'],
    ),
    'dragon_scale': const LootTemplate(
      id: 'dragon_scale',
      name: '龍鱗',
      type: LootType.item,
      rarity: Rarity.epic,
      minQuantity: 3,
      maxQuantity: 8,
      dropWeight: 5.0,
      tags: ['material', 'dragon_treasure'],
    ),
    'dragon_heart': const LootTemplate(
      id: 'dragon_heart',
      name: '龍之心',
      type: LootType.item,
      rarity: Rarity.legendary,
      minQuantity: 1,
      maxQuantity: 1,
      dropWeight: 1.0,
      tags: ['legendary', 'dragon_treasure'],
    ),

    // 裝備
    'berserker_helm': const LootTemplate(
      id: 'berserker_helm',
      name: '狂戰士頭盔',
      type: LootType.equipment,
      rarity: Rarity.rare,
      minQuantity: 1,
      maxQuantity: 1,
      dropWeight: 15.0,
      tags: ['armor', 'berserker_set'],
    ),
    'orc_axe': const LootTemplate(
      id: 'orc_axe',
      name: '獸人戰斧',
      type: LootType.equipment,
      rarity: Rarity.rare,
      minQuantity: 1,
      maxQuantity: 1,
      dropWeight: 12.0,
      tags: ['weapon', 'berserker_set'],
    ),
    'rusty_sword': const LootTemplate(
      id: 'rusty_sword',
      name: '生鏽的劍',
      type: LootType.equipment,
      rarity: Rarity.common,
      minQuantity: 1,
      maxQuantity: 1,
      dropWeight: 60.0,
      tags: ['weapon'],
    ),
    'bone_arrow': const LootTemplate(
      id: 'bone_arrow',
      name: '骨箭',
      type: LootType.equipment,
      rarity: Rarity.common,
      minQuantity: 5,
      maxQuantity: 15,
      dropWeight: 50.0,
      tags: ['weapon', 'arrow'],
    ),
    'ancient_bow': const LootTemplate(
      id: 'ancient_bow',
      name: '遠古之弓',
      type: LootType.equipment,
      rarity: Rarity.rare,
      minQuantity: 1,
      maxQuantity: 1,
      dropWeight: 8.0,
      tags: ['weapon', 'bow'],
    ),
  };

  /// 物品數據庫
  static final Map<String, Item> _itemDatabase = {
    'small_potion': const Item(
      id: 'small_potion',
      name: '小型治療藥水',
      rare: Rarity.common,
      description: '回復50點生命值',
      type: ItemType.consumable,
      price: 25,
      iconPath: 'assets/items/small_potion.png',
    ),
    'spider_silk': const Item(
      id: 'spider_silk',
      name: '蜘蛛絲',
      rare: Rarity.common,
      description: '製作裝備的優質材料',
      type: ItemType.material,
      price: 15,
      iconPath: 'assets/items/spider_silk.png',
    ),
    'strength_potion': const Item(
      id: 'strength_potion',
      name: '力量藥水',
      rare: Rarity.uncommon,
      description: '暫時增加30點攻擊力，持續3回合',
      type: ItemType.consumable,
      price: 100,
      iconPath: 'assets/items/strength_potion.png',
    ),
    'poison_vial': const Item(
      id: 'poison_vial',
      name: '毒藥瓶',
      rare: Rarity.uncommon,
      description: '可用於製作毒藥武器或直接使用',
      type: ItemType.material,
      price: 80,
      iconPath: 'assets/items/poison_vial.png',
    ),
    'ancient_treasure': const Item(
      id: 'ancient_treasure',
      name: '遠古寶物',
      rare: Rarity.epic,
      description: '價值連城的古代文物，收藏家會高價收購',
      type: ItemType.treasure,
      price: 5000,
      iconPath: 'assets/items/ancient_treasure.png',
    ),
    'dragon_scale': const Item(
      id: 'dragon_scale',
      name: '龍鱗',
      rare: Rarity.epic,
      description: '製作頂級裝備的稀有材料',
      type: ItemType.material,
      price: 2000,
      iconPath: 'assets/items/dragon_scale.png',
    ),
    'dragon_heart': const Item(
      id: 'dragon_heart',
      name: '龍之心',
      rare: Rarity.legendary,
      description: '蘊含純粹龍族力量的神秘寶石',
      type: ItemType.treasure,
      price: 50000,
      iconPath: 'assets/items/dragon_heart.png',
    ),
  };

  /// 裝備數據庫
  static final Map<String, Equipment> _equipmentDatabase = {
    'berserker_helm': const Equipment(
      id: 'berserker_helm',
      name: '狂戰士頭盔',
      rare: Rarity.rare,
      description: '狂戰士專用的戰鬥頭盔',
      type: EquipmentType.helmet,
      atk: 25,
      hp: -10,
      // 狂戰士裝備犧牲血量
      effect: [],
      // 之後實現特殊效果
      price: 1200,
      iconPath: 'assets/equipment/berserker_helm.png',
      level: 3,
      durability: 100,
      maxDurability: 100,
    ),
    'orc_axe': const Equipment(
      id: 'orc_axe',
      name: '獸人戰斧',
      rare: Rarity.rare,
      description: '獸人工匠打造的強力雙手武器',
      type: EquipmentType.weapon,
      atk: 45,
      hp: 0,
      effect: [],
      // 之後實現特殊效果：攻擊時有機率造成流血
      price: 1800,
      iconPath: 'assets/equipment/orc_axe.png',
      level: 4,
      durability: 80,
      maxDurability: 80,
    ),
    'rusty_sword': const Equipment(
      id: 'rusty_sword',
      name: '生鏽的劍',
      rare: Rarity.common,
      description: '一把破舊的鐵劍，但仍能使用',
      type: EquipmentType.weapon,
      atk: 12,
      hp: 0,
      effect: [],
      price: 50,
      iconPath: 'assets/equipment/rusty_sword.png',
      level: 1,
      durability: 20,
      maxDurability: 20,
    ),
    'bone_arrow': const Equipment(
      id: 'bone_arrow',
      name: '骨箭',
      rare: Rarity.common,
      description: '用怪物骨頭製作的箭矢',
      type: EquipmentType.weapon,
      atk: 15,
      hp: 0,
      effect: [],
      price: 30,
      iconPath: 'assets/equipment/bone_arrow.png',
      level: 2,
    ),
    'ancient_bow': const Equipment(
      id: 'ancient_bow',
      name: '遠古之弓',
      rare: Rarity.rare,
      description: '古代精靈製作的精緻長弓',
      type: EquipmentType.weapon,
      atk: 35,
      hp: 5,
      effect: [],
      // 之後實現：提高命中率和暴擊率
      price: 1500,
      iconPath: 'assets/equipment/ancient_bow.png',
      level: 5,
      durability: 120,
      maxDurability: 120,
    ),
  };
}
