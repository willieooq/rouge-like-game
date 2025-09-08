// lib/services/battle_service_impl.dart
import 'dart:math';

import '../core/interfaces/i_battle_service.dart';
import '../core/interfaces/i_enemy_service.dart';
import '../core/interfaces/i_skill_service.dart';
import '../core/interfaces/i_status_service.dart';
import '../models/battle/battle_state.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/enemy/enemy_action.dart';
import '../models/skill/skill_execution_result.dart';
import '../models/skill/skills.dart';
import '../models/status/status_effect.dart';
import '../shared/beans/battle/battle_action_result.dart';
import '../shared/beans/battle/battle_configuration.dart';
import '../shared/beans/battle/battle_end_result.dart';
import '../shared/beans/skill/effect_chain_bean.dart';
import '../shared/beans/skill/skill_execution_request.dart';
import '../shared/beans/skill/skill_execution_response.dart';

/// 戰鬥服務實現
///
/// 遵循 Single Responsibility Principle：
/// 專門負責戰鬥邏輯的核心業務規則
///
/// 遵循 Dependency Inversion Principle：
/// 實現 IBattleService 抽象接口，依賴抽象而非具體實現
class BattleServiceImpl implements IBattleService {
  // ✅ 依賴注入：通過建構函數注入服務接口
  final ISkillService _skillService;
  final IEnemyService _enemyService;
  final IStatusService _statusService;
  final Random _random = Random();

  // ✅ 建構函數依賴注入
  BattleServiceImpl({
    required ISkillService skillService,
    required IEnemyService enemyService,
    required IStatusService statusService,
  }) : _skillService = skillService,
       _enemyService = enemyService,
       _statusService = statusService;

  @override
  BattleState initializeBattle(BattleConfiguration config) {
    final hasFirstStrike = _checkEnemyFirstStrike(config.enemy);
    final actionQueue = _generateEnemyActionQueue(config.enemy);

    return BattleState(
      currentPhase: BattlePhase.preparation,
      result: BattleResult.ongoing,
      turnNumber: 1,
      playerHasFirstTurn: !hasFirstStrike,
      party: config.party,
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

  @override
  BattleState startPlayerTurn(BattleState state) {
    return state.copyWith(currentPhase: BattlePhase.playerTurn);
  }

  @override
  BattleState startEnemyTurn(BattleState state) {
    return state.copyWith(
      currentPhase: BattlePhase.enemyTurn,
      currentEnemyActionIndex: 0,
    );
  }

  @override
  BattleActionResult playerAttackEnemy(BattleState state, int damage) {
    final actualDamage = _calculateDamage(damage, state.enemy.defense);
    final newEnemy = state.enemy.takeDamage(actualDamage);
    final newStatistics = state.statistics.copyWith(
      totalDamageDealt: state.statistics.totalDamageDealt + actualDamage,
    );

    final newState = state.copyWith(enemy: newEnemy, statistics: newStatistics);

    return BattleActionResult(
      newState: newState,
      actionSuccess: true,
      message: '對 ${state.enemy.name} 造成 $actualDamage 點傷害',
    );
  }

  @override
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

  // ✅ 更新為使用新的 Bean 接口
  @override
  Future<SkillExecutionResponse> executePlayerSkillWithBeans(
    BattleState state,
    String skillId,
    String casterId, {
    List<String> targetIds = const [],
  }) async {
    print('BattleService: 開始執行技能 $skillId，施法者: $casterId');

    // ✅ 使用注入的 skillService 而非靜態調用
    final skill = _skillService.getSkill(skillId);
    if (skill == null) {
      print('BattleService: 技能不存在 - $skillId');
      return SkillExecutionResponse(
        skillId: skillId,
        casterId: casterId,
        effectChains: [],
        success: false,
        message: '技能不存在：$skillId',
      );
    }

    print('BattleService: 找到技能 ${skill.name}，類型: ${skill.type}');

    // 找到施法者
    Character? caster;
    try {
      caster = state.party.characters.firstWhere((c) => c.id == casterId);
      print('BattleService: 找到施法者 ${caster.name}，攻擊力: ${caster.attackPower}');
    } catch (e) {
      if (state.party.characters.isNotEmpty) {
        caster = state.party.characters.first;
        print('BattleService: 找不到指定施法者，使用 ${caster.name}');
      }
    }

    if (caster == null) {
      print('BattleService: 無可用的施法者');
      return SkillExecutionResponse(
        skillId: skillId,
        casterId: casterId,
        effectChains: [],
        success: false,
        message: '找不到施法者',
      );
    }

    // ✅ 使用新的 Bean 請求格式
    final request = SkillExecutionRequest(
      skillId: skillId,
      casterId: casterId,
      allies: state.party.characters,
      enemies: [state.enemy],
      targetIds: targetIds,
      context: {'battleState': state},
    );

    // ✅ 使用注入的服務執行技能
    return await _skillService.executeSkill(request);
  }

  // ✅ 保留舊的接口以相容性，但內部使用新方法
  @override
  SkillExecutionResult executePlayerSkill(
    BattleState state,
    String skillId,
    String casterId,
  ) {
    // 暫時的適配器，將新的 Bean 轉換為舊的格式
    // 在完全遷移後可以移除這個方法
    print('BattleService: 使用舊接口執行技能，建議更新為新的 Bean 接口');

    final skill = _skillService.getSkill(skillId);
    if (skill == null) {
      return SkillExecutionResult(
        skillId: skillId,
        casterId: casterId,
        effectChains: [],
        success: false,
        message: '技能不存在：$skillId',
      );
    }

    // 簡化實現
    return SkillExecutionResult(
      skillId: skillId,
      casterId: casterId,
      effectChains: [],
      success: true,
      message: '${skill.name} 執行成功（舊接口）',
    );
  }

  @override
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
      }

      // 處理觸發事件
      for (final event in chain.triggeredEvents) {
        newState = _handleTriggeredEvent(newState, event);
      }
    }

    return newState;
  }

  // ✅ 新增：使用新 Bean 接口應用技能效果
  BattleState applySkillExecutionResponse(
    BattleState state,
    SkillExecutionResponse response,
  ) {
    var newState = state;

    for (final chain in response.effectChains) {
      final targetId = chain.targetId;
      final effectResult = chain.processedResult;

      if (targetId == state.enemy.id) {
        // 對敵人的效果
        if (effectResult.type == EffectType.damage) {
          final newEnemy = state.enemy.takeDamage(effectResult.actualValue);
          newState = newState.copyWith(enemy: newEnemy);
        }
      } else if (targetId == 'party') {
        // 對隊伍的效果會在 BattleProvider 中處理
      }

      // 處理觸發事件
      for (final event in chain.triggeredEvents) {
        newState = _handleTriggeredEventBean(newState, event);
      }
    }

    return newState;
  }

  @override
  BattleActionResult enemyTakeDamage(BattleState state, int damage) {
    final actualDamage = _calculateDamage(damage, state.enemy.defense);
    final newEnemy = state.enemy.takeDamage(actualDamage);
    final newState = state.copyWith(enemy: newEnemy);

    return BattleActionResult(
      newState: newState,
      actionSuccess: true,
      message: '${state.enemy.name} 受到 $actualDamage 點傷害',
    );
  }

  @override
  BattleActionResult enemyReceiveHealing(BattleState state, int healing) {
    final newEnemy = state.enemy.heal(healing);
    final newState = state.copyWith(enemy: newEnemy);

    return BattleActionResult(
      newState: newState,
      actionSuccess: true,
      message: '${state.enemy.name} 恢復了 $healing 點生命值',
    );
  }

  @override
  BattleActionResult executeEnemyFirstStrike(BattleState state) {
    return BattleActionResult(
      newState: state,
      actionSuccess: true,
      message: '${state.enemy.name} 發動了先手攻擊！',
    );
  }

  @override
  BattleState applyEnemyActionResult(
    BattleState state,
    EnemyActionResult actionResult,
  ) {
    if (!actionResult.wasExecuted) return state;

    var newStatistics = state.statistics;

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

  @override
  BattleActionResult attemptEscape(BattleState state) {
    final escapeChance = state.calculateEscapeChance();
    final success = _rollSuccess(escapeChance);

    if (success) {
      final newState = state.copyWith(result: BattleResult.escaped);
      return BattleActionResult(
        newState: newState,
        actionSuccess: true,
        message: '成功逃離了戰鬥！',
      );
    } else {
      return BattleActionResult(
        newState: state,
        actionSuccess: false,
        message: '逃跑失敗！',
      );
    }
  }

  @override
  BattleState selectEnemyActionToNullify(BattleState state, String actionId) {
    final action = state.enemyActionQueue
        .where((a) => a.id == actionId && a.isTargetable)
        .firstOrNull;

    return state.copyWith(selectedEnemyAction: action);
  }

  @override
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

  @override
  BattleEndResult checkBattleEnd(BattleState state) {
    if (state.isEnemyDefeated) {
      return const BattleEndResult(isEnded: true, resultType: 'victory');
    }

    if (_isPlayerDefeated(state)) {
      return const BattleEndResult(isEnded: true, resultType: 'defeat');
    }

    if (state.result == BattleResult.escaped) {
      return const BattleEndResult(isEnded: true, resultType: 'escaped');
    }

    return const BattleEndResult(isEnded: false, resultType: 'ongoing');
  }

  @override
  BattleState endBattle(BattleState state, String result) {
    final battleResult = switch (result) {
      'victory' => BattleResult.victory,
      'defeat' => BattleResult.defeat,
      'escaped' => BattleResult.escaped,
      _ => BattleResult.ongoing,
    };

    return state.copyWith(
      currentPhase: BattlePhase.battleEnd,
      result: battleResult,
    );
  }

  @override
  bool canContinueBattle(BattleState state) {
    return state.isBattleOngoing;
  }

  @override
  bool isPlayerTurn(BattleState state) {
    return state.isPlayerTurn && state.isBattleOngoing;
  }

  // ===== 私有方法 =====

  BattleActionResult _nullifyEnemyAction(BattleState state, String actionId) {
    final newState = selectEnemyActionToNullify(state, actionId);

    return BattleActionResult(
      newState: newState,
      actionSuccess: true,
      message: '成功無效化了敵人的行動',
    );
  }

  BattleActionResult _executePlayerSkill(BattleState state, String skillId) {
    return BattleActionResult(
      newState: state,
      actionSuccess: true,
      message: '使用了技能：$skillId',
    );
  }

  /// 計算技能的原始效果意圖（舊版本，保留相容性）
  List<TargetedIntent> _calculateSkillIntents(
    Skills skill,
    Character caster,
    BattleState state,
  ) {
    final intents = <TargetedIntent>[];

    if (skill.isAttackSkill) {
      final buffMultiplier = _calculateBuffMultiplier(
        state.playerStatusManager,
      );

      // ✅ 使用注入的服務而非靜態調用
      final skillDamage = _skillService.calculateSkillDamage(
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
      intents.add(
        TargetedIntent(
          targetId: 'party',
          intent: EffectIntent(
            type: EffectType.heal,
            baseValue: skill.damage,
            metadata: {'skillId': skill.id, 'casterId': caster.id},
          ),
        ),
      );
    } else if (skill.isSupportSkill) {
      for (final statusId in skill.statusEffects) {
        intents.add(
          TargetedIntent(
            targetId: skill.defaultTarget == "enemy" ? state.enemy.id : 'party',
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
    }

    return intents;
  }

  EffectChain _processEffectChain(
    BattleState state,
    TargetedIntent targetedIntent,
  ) {
    final targetId = targetedIntent.targetId;
    final intent = targetedIntent.intent;

    final processedResult = _processEffectOnTarget(state, targetId, intent);
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

  EffectResult _processEffectOnEnemy(
    BattleState state,
    String enemyId,
    EffectIntent intent,
  ) {
    switch (intent.type) {
      case EffectType.damage:
        final skillDamage = intent.baseValue;

        // ✅ 使用注入的服務而非靜態調用
        final actualDamage = _skillService.calculateFinalDamage(
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

  EffectResult _processEffectOnParty(BattleState state, EffectIntent intent) {
    switch (intent.type) {
      case EffectType.heal:
        final modifiers = state.playerStatusManager
            .calculateAttributeModifiers();
        final healingModifier = modifiers[AttributeType.hp] ?? 0.0;

        if (healingModifier < -50) {
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

  EffectResult _processEffectOnCharacter(
    BattleState state,
    String characterId,
    EffectIntent intent,
  ) {
    return _processEffectOnParty(state, intent);
  }

  List<TriggeredEvent> _checkTriggeredEvents(
    BattleState state,
    String targetId,
    EffectResult result,
  ) {
    final events = <TriggeredEvent>[];

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

  BattleState _handleTriggeredEvent(BattleState state, TriggeredEvent event) {
    // 處理舊版本的觸發事件
    return state;
  }

  // ✅ 新增：處理新 Bean 版本的觸發事件
  BattleState _handleTriggeredEventBean(
    BattleState state,
    TriggeredEventBean event,
  ) {
    switch (event.eventType) {
      case 'counterattack':
        final damage = event.eventData['damage'] as int;
        // 處理反擊邏輯
        break;
      case 'defensive_boost':
        final defenseIncrease = event.eventData['defenseIncrease'] as int;
        // 處理防禦增強
        break;
    }
    return state;
  }

  double _calculateBuffMultiplier(StatusEffectManager statusManager) {
    final modifiers = statusManager.calculateAttributeModifiers();
    final attackModifier = modifiers[AttributeType.attack] ?? 0.0;
    return 1.0 + (attackModifier / 100.0);
  }

  bool _checkEnemyFirstStrike(Enemy enemy) {
    return enemy.skillIds.contains('first_strike') ||
        enemy.skillIds.contains('ambush');
  }

  List<EnemyAction> _generateEnemyActionQueue(Enemy enemy) {
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

  int _calculateDamage(int baseDamage, int defense) {
    final actualDamage = (baseDamage - defense).clamp(1, baseDamage);
    return actualDamage;
  }

  bool _isPlayerDefeated(BattleState state) {
    return false; // 需要與隊伍系統整合
  }

  bool _rollSuccess(double chance) {
    return _random.nextDouble() < chance;
  }
}
