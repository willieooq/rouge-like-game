// lib/services/enemy_service.dart
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../models/enemy/enemy.dart';

/// 敵人數據服務 - 管理敵人數據的加載和創建
class EnemyService {
  static EnemyService? _instance;

  static EnemyService get instance => _instance ??= EnemyService._();

  EnemyService._();

  List<EnemyData>? _enemyDataList;
  Map<String, dynamic>? _enemySkillsData;
  final Random _random = Random();

  /// 初始化敵人數據
  Future<void> initialize() async {
    if (_enemyDataList != null) return;

    try {
      // 加載敵人數據
      final String enemyDataString = await rootBundle.loadString(
        'assets/data/enemies.json',
      );
      final Map<String, dynamic> enemyJson = json.decode(enemyDataString);

      _enemyDataList = (enemyJson['enemies'] as List)
          .map((data) => EnemyData.fromJson(data))
          .toList();

      _enemySkillsData = Map<String, dynamic>.from(enemyJson);

      print('EnemyService: 已加載 ${_enemyDataList!.length} 個敵人數據');
    } catch (e) {
      print('EnemyService 初始化失敗: $e');
      rethrow;
    }
  }

  /// 獲取所有敵人數據
  List<EnemyData> getAllEnemyData() {
    if (_enemyDataList == null) {
      throw Exception('EnemyService 未初始化，請先調用 initialize()');
    }
    return List.unmodifiable(_enemyDataList!);
  }

  /// 根據ID獲取敵人數據
  EnemyData? getEnemyDataById(String id) {
    return _enemyDataList?.firstWhere(
      (enemy) => enemy.id == id,
      orElse: () => throw Exception('找不到ID為 $id 的敵人數據'),
    );
  }

  /// 根據類型獲取敵人數據列表
  List<EnemyData> getEnemiesByType(EnemyType type) {
    if (_enemyDataList == null) return [];
    return _enemyDataList!.where((enemy) => enemy.type == type).toList();
  }

  /// 創建敵人實例
  Enemy createEnemy({
    required String enemyId,
    int? level,
    Map<String, dynamic>? overrides,
  }) {
    final enemyData = getEnemyDataById(enemyId);
    if (enemyData == null) {
      throw Exception('無法創建敵人: 找不到ID為 $enemyId 的敵人數據');
    }

    Enemy enemy = enemyData.createEnemyInstance(overrideLevel: level);

    // 應用覆蓋參數
    if (overrides != null) {
      enemy = _applyOverrides(enemy, overrides);
    }

    return enemy;
  }

  /// 批量創建敵人（用於生成敵人隊伍）
  List<Enemy> createEnemyParty({
    required List<String> enemyIds,
    int? level,
    Map<String, Map<String, dynamic>>? individualOverrides,
  }) {
    return enemyIds.map((id) {
      final overrides = individualOverrides?[id];
      return createEnemy(enemyId: id, level: level, overrides: overrides);
    }).toList();
  }

  /// 隨機生成敵人遭遇
  List<Enemy> generateRandomEncounter({
    required int playerLevel,
    required int maxEnemies,
    double eliteChance = 0.2,
    double bossChance = 0.05,
  }) {
    final List<Enemy> encounter = [];
    final int enemyCount = _random.nextInt(maxEnemies) + 1;

    for (int i = 0; i < enemyCount; i++) {
      EnemyType selectedType;

      // 決定敵人類型
      final double typeRoll = _random.nextDouble();
      if (typeRoll < bossChance && encounter.isEmpty) {
        selectedType = EnemyType.boss;
      } else if (typeRoll < eliteChance) {
        selectedType = EnemyType.elite;
      } else {
        selectedType = EnemyType.normal;
      }

      // 如果已經有Boss，就不再生成其他敵人
      if (encounter.any((e) => e.type == EnemyType.boss)) {
        break;
      }

      final enemiesOfType = getEnemiesByType(selectedType);
      if (enemiesOfType.isNotEmpty) {
        final randomEnemyData =
            enemiesOfType[_random.nextInt(enemiesOfType.length)];
        final levelVariance = _random.nextInt(3) - 1; // -1 到 +1 的等級變化
        final adjustedLevel = (playerLevel + levelVariance).clamp(1, 99);

        final enemy = randomEnemyData.createEnemyInstance(
          overrideLevel: adjustedLevel,
        );

        encounter.add(enemy);
      }
    }

    return encounter;
  }

  /// 根據區域生成特定敵人遭遇
  List<Enemy> generateAreaEncounter({
    required String areaId,
    required int playerLevel,
    required int maxEnemies,
  }) {
    // 這裡可以根據不同區域定義不同的敵人池
    final Map<String, List<String>> areaEnemyPools = {
      'forest': ['goblin_warrior', 'forest_spider', 'orc_berserker'],
      'dungeon': ['skeleton_archer', 'shadow_assassin', 'lich_king'],
      'volcanic': ['ice_elemental', 'ancient_dragon', 'demon_lord'],
    };

    final enemyPool =
        areaEnemyPools[areaId] ?? _enemyDataList!.map((e) => e.id).toList();

    final List<Enemy> encounter = [];
    final int enemyCount = _random.nextInt(maxEnemies) + 1;

    for (int i = 0; i < enemyCount; i++) {
      final randomEnemyId = enemyPool[_random.nextInt(enemyPool.length)];
      final levelVariance = _random.nextInt(3) - 1;
      final adjustedLevel = (playerLevel + levelVariance).clamp(1, 99);

      try {
        final enemy = createEnemy(enemyId: randomEnemyId, level: adjustedLevel);
        encounter.add(enemy);

        // 如果生成了Boss，停止生成更多敵人
        if (enemy.type == EnemyType.boss) break;
      } catch (e) {
        print('生成敵人失敗: $e');
        continue;
      }
    }

    return encounter;
  }

  /// 根據難度生成敵人遭遇
  List<Enemy> generateDifficultyBasedEncounter({
    required int playerLevel,
    required String difficulty, // 'easy', 'normal', 'hard', 'nightmare'
  }) {
    final Map<String, Map<String, dynamic>> difficultySettings = {
      'easy': {
        'maxEnemies': 2,
        'levelModifier': -1,
        'eliteChance': 0.05,
        'bossChance': 0.0,
      },
      'normal': {
        'maxEnemies': 3,
        'levelModifier': 0,
        'eliteChance': 0.15,
        'bossChance': 0.02,
      },
      'hard': {
        'maxEnemies': 4,
        'levelModifier': 1,
        'eliteChance': 0.25,
        'bossChance': 0.08,
      },
      'nightmare': {
        'maxEnemies': 5,
        'levelModifier': 2,
        'eliteChance': 0.4,
        'bossChance': 0.15,
      },
    };

    final settings =
        difficultySettings[difficulty] ?? difficultySettings['normal']!;

    return generateRandomEncounter(
      playerLevel: playerLevel + settings['levelModifier'] as int,
      maxEnemies: settings['maxEnemies'] as int,
      eliteChance: settings['eliteChance'] as double,
      bossChance: settings['bossChance'] as double,
    );
  }

  /// 獲取敵人技能數據
  Map<String, dynamic>? getEnemySkillData(String skillId) {
    if (_enemySkillsData == null) return null;

    final skills = _enemySkillsData!['enemySkills'] as List?;
    if (skills == null) return null;

    return skills.firstWhere(
      (skill) => skill['id'] == skillId,
      orElse: () => null,
    );
  }

  /// 獲取所有敵人技能數據
  List<Map<String, dynamic>> getAllEnemySkills() {
    if (_enemySkillsData == null) return [];
    return List<Map<String, dynamic>>.from(
      _enemySkillsData!['enemySkills'] ?? [],
    );
  }

  /// 驗證敵人數據完整性
  bool validateEnemyData() {
    if (_enemyDataList == null) return false;

    try {
      for (final enemyData in _enemyDataList!) {
        // 檢查技能ID是否有效
        for (final skillId in enemyData.skillIds) {
          final skillData = getEnemySkillData(skillId);
          if (skillData == null) {
            print('警告: 敵人 ${enemyData.id} 的技能 $skillId 不存在');
            return false;
          }
        }

        // 檢查基礎屬性是否合理
        if (enemyData.baseHp <= 0 ||
            enemyData.baseAttack < 0 ||
            enemyData.baseDefense < 0 ||
            enemyData.baseSpeed < 0) {
          print('警告: 敵人 ${enemyData.id} 的基礎屬性不合理');
          return false;
        }
      }

      print('EnemyService: 敵人數據驗證通過');
      return true;
    } catch (e) {
      print('EnemyService: 數據驗證失敗 - $e');
      return false;
    }
  }

  /// 應用覆蓋參數
  Enemy _applyOverrides(Enemy enemy, Map<String, dynamic> overrides) {
    return enemy.copyWith(
      maxHp: overrides['maxHp'] ?? enemy.maxHp,
      currentHp: overrides['currentHp'] ?? enemy.currentHp,
      attack: overrides['attack'] ?? enemy.attack,
      defense: overrides['defense'] ?? enemy.defense,
      speed: overrides['speed'] ?? enemy.speed,
      level: overrides['level'] ?? enemy.level,
      aggressionLevel: overrides['aggressionLevel'] ?? enemy.aggressionLevel,
      selfPreservation: overrides['selfPreservation'] ?? enemy.selfPreservation,
    );
  }

  /// 重置服務（主要用於測試）
  void reset() {
    _enemyDataList = null;
    _enemySkillsData = null;
  }

  /// 獲取統計信息
  Map<String, int> getStatistics() {
    if (_enemyDataList == null) {
      return {'total': 0, 'normal': 0, 'elite': 0, 'boss': 0};
    }

    return {
      'total': _enemyDataList!.length,
      'normal': _enemyDataList!.where((e) => e.type == EnemyType.normal).length,
      'elite': _enemyDataList!.where((e) => e.type == EnemyType.elite).length,
      'boss': _enemyDataList!.where((e) => e.type == EnemyType.boss).length,
    };
  }
}

/// 敵人生成器 - 提供更高級的敵人生成功能
class EnemyGenerator {
  final EnemyService _enemyService = EnemyService.instance;

  /// 生成主線劇情敵人遭遇
  List<Enemy> generateStoryEncounter({
    required String storyId,
    required int playerLevel,
  }) {
    // 根據劇情ID生成特定的敵人遭遇
    final Map<String, List<String>> storyEncounters = {
      'intro_battle': ['goblin_warrior'],
      'forest_boss': ['orc_berserker', 'goblin_warrior', 'forest_spider'],
      'dungeon_final': ['lich_king'],
      'volcano_climax': ['ancient_dragon'],
      'final_battle': ['demon_lord'],
    };

    final enemyIds = storyEncounters[storyId] ?? ['goblin_warrior'];

    return _enemyService.createEnemyParty(
      enemyIds: enemyIds,
      level: playerLevel,
    );
  }

  /// 生成訓練敵人（降低難度）
  List<Enemy> generateTrainingEncounter({
    required int playerLevel,
    required int maxEnemies,
  }) {
    final encounter = _enemyService.generateRandomEncounter(
      playerLevel: playerLevel - 2,
      maxEnemies: maxEnemies,
      eliteChance: 0.0,
      bossChance: 0.0,
    );

    // 降低敵人屬性
    return encounter.map((enemy) {
      return enemy.copyWith(
        maxHp: (enemy.maxHp * 0.7).round(),
        currentHp: (enemy.maxHp * 0.7).round(),
        attack: (enemy.attack * 0.8).round(),
      );
    }).toList();
  }

  /// 生成挑戰敵人（提高難度）
  List<Enemy> generateChallengeEncounter({
    required int playerLevel,
    required int maxEnemies,
  }) {
    final encounter = _enemyService.generateRandomEncounter(
      playerLevel: playerLevel + 2,
      maxEnemies: maxEnemies,
      eliteChance: 0.4,
      bossChance: 0.2,
    );

    // 提升敵人屬性
    return encounter.map((enemy) {
      return enemy.copyWith(
        maxHp: (enemy.maxHp * 1.3).round(),
        currentHp: (enemy.maxHp * 1.3).round(),
        attack: (enemy.attack * 1.2).round(),
        defense: (enemy.defense * 1.1).round(),
      );
    }).toList();
  }
}
