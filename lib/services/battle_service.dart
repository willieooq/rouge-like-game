// lib/services/battle_service.dart
import 'dart:math';

import '../models/battle/battle_state.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/enemy/enemy_action.dart';
import '../models/skill/skill_execution_result.dart';
import '../models/skill/skills.dart';
import '../models/status/status_effect.dart';
import '../providers/battle_provider.dart';
import '../services/skill_service.dart';

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

  /// 玩家使用技能（舊接口，用於無效化敵人行動）
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

  /// 執行玩家技能（完整實現）
  SkillExecutionResult executePlayerSkill(
    BattleState state,
    String skillId,
    String casterId,
  ) {
    // 1. 載入技能數據
    final skill = SkillService.getSkill(skillId);
    if (skill == null) {
      return SkillExecutionResult(
        skillId: skillId,
        casterId: casterId,
        effectChains: [],
        success: false,
        message: '技能不存在：$skillId',
      );
    }

    // 2. 找到施法者
    Character? caster;
    try {
      caster = state.playerParty.firstWhere((c) => c.id == casterId);
    } catch (e) {
      // 如果找不到指定的施法者，使用隊伍中的第一個角色（如果存在）
      if (state.playerParty.isNotEmpty) {
        caster = state.playerParty.first;
      }
    }

    if (caster == null) {
      return SkillExecutionResult(
        skillId: skillId,
        casterId: casterId,
        effectChains: [],
        success: false,
        message: '找不到施法者',
      );
    }

    // 3. 計算技能的原始效果意圖
    final intents = _calculateSkillIntents(skill, caster, state);

    // 4. 對每個目標處理效果鏈
    final effectChains = <EffectChain>[];
    for (final intent in intents) {
      final chain = _processEffectChain(state, intent);
      effectChains.add(chain);
    }

    return SkillExecutionResult(
      skillId: skillId,
      casterId: casterId,
      effectChains: effectChains,
      success: true,
      message: '${caster.name} 使用了 ${skill.name}',
    );
  }

  /// 應用技能執行結果到遊戲狀態
  BattleState applySkillExecutionResult(
    BattleState state,
    SkillExecutionResult result,
  ) {
    var newState = state;

    for (final chain in result.effectChains) {
      final targetId = chain.targetId;
      final effectResult = chain.processedResult;

      if (targetId == state.enemy.id) {
        // 對敵人的效果
        if (effectResult.type == EffectType.damage) {
          final newEnemy = state.enemy.takeDamage(effectResult.actualValue);
          newState = newState.copyWith(enemy: newEnemy);
        }
        // 狀態效果的應用會在 BattleProvider 中處理
      } else if (targetId == 'party') {
        // 對隊伍的效果會在 BattleProvider 中處理
      }

      // 處理觸發事件
      for (final event in chain.triggeredEvents) {
        newState = _handleTriggeredEvent(newState, event);
      }
    }

    return newState;
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

  // ===== 私有輔助方法 =====

  /// 計算技能的原始效果意圖
  List<TargetedIntent> _calculateSkillIntents(
    Skills skill,
    Character caster,
    BattleState state,
  ) {
    final intents = <TargetedIntent>[];

    if (skill.isAttackSkill) {
      // 攻擊技能
      final buffMultiplier = _calculateBuffMultiplier(
        state.playerStatusManager,
      );
      final skillDamage = SkillService.calculateSkillDamage(
        skill,
        caster.attackPower,
        buffMultiplier,
      );

      intents.add(
        TargetedIntent(
          targetId: state.enemy.id,
          intent: EffectIntent(
            type: EffectType.damage,
            baseValue: skillDamage,
            metadata: {
              'element': skill.element,
              'skillId': skill.id,
              'casterId': caster.id,
            },
          ),
        ),
      );

      // 如果技能有附加狀態效果
      for (final statusId in skill.statusEffects) {
        intents.add(
          TargetedIntent(
            targetId: state.enemy.id,
            intent: EffectIntent(
              type: EffectType.statusEffect,
              baseValue: 1,
              metadata: {
                'statusId': statusId,
                'skillId': skill.id,
                'casterId': caster.id,
              },
            ),
          ),
        );
      }
    } else if (skill.isHealSkill) {
      // 治療技能
      intents.add(
        TargetedIntent(
          targetId: 'party',
          intent: EffectIntent(
            type: EffectType.heal,
            baseValue: skill.damage, // 治療量直接使用damage值
            metadata: {'skillId': skill.id, 'casterId': caster.id},
          ),
        ),
      );
    } else if (skill.isSupportSkill) {
      // 輔助技能 - 施加狀態效果
      for (final statusId in skill.statusEffects) {
        intents.add(
          TargetedIntent(
            targetId: skill.defaultTarget == "enemy" ? state.enemy.id : 'party',
            intent: EffectIntent(
              type: EffectType.statusEffect,
              baseValue: 1, // 狀態效果層數
              metadata: {
                'statusId': statusId,
                'skillId': skill.id,
                'casterId': caster.id,
              },
            ),
          ),
        );
      }
    }

    return intents;
  }

  /// 處理單個效果鏈
  EffectChain _processEffectChain(
    BattleState state,
    TargetedIntent targetedIntent,
  ) {
    final targetId = targetedIntent.targetId;
    final intent = targetedIntent.intent;

    // 目標對象處理效果
    final processedResult = _processEffectOnTarget(state, targetId, intent);

    // 檢查觸發的後續事件
    final triggeredEvents = _checkTriggeredEvents(
      state,
      targetId,
      processedResult,
    );

    return EffectChain(
      targetId: targetId,
      originalIntent: intent,
      processedResult: processedResult,
      triggeredEvents: triggeredEvents,
    );
  }

  /// 目標處理效果
  EffectResult _processEffectOnTarget(
    BattleState state,
    String targetId,
    EffectIntent intent,
  ) {
    if (targetId == state.enemy.id) {
      return _processEffectOnEnemy(state, targetId, intent);
    } else if (targetId == 'party') {
      return _processEffectOnParty(state, intent);
    } else {
      return _processEffectOnCharacter(state, targetId, intent);
    }
  }

  /// 敵人處理效果
  EffectResult _processEffectOnEnemy(
    BattleState state,
    String enemyId,
    EffectIntent intent,
  ) {
    switch (intent.type) {
      case EffectType.damage:
        // 應用防禦計算
        final skillDamage = intent.baseValue;
        final actualDamage = SkillService.calculateFinalDamage(
          skillDamage,
          state.enemy.defense,
        );

        return EffectResult(
          type: EffectType.damage,
          actualValue: actualDamage,
          wasModified: actualDamage != skillDamage,
          modificationReasons: actualDamage != skillDamage
              ? ['defense_reduction']
              : [],
        );

      case EffectType.statusEffect:
        // 對敵人施加狀態效果
        final statusId = intent.metadata['statusId'] as String;
        return EffectResult(
          type: EffectType.statusEffect,
          actualValue: intent.baseValue,
          modificationReasons: ['status_applied:$statusId'],
        );

      default:
        return EffectResult(type: intent.type, actualValue: 0);
    }
  }

  /// 隊伍處理效果
  EffectResult _processEffectOnParty(BattleState state, EffectIntent intent) {
    switch (intent.type) {
      case EffectType.heal:
        // 檢查是否有反治療debuff
        final modifiers = state.playerStatusManager
            .calculateAttributeModifiers();
        final healingModifier = modifiers[AttributeType.hp] ?? 0.0;

        // 如果有負面治療修正，可能改變效果
        if (healingModifier < -50) {
          // 假設-50%以上就反轉治療
          return EffectResult(
            type: EffectType.damage,
            actualValue: intent.baseValue,
            wasModified: true,
            modificationReasons: ['anti_heal_debuff'],
          );
        }

        final actualHealing = (intent.baseValue * (1 + healingModifier / 100))
            .round();
        return EffectResult(
          type: EffectType.heal,
          actualValue: actualHealing,
          wasModified: actualHealing != intent.baseValue,
          modificationReasons: healingModifier != 0 ? ['healing_modifier'] : [],
        );

      case EffectType.statusEffect:
        // 對隊伍施加狀態效果
        final statusId = intent.metadata['statusId'] as String;
        return EffectResult(
          type: EffectType.statusEffect,
          actualValue: intent.baseValue,
          modificationReasons: ['status_applied:$statusId'],
        );

      default:
        return EffectResult(type: intent.type, actualValue: intent.baseValue);
    }
  }

  /// 角色處理效果
  EffectResult _processEffectOnCharacter(
    BattleState state,
    String characterId,
    EffectIntent intent,
  ) {
    // 類似隊伍處理，但針對特定角色
    return _processEffectOnParty(state, intent);
  }

  /// 檢查觸發事件
  List<TriggeredEvent> _checkTriggeredEvents(
    BattleState state,
    String targetId,
    EffectResult result,
  ) {
    final events = <TriggeredEvent>[];

    // 情境1：敵人受到物理傷害時反擊
    if (targetId == state.enemy.id && result.type == EffectType.damage) {
      if (state.enemy.skillIds.contains('counterattack')) {
        events.add(
          TriggeredEvent(
            eventType: 'counterattack',
            sourceId: targetId,
            eventData: {'damage': 2000},
          ),
        );
      }

      // 敵人受傷後可能觸發防禦增強
      if (state.enemy.skillIds.contains('defensive_boost')) {
        events.add(
          TriggeredEvent(
            eventType: 'defensive_boost',
            sourceId: targetId,
            eventData: {'defenseIncrease': 20},
          ),
        );
      }
    }

    return events;
  }

  /// 處理觸發事件
  BattleState _handleTriggeredEvent(BattleState state, TriggeredEvent event) {
    switch (event.eventType) {
      case 'counterattack':
        final damage = event.eventData['damage'] as int;
        // 這裡需要記錄敵人要對玩家造成的反擊傷害
        // 可以添加到戰鬥狀態中，稍後在敵人回合執行
        break;

      case 'defensive_boost':
        final defenseIncrease = event.eventData['defenseIncrease'] as int;
        // 提升敵人防禦力，可以通過狀態效果實現
        break;
    }

    return state;
  }

  /// 計算BUFF倍率
  double _calculateBuffMultiplier(StatusEffectManager statusManager) {
    final modifiers = statusManager.calculateAttributeModifiers();
    final attackModifier = modifiers[AttributeType.attack] ?? 0.0;
    return 1.0 + (attackModifier / 100.0);
  }

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

  /// 執行玩家技能（舊的簡化版本）
  BattleActionResult _executePlayerSkill(BattleState state, String skillId) {
    // 這裡是為了兼容舊接口的簡化實現
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
