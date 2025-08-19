// lib/services/battle_service.dart
import 'dart:math';

import '../models/battle/battle_state.dart';
import '../models/enemy/enemy.dart';
import '../models/enemy/enemy_action.dart';
import '../models/status/status_effect.dart';
import '../providers/battle_provider.dart';

/// 戰鬥服務
///
/// 遵循 Single Responsibility Principle：
/// 專門負責戰鬥邏輯的核心業務規則
///
/// 遵循 Dependency Inversion Principle：
/// 依賴於抽象接口而非具體實現
class BattleService {
  final Random _random = Random();

  /// 初始化戰鬥
  BattleState initializeBattle(BattleConfiguration config) {
    final hasFirstStrike = _checkEnemyFirstStrike(config.enemy);
    final actionQueue = _generateEnemyActionQueue(config.enemy);

    return BattleState(
      currentPhase: BattlePhase.preparation,
      result: BattleResult.ongoing,
      turnNumber: 1,
      playerHasFirstTurn: !hasFirstStrike,
      playerParty: config.playerParty,
      enemy: config.enemy,
      playerStatusManager: StatusEffectManager(),
      enemyStatusManager: StatusEffectManager(),
      enemyActionQueue: actionQueue,
      currentEnemyActionIndex: 0,
      statistics: BattleStatistics.initial(),
      canEscape: config.canEscape,
      baseEscapeChance: 0.7,
    );
  }

  /// 開始玩家回合
  BattleState startPlayerTurn(BattleState state) {
    return state.copyWith(currentPhase: BattlePhase.playerTurn);
  }

  /// 開始敵人回合
  BattleState startEnemyTurn(BattleState state) {
    return state.copyWith(
      currentPhase: BattlePhase.enemyTurn,
      currentEnemyActionIndex: 0,
    );
  }

  /// 玩家攻擊敵人
  BattleActionResult playerAttackEnemy(BattleState state, int damage) {
    final actualDamage = _calculateDamage(damage, state.enemy.defense);
    final newEnemy = state.enemy.takeDamage(actualDamage);
    final newStatistics = state.statistics.copyWith(
      totalDamageDealt: state.statistics.totalDamageDealt + actualDamage,
    );

    final newState = state.copyWith(enemy: newEnemy, statistics: newStatistics);

    return BattleActionResult(
      newState: newState,
      success: true,
      message: '對 ${state.enemy.name} 造成 $actualDamage 點傷害',
    );
  }

  /// 玩家使用技能
  BattleActionResult playerUseSkill(
    BattleState state,
    String skillId, {
    String? targetEnemyActionId,
  }) {
    // 如果指定了目標敵人行動，則無效化該行動
    if (targetEnemyActionId != null) {
      return _nullifyEnemyAction(state, targetEnemyActionId);
    }

    // 否則執行技能效果
    return _executePlayerSkill(state, skillId);
  }

  /// 敵人受到傷害
  BattleActionResult enemyTakeDamage(BattleState state, int damage) {
    final actualDamage = _calculateDamage(damage, state.enemy.defense);
    final newEnemy = state.enemy.takeDamage(actualDamage);

    final newState = state.copyWith(enemy: newEnemy);

    return BattleActionResult(
      newState: newState,
      success: true,
      message: '${state.enemy.name} 受到 $actualDamage 點傷害',
    );
  }

  /// 敵人接受治療
  BattleActionResult enemyReceiveHealing(BattleState state, int healing) {
    final newEnemy = state.enemy.heal(healing);
    final newState = state.copyWith(enemy: newEnemy);

    return BattleActionResult(
      newState: newState,
      success: true,
      message: '${state.enemy.name} 恢復了 $healing 點生命值',
    );
  }

  /// 執行敵人先手攻擊
  BattleActionResult executeEnemyFirstStrike(BattleState state) {
    // 執行敵人的先手技能
    // 這裡是簡化實現，實際會根據具體的先手技能來處理
    return BattleActionResult(
      newState: state,
      success: true,
      message: '${state.enemy.name} 發動了先手攻擊！',
    );
  }

  /// 應用敵人行動結果
  BattleState applyEnemyActionResult(
    BattleState state,
    EnemyActionResult actionResult,
  ) {
    if (!actionResult.wasExecuted) return state;

    var newStatistics = state.statistics;

    // 更新統計數據
    if (actionResult.damageDealt > 0) {
      newStatistics = newStatistics.copyWith(
        totalDamageReceived:
            newStatistics.totalDamageReceived + actionResult.damageDealt,
      );
    }

    if (actionResult.healingReceived > 0) {
      final newEnemy = state.enemy.heal(actionResult.healingReceived);
      return state.copyWith(enemy: newEnemy, statistics: newStatistics);
    }

    return state.copyWith(statistics: newStatistics);
  }

  /// 嘗試逃跑
  BattleActionResult attemptEscape(BattleState state) {
    final escapeChance = state.calculateEscapeChance();
    final success = _rollSuccess(escapeChance);

    if (success) {
      final newState = state.copyWith(result: BattleResult.escaped);
      return BattleActionResult(
        newState: newState,
        success: true,
        message: '成功逃離了戰鬥！',
      );
    } else {
      return BattleActionResult(
        newState: state,
        success: false,
        message: '逃跑失敗！',
      );
    }
  }

  /// 選擇要無效化的敵人行動
  BattleState selectEnemyActionToNullify(BattleState state, String actionId) {
    final action = state.enemyActionQueue
        .where((a) => a.id == actionId && a.isTargetable)
        .firstOrNull;

    return state.copyWith(selectedEnemyAction: action);
  }

  /// 準備下一回合
  BattleState prepareNextTurn(BattleState state) {
    final newActionQueue = _generateEnemyActionQueue(state.enemy);
    final newStatistics = state.statistics.copyWith(
      turnCount: state.statistics.turnCount + 1,
    );

    return state.copyWith(
      turnNumber: state.turnNumber + 1,
      enemyActionQueue: newActionQueue,
      selectedEnemyAction: null,
      statistics: newStatistics,
    );
  }

  /// 檢查戰鬥是否結束
  BattleEndResult checkBattleEnd(BattleState state) {
    // 檢查敵人是否死亡
    if (state.isEnemyDefeated) {
      return const BattleEndResult(isEnded: true, result: BattleResult.victory);
    }

    // 檢查玩家是否死亡（需要與隊伍系統整合）
    if (_isPlayerDefeated(state)) {
      return const BattleEndResult(isEnded: true, result: BattleResult.defeat);
    }

    // 檢查是否已逃跑
    if (state.result == BattleResult.escaped) {
      return const BattleEndResult(isEnded: true, result: BattleResult.escaped);
    }

    return const BattleEndResult(isEnded: false, result: BattleResult.ongoing);
  }

  /// 結束戰鬥
  BattleState endBattle(BattleState state, BattleResult result) {
    return state.copyWith(currentPhase: BattlePhase.battleEnd, result: result);
  }

  /// 檢查戰鬥是否可以繼續
  bool canContinueBattle(BattleState state) {
    return state.isBattleOngoing;
  }

  /// 檢查是否為玩家回合
  bool isPlayerTurn(BattleState state) {
    return state.isPlayerTurn && state.isBattleOngoing;
  }

  // 私有輔助方法

  /// 檢查敵人是否有先手權
  bool _checkEnemyFirstStrike(Enemy enemy) {
    return enemy.skillIds.contains('first_strike') ||
        enemy.skillIds.contains('ambush');
  }

  /// 生成敵人行動隊列
  List<EnemyAction> _generateEnemyActionQueue(Enemy enemy) {
    // 根據敵人的 AI 行為模式生成行動
    switch (enemy.aiBehavior) {
      case AIBehavior.aggressive:
        return _generateAggressiveActions(enemy);
      case AIBehavior.defensive:
        return _generateDefensiveActions(enemy);
      case AIBehavior.balanced:
        return _generateBalancedActions(enemy);
      case AIBehavior.support:
        return _generateSupportActions(enemy);
    }
  }

  /// 生成攻擊型行動序列
  List<EnemyAction> _generateAggressiveActions(Enemy enemy) {
    return [
      const EnemyAction(
        id: 'aggressive_attack_1',
        name: '攻擊',
        description: '基礎攻擊',
        type: EnemyActionType.attack,
        skillId: 'basic_attack',
        damageMultiplier: 1.0,
      ),
      const EnemyAction(
        id: 'aggressive_attack_2',
        name: '重擊',
        description: '強力攻擊',
        type: EnemyActionType.attack,
        skillId: 'heavy_attack',
        damageMultiplier: 1.5,
      ),
    ];
  }

  /// 生成防禦型行動序列
  List<EnemyAction> _generateDefensiveActions(Enemy enemy) {
    return [
      const EnemyAction(
        id: 'defensive_defend_1',
        name: '防禦',
        description: '提高防禦力',
        type: EnemyActionType.defend,
        skillId: 'defend',
      ),
      const EnemyAction(
        id: 'defensive_attack_1',
        name: '反擊',
        description: '防禦後的反擊',
        type: EnemyActionType.attack,
        skillId: 'counter_attack',
        damageMultiplier: 0.8,
      ),
    ];
  }

  /// 生成平衡型行動序列
  List<EnemyAction> _generateBalancedActions(Enemy enemy) {
    return [
      const EnemyAction(
        id: 'balanced_attack_1',
        name: '攻擊',
        description: '基礎攻擊',
        type: EnemyActionType.attack,
        skillId: 'basic_attack',
        damageMultiplier: 1.0,
      ),
      const EnemyAction(
        id: 'balanced_buff_1',
        name: '強化',
        description: '提升攻擊力',
        type: EnemyActionType.buff,
        skillId: 'attack_boost',
      ),
      const EnemyAction(
        id: 'balanced_attack_2',
        name: '強化攻擊',
        description: '強化後的攻擊',
        type: EnemyActionType.attack,
        skillId: 'boosted_attack',
        damageMultiplier: 1.3,
      ),
    ];
  }

  /// 生成輔助型行動序列
  List<EnemyAction> _generateSupportActions(Enemy enemy) {
    return [
      const EnemyAction(
        id: 'support_debuff_1',
        name: '虛弱',
        description: '降低玩家攻擊力',
        type: EnemyActionType.debuff,
        skillId: 'attack_down',
      ),
      const EnemyAction(
        id: 'support_buff_1',
        name: '治療',
        description: '回復生命值',
        type: EnemyActionType.buff,
        skillId: 'heal_self',
      ),
    ];
  }

  /// 無效化敵人行動
  BattleActionResult _nullifyEnemyAction(BattleState state, String actionId) {
    final newState = selectEnemyActionToNullify(state, actionId);

    return BattleActionResult(
      newState: newState,
      success: true,
      message: '成功無效化了敵人的行動',
    );
  }

  /// 執行玩家技能
  BattleActionResult _executePlayerSkill(BattleState state, String skillId) {
    // 這裡需要與技能系統整合
    // 暫時返回基本結果
    return BattleActionResult(
      newState: state,
      success: true,
      message: '使用了技能：$skillId',
    );
  }

  /// 計算傷害
  int _calculateDamage(int baseDamage, int defense) {
    final actualDamage = (baseDamage - defense).clamp(1, baseDamage);
    return actualDamage;
  }

  /// 檢查玩家是否被擊敗
  bool _isPlayerDefeated(BattleState state) {
    // 這裡需要與隊伍系統整合
    // 暫時返回 false
    return false;
  }

  /// 機率判定
  bool _rollSuccess(double chance) {
    return _random.nextDouble() < chance;
  }
}

/// 戰鬥行動結果
class BattleActionResult {
  final BattleState newState;
  final bool success;
  final String message;

  const BattleActionResult({
    required this.newState,
    required this.success,
    required this.message,
  });
}

/// 戰鬥結束檢查結果
class BattleEndResult {
  final bool isEnded;
  final BattleResult result;

  const BattleEndResult({required this.isEnded, required this.result});
}
