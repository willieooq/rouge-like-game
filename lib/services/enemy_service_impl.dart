// lib/services/enemy_service_impl.dart
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../core/interfaces/i_enemy_service.dart';
import '../models/battle/battle_state.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/enemy/enemy_action.dart';
import '../shared/beans/battle/battle_action_result.dart';
import '../shared/beans/enemy/enemy_action_queue_result.dart';
import '../shared/beans/enemy/enemy_encounter_result.dart';

/// 敵人服務實現
class EnemyServiceImpl implements IEnemyService {
  List<EnemyData>? _enemyDataList;
  Map<String, dynamic>? _enemySkillsData;
  final Random _random = Random();

  // ==========================================
  // 數據管理功能
  // ==========================================

  @override
  Future<void> initialize() async {
    if (_enemyDataList != null) return;

    try {
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
      throw Exception('EnemyService 初始化失敗: $e');
    }
  }

  @override
  List<EnemyData> getAllEnemyData() {
    _ensureInitialized();
    return List.unmodifiable(_enemyDataList!);
  }

  @override
  EnemyData? getEnemyDataById(String id) {
    _ensureInitialized();
    try {
      return _enemyDataList!.firstWhere((enemy) => enemy.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  List<EnemyData> getEnemiesByType(EnemyType type) {
    _ensureInitialized();
    return _enemyDataList!.where((enemy) => enemy.type == type).toList();
  }

  @override
  Enemy createEnemy({required String enemyId, int? level}) {
    final enemyData = getEnemyDataById(enemyId);
    if (enemyData == null) {
      throw Exception('無法創建敵人: 找不到ID為 $enemyId 的敵人數據');
    }
    return enemyData.createEnemyInstance(overrideLevel: level);
  }

  @override
  bool validateEnemyData() {
    if (_enemyDataList == null) return false;

    try {
      for (final enemyData in _enemyDataList!) {
        if (!_validateSingleEnemy(enemyData)) return false;
      }
      return true;
    } catch (e) {
      print('EnemyService: 數據驗證失敗 - $e');
      return false;
    }
  }

  // ==========================================
  // 戰鬥功能（BattleProvider 需要的公共方法）
  // ==========================================

  @override
  EnemyActionQueueResult generateActionQueue({
    required Enemy enemy,
    required List<Character> playerParty,
    required int turnNumber,
  }) {
    try {
      List<EnemyAction> actions;
      String strategy;

      switch (enemy.aiBehavior) {
        case AIBehavior.aggressive:
          actions = _generateAggressiveActions(enemy, playerParty, turnNumber);
          strategy = '攻擊型';
          break;
        case AIBehavior.defensive:
          actions = _generateDefensiveActions(enemy, playerParty, turnNumber);
          strategy = '防禦型';
          break;
        case AIBehavior.balanced:
          actions = _generateBalancedActions(enemy, playerParty, turnNumber);
          strategy = '平衡型';
          break;
        case AIBehavior.support:
          actions = _generateSupportActions(enemy, playerParty, turnNumber);
          strategy = '輔助型';
          break;
      }

      final enhancedActions = adjustActionsByEnemyType(actions, enemy);

      return EnemyActionQueueResult(
        actions: enhancedActions,
        success: true,
        message: '成功生成 ${enhancedActions.length} 個行動',
        aiStrategy: strategy,
      );
    } catch (e) {
      return EnemyActionQueueResult.empty.copyWith(message: 'AI決策失敗: $e');
    }
  }

  @override
  List<EnemyActionResult> executeActionQueue(
    List<EnemyAction> actionQueue,
    EnemyAction? nullifiedAction,
    Enemy enemy,
  ) {
    final results = <EnemyActionResult>[];

    for (final action in actionQueue) {
      if (nullifiedAction?.id == action.id) {
        results.add(action.createResult(wasExecuted: false, message: '行動被無效化'));
        continue;
      }

      final result = _executeAction(action, enemy);
      results.add(result);
    }

    return results;
  }

  @override
  List<EnemyAction> adjustActionsByEnemyType(
    List<EnemyAction> actions,
    Enemy enemy,
  ) {
    switch (enemy.type) {
      case EnemyType.elite:
        return actions.map((action) => _enhanceAction(action, 1.2)).toList();
      case EnemyType.boss:
        final enhanced = actions
            .map((action) => _enhanceAction(action, 1.5))
            .toList();
        if (_random.nextDouble() < 0.3) {
          enhanced.add(_createSpecialBossAction(enemy));
        }
        return enhanced;
      case EnemyType.normal:
        return actions;
    }
  }

  // ==========================================
  // 整合戰鬥功能（高層API）
  // ==========================================

  @override
  Future<BattleActionResult> processEnemyTurn({
    required Enemy enemy,
    required List<Character> playerParty,
    required int turnNumber,
    EnemyAction? nullifiedAction,
  }) async {
    try {
      // 1. AI決策階段
      final queueResult = generateActionQueue(
        enemy: enemy,
        playerParty: playerParty,
        turnNumber: turnNumber,
      );

      if (!queueResult.success) {
        return BattleActionResult.failure(
          currentState: _createTempBattleState(enemy),
          message: '行動隊列生成失敗: ${queueResult.message}',
        );
      }

      // 2. 行動執行階段
      final actionResults = executeActionQueue(
        queueResult.actions,
        nullifiedAction,
        enemy,
      );

      // 3. 統計結果
      int totalDamage = 0;
      int totalHealing = 0;
      List<String> statusEffects = [];

      for (final result in actionResults) {
        totalDamage += result.damageDealt;
        totalHealing += result.healingReceived;
        statusEffects.addAll(result.statusEffectsApplied);
      }

      return BattleActionResult.success(
        newState: _createTempBattleState(enemy),
        message: '${enemy.name} 完成回合，執行了 ${actionResults.length} 個行動',
        totalDamageDealt: totalDamage,
        totalHealingReceived: totalHealing,
        statusEffectsApplied: statusEffects,
        actionResults: actionResults,
      );
    } catch (e) {
      // 錯誤處理：至少執行一個基本攻擊
      final fallbackAction = EnemyAction(
        id: 'fallback_attack',
        name: '基礎攻擊',
        description: '基礎攻擊',
        type: EnemyActionType.attack,
        skillId: 'basic_attack',
      );

      final fallbackResult = _executeAction(fallbackAction, enemy);

      return BattleActionResult.success(
        newState: _createTempBattleState(enemy),
        message: '${enemy.name} 執行了緊急攻擊',
        totalDamageDealt: fallbackResult.damageDealt,
        totalHealingReceived: fallbackResult.healingReceived,
        statusEffectsApplied: fallbackResult.statusEffectsApplied,
        actionResults: [fallbackResult],
      );
    }
  }

  // ==========================================
  // 遭遇生成功能
  // ==========================================

  @override
  EnemyEncounterResult generateRandomEncounter({
    required int playerLevel,
    required int maxEnemies,
    double eliteChance = 0.2,
    double bossChance = 0.05,
  }) {
    try {
      final List<Enemy> encounter = [];
      final int enemyCount = _random.nextInt(maxEnemies) + 1;

      for (int i = 0; i < enemyCount; i++) {
        final enemy = _generateSingleEnemy(
          playerLevel: playerLevel,
          eliteChance: eliteChance,
          bossChance: bossChance,
          isBossEncounter: encounter.isEmpty,
        );

        if (enemy != null) {
          encounter.add(enemy);
          if (enemy.type == EnemyType.boss) break;
        }
      }

      final difficultyRating = _calculateDifficultyRating(
        encounter,
        playerLevel,
      );

      return EnemyEncounterResult(
        enemies: encounter,
        success: true,
        message: '成功生成 ${encounter.length} 個敵人的遭遇',
        difficultyRating: difficultyRating,
      );
    } catch (e) {
      return EnemyEncounterResult.empty.copyWith(message: '隨機遭遇生成失敗: $e');
    }
  }

  @override
  EnemyEncounterResult generateAreaEncounter({
    required String areaId,
    required int playerLevel,
    required int maxEnemies,
  }) {
    try {
      final enemyPool = _getAreaEnemyPool(areaId);
      if (enemyPool.isEmpty) {
        return EnemyEncounterResult.empty.copyWith(
          message: '區域 $areaId 沒有可用的敵人',
        );
      }

      final List<Enemy> encounter = [];
      final int enemyCount = _random.nextInt(maxEnemies) + 1;

      for (int i = 0; i < enemyCount; i++) {
        final randomEnemyId = enemyPool[_random.nextInt(enemyPool.length)];
        final levelVariance = _random.nextInt(3) - 1;
        final adjustedLevel = (playerLevel + levelVariance).clamp(1, 99);

        try {
          final enemy = createEnemy(
            enemyId: randomEnemyId,
            level: adjustedLevel,
          );
          encounter.add(enemy);
          if (enemy.type == EnemyType.boss) break;
        } catch (e) {
          continue;
        }
      }

      final difficultyRating = _calculateDifficultyRating(
        encounter,
        playerLevel,
      );

      return EnemyEncounterResult(
        enemies: encounter,
        success: true,
        message: '成功生成區域 $areaId 的 ${encounter.length} 個敵人遭遇',
        difficultyRating: difficultyRating,
      );
    } catch (e) {
      return EnemyEncounterResult.empty.copyWith(message: '區域遭遇生成失敗: $e');
    }
  }

  // ==========================================
  // 統計功能
  // ==========================================

  @override
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

  // ==========================================
  // 私有輔助方法
  // ==========================================

  void _ensureInitialized() {
    if (_enemyDataList == null) {
      throw Exception('EnemyService 未初始化，請先調用 initialize()');
    }
  }

  bool _validateSingleEnemy(EnemyData enemyData) {
    return enemyData.baseHp > 0 &&
        enemyData.baseAttack >= 0 &&
        enemyData.baseDefense >= 0 &&
        enemyData.baseSpeed >= 0;
  }

  double _calculateDifficultyRating(List<Enemy> enemies, int playerLevel) {
    if (enemies.isEmpty) return 0.0;

    double rating = 0.0;
    for (final enemy in enemies) {
      double enemyRating = enemy.level / playerLevel;
      switch (enemy.type) {
        case EnemyType.elite:
          enemyRating *= 1.5;
          break;
        case EnemyType.boss:
          enemyRating *= 2.0;
          break;
        case EnemyType.normal:
          break;
      }
      rating += enemyRating;
    }

    return rating / enemies.length;
  }

  BattleState _createTempBattleState(Enemy enemy) {
    return BattleState.initial().copyWith(enemy: enemy);
  }

  // ==========================================
  // AI生成邏輯（私有方法）
  // ==========================================

  List<EnemyAction> _generateAggressiveActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];
    actions.add(_createAttackAction(enemy, isHeavy: false));
    if (_random.nextDouble() < 0.4) {
      actions.add(_createAttackAction(enemy, isHeavy: true));
    }
    if (enemy.isInDanger && _random.nextDouble() < 0.3) {
      actions.add(_createHealAction(enemy));
    }
    return _shuffleAndLimit(actions, maxActions: 3);
  }

  List<EnemyAction> _generateDefensiveActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];
    actions.add(_createDefendAction(enemy));
    if (enemy.hpPercentage < 0.7) {
      actions.add(_createHealAction(enemy));
    }
    if (_random.nextDouble() < 0.5) {
      actions.add(_createAttackAction(enemy, isHeavy: false));
    }
    return _shuffleAndLimit(actions, maxActions: 3);
  }

  List<EnemyAction> _generateBalancedActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];
    actions.add(_createAttackAction(enemy, isHeavy: false));
    if (enemy.hpPercentage < 0.5) {
      actions.add(_createHealAction(enemy));
    } else if (_random.nextDouble() < 0.3) {
      actions.add(_createBuffAction(enemy));
    }
    if (_random.nextDouble() < 0.4) {
      actions.add(_createAttackAction(enemy, isHeavy: true));
    }
    return _shuffleAndLimit(actions, maxActions: 3);
  }

  List<EnemyAction> _generateSupportActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];
    actions.add(_createDebuffAction(enemy));
    if (_random.nextDouble() < 0.6) {
      actions.add(_createBuffAction(enemy));
    }
    if (enemy.hpPercentage < 0.8) {
      actions.add(_createHealAction(enemy));
    }
    if (_random.nextDouble() < 0.3) {
      actions.add(_createAttackAction(enemy, isHeavy: false));
    }
    return _shuffleAndLimit(actions, maxActions: 3);
  }

  // ==========================================
  // 行動執行邏輯（私有方法）
  // ==========================================

  EnemyActionResult _executeAction(EnemyAction action, Enemy enemy) {
    switch (action.type) {
      case EnemyActionType.attack:
        final damage = (enemy.attack * action.damageMultiplier).round();
        return action.createResult(
          wasExecuted: true,
          damageDealt: damage,
          message: '${enemy.name} 對玩家造成 $damage 點傷害',
        );
      case EnemyActionType.defend:
        return action.createResult(
          wasExecuted: true,
          statusEffectsApplied: ['defense_boost'],
          message: '${enemy.name} 進入防禦狀態',
        );
      case EnemyActionType.buff:
        return action.createResult(
          wasExecuted: true,
          statusEffectsApplied: ['attack_boost'],
          message: '${enemy.name} 獲得了增益效果',
        );
      case EnemyActionType.debuff:
        return action.createResult(
          wasExecuted: true,
          statusEffectsApplied: ['attack_down'],
          message: '${enemy.name} 對玩家施加了減益效果',
        );
      case EnemyActionType.special:
        return action.createResult(
          wasExecuted: true,
          message: '${enemy.name} 執行了特殊行動：${action.name}',
        );
      case EnemyActionType.skill:
        return action.createResult(
          wasExecuted: true,
          message: '${enemy.name} 使用了技能：${action.name}',
        );
    }
  }

  // ==========================================
  // Action創建輔助方法（私有方法）
  // ==========================================

  EnemyAction _createAttackAction(Enemy enemy, {required bool isHeavy}) {
    return EnemyAction(
      id: 'attack_${_generateUniqueId()}',
      name: isHeavy ? '重擊' : '攻擊',
      description: isHeavy
          ? '對玩家造成 ${(enemy.attack * 1.5).round()} 點傷害'
          : '對玩家造成 ${enemy.attack} 點傷害',
      type: EnemyActionType.attack,
      skillId: isHeavy ? 'heavy_attack' : 'basic_attack',
      priority: isHeavy ? 2 : 1,
      damageMultiplier: isHeavy ? 1.5 : 1.0,
      color: isHeavy ? '#FF4444' : '#FF6B6B',
    );
  }

  EnemyAction _createDefendAction(Enemy enemy) {
    return EnemyAction(
      id: 'defend_${_generateUniqueId()}',
      name: '防禦',
      description: '提升防禦力，減少受到的傷害',
      type: EnemyActionType.defend,
      skillId: 'defend',
      priority: 3,
      color: '#4ECDC4',
    );
  }

  EnemyAction _createBuffAction(Enemy enemy) {
    return EnemyAction(
      id: 'buff_${_generateUniqueId()}',
      name: '攻擊強化',
      description: '提升攻擊力 3 回合',
      type: EnemyActionType.buff,
      skillId: 'attack_boost',
      priority: 2,
      color: '#F39C12',
    );
  }

  EnemyAction _createDebuffAction(Enemy enemy) {
    return EnemyAction(
      id: 'debuff_${_generateUniqueId()}',
      name: '攻擊削弱',
      description: '降低玩家攻擊力 3 回合',
      type: EnemyActionType.debuff,
      skillId: 'attack_down',
      priority: 2,
      color: '#9B59B6',
    );
  }

  EnemyAction _createHealAction(Enemy enemy) {
    final healAmount = (enemy.maxHp * 0.3).round();
    return EnemyAction(
      id: 'heal_${_generateUniqueId()}',
      name: '治療',
      description: '恢復 $healAmount 點生命值',
      type: EnemyActionType.special,
      skillId: 'heal_self',
      priority: 1,
      color: '#2ECC71',
    );
  }

  EnemyAction _enhanceAction(EnemyAction action, double multiplier) {
    return action.copyWith(
      damageMultiplier: action.damageMultiplier * multiplier,
    );
  }

  EnemyAction _createSpecialBossAction(Enemy enemy) {
    return EnemyAction(
      id: 'boss_special_${_generateUniqueId()}',
      name: 'Boss 特殊攻擊',
      description: '強大的特殊攻擊，無法被無效化',
      type: EnemyActionType.special,
      skillId: 'boss_special',
      priority: 0,
      isTargetable: false,
      color: '#8B0000',
      damageMultiplier: 2.0,
    );
  }

  List<EnemyAction> _shuffleAndLimit(
    List<EnemyAction> actions, {
    required int maxActions,
  }) {
    if (actions.isEmpty) {
      actions.add(
        _createAttackAction(
          Enemy(
            id: 'temp',
            name: 'temp',
            type: EnemyType.normal,
            aiBehavior: AIBehavior.balanced,
            maxHp: 50,
            currentHp: 50,
            attack: 10,
            defense: 2,
            speed: 5,
            iconPath: '',
            description: '',
            skillIds: [],
            expReward: 0,
            goldReward: 0,
          ),
          isHeavy: false,
        ),
      );
    }

    actions.shuffle(_random);
    if (actions.length > maxActions) {
      actions = actions.take(maxActions).toList();
    }
    actions.sort((a, b) => a.priority.compareTo(b.priority));

    return actions;
  }

  Enemy? _generateSingleEnemy({
    required int playerLevel,
    required double eliteChance,
    required double bossChance,
    required bool isBossEncounter,
  }) {
    EnemyType selectedType;
    final double typeRoll = _random.nextDouble();

    if (typeRoll < bossChance && isBossEncounter) {
      selectedType = EnemyType.boss;
    } else if (typeRoll < eliteChance) {
      selectedType = EnemyType.elite;
    } else {
      selectedType = EnemyType.normal;
    }

    final enemiesOfType = getEnemiesByType(selectedType);
    if (enemiesOfType.isEmpty) return null;

    final randomEnemyData =
        enemiesOfType[_random.nextInt(enemiesOfType.length)];
    final levelVariance = _random.nextInt(3) - 1;
    final adjustedLevel = (playerLevel + levelVariance).clamp(1, 99);

    return randomEnemyData.createEnemyInstance(overrideLevel: adjustedLevel);
  }

  List<String> _getAreaEnemyPool(String areaId) {
    const Map<String, List<String>> areaEnemyPools = {
      'forest': ['goblin_warrior', 'forest_spider', 'orc_berserker'],
      'dungeon': ['skeleton_archer', 'shadow_assassin', 'lich_king'],
      'volcanic': ['ice_elemental', 'ancient_dragon', 'demon_lord'],
    };

    return areaEnemyPools[areaId] ??
        getAllEnemyData().map((e) => e.id).toList();
  }

  String _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        _random.nextInt(1000).toString();
  }

  void reset() {
    _enemyDataList = null;
    _enemySkillsData = null;
  }
}
