// lib/providers/battle_provider.dart (狀態機重構版)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/services/enemy_ai_service.dart';

import '../models/battle/battle_state.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/skill/skill_execution_result.dart';
import '../services/battle_service.dart';
import '../services/enemy_action_service.dart';
import '../services/status_service.dart';

/// 戰鬥狀態管理 Provider (狀態機重構版)
///
/// 職責：
/// - 管理戰鬥狀態機
/// - 統一推進戰鬥階段
/// - 集中處理戰鬥結束邏輯
class BattleNotifier extends StateNotifier<BattleState> {
  final BattleService _battleService;
  final EnemyActionService _enemyActionService;
  final StatusService _statusService;
  final EnemyAIService _enemyAIService;

  BattleNotifier({
    required BattleService battleService,
    required EnemyActionService enemyActionService,
    required StatusService statusService,
    required EnemyAIService enemyAIService,
  }) : _battleService = battleService,
       _enemyActionService = enemyActionService,
       _statusService = statusService,
       _enemyAIService = enemyAIService,
       super(BattleState.initial());

  /// 開始戰鬥 (為了與現有代碼兼容)
  void startBattle(List<Enemy> enemies) {
    if (enemies.isEmpty) return;

    final enemy = enemies.first;
    const playerParty = <Character>[];

    initializeBattle(playerParty: playerParty, enemy: enemy, canEscape: true);
  }

  /// 初始化戰鬥
  void initializeBattle({
    required List<Character> playerParty,
    required Enemy enemy,
    bool canEscape = true,
  }) {
    print('戰鬥階段: 初始化戰鬥');

    // 生成敵人行動隊列
    final actionQueue = _enemyAIService.generateActionQueue(
      enemy: enemy,
      playerParty: playerParty,
      turnNumber: 1,
    );

    final enhancedActionQueue = _enemyAIService.adjustActionsByEnemyType(
      actionQueue,
      enemy,
    );

    final battleConfig = BattleConfiguration(
      playerParty: playerParty,
      enemy: enemy,
      canEscape: canEscape,
    );

    final initialState = _battleService.initializeBattle(battleConfig);
    state = initialState.copyWith(enemyActionQueue: enhancedActionQueue);

    // 如果敵人有先手權，執行先手行動
    if (!state.playerHasFirstTurn) {
      _executeEnemyFirstStrike();
    }

    // 推進到玩家回合開始
    _setPhase(BattlePhase.playerTurn);
    advanceBattlePhase();
  }

  /// 戰鬥狀態機核心 - 推進戰鬥階段
  void advanceBattlePhase() {
    // 集中檢查戰鬥是否結束
    if (_checkBattleEnd()) {
      _setPhase(BattlePhase.battleEnd);
      _handleBattleEnd();
      return;
    }

    switch (state.currentPhase) {
      case BattlePhase.preparation:
        // 準備階段不需要推進，由 initializeBattle 處理
        break;

      case BattlePhase.playerTurn:
        _executePlayerTurnStart();
        // 玩家回合保持活躍狀態，等待玩家操作
        break;

      case BattlePhase.enemyTurn:
        _executeEnemyTurnStart();
        _setPhase(BattlePhase.enemyTurn); // 保持敵人回合狀態
        _executeEnemyActions();
        // 敵人行動完成後推進到玩家回合
        _completeEnemyTurn();
        break;

      case BattlePhase.battleEnd:
        // 戰鬥已結束，不需要推進
        break;
      case BattlePhase.victory:
        // TODO: Handle this case.
        throw UnimplementedError();
      case BattlePhase.defeat:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  /// 玩家結束回合 - UI 調用
  void endPlayerTurn() {
    print('戰鬥階段: 玩家回合結束');

    if (!_battleService.isPlayerTurn(state)) return;

    // 處理玩家回合結束
    _executePlayerTurnEnd();

    // 推進到敵人回合
    _setPhase(BattlePhase.enemyTurn);
    advanceBattlePhase();
  }

  /// 玩家使用技能 - UI 調用
  Future<SkillExecutionResult> executePlayerSkill(
    String skillId, {
    required String casterId,
  }) async {
    if (!_battleService.isPlayerTurn(state)) {
      return SkillExecutionResult(
        skillId: skillId,
        casterId: casterId,
        effectChains: [],
        success: false,
        message: '不是玩家回合',
      );
    }

    // 執行技能邏輯
    final result = _battleService.executePlayerSkill(state, skillId, casterId);

    if (result.success) {
      // 應用技能效果到遊戲狀態
      await _applySkillExecutionResult(result);

      // 更新統計數據
      _updateSkillStatistics(result);

      // 使用技能後檢查戰鬥是否結束
      if (_checkBattleEnd()) {
        advanceBattlePhase();
      }
    }

    return result;
  }

  /// 玩家攻擊敵人 (為了與現有代碼兼容)
  void playerAttackEnemy(int damage) {
    if (!_battleService.isPlayerTurn(state)) return;

    final result = _battleService.playerAttackEnemy(state, damage);
    state = result.newState;

    // 檢查戰鬥是否結束
    if (_checkBattleEnd()) {
      advanceBattlePhase();
    }
  }

  /// 玩家嘗試逃跑
  bool attemptEscape() {
    if (!state.canEscape || !_battleService.isPlayerTurn(state)) {
      return false;
    }

    final result = _battleService.attemptEscape(state);
    state = result.newState;

    // 逃跑成功會觸發戰鬥結束
    if (result.success) {
      advanceBattlePhase();
    }

    return result.success;
  }

  // ===== 純粹的階段執行方法 (無流程控制) =====

  /// 執行玩家回合開始
  void _executePlayerTurnStart() {
    print('戰鬥階段: 玩家回合開始');

    if (!_battleService.canContinueBattle(state)) return;

    // 處理回合開始狀態效果
    final statusResult = _statusService.processTurnStart(
      state.playerStatusManager,
      isPlayer: true,
    );

    // 更新狀態並應用效果
    state = _battleService.startPlayerTurn(state);
    _applyStatusEffects(statusResult, isPlayer: true);
  }

  /// 執行玩家回合結束
  void _executePlayerTurnEnd() {
    print('戰鬥階段: 玩家回合結束處理');

    // 處理回合結束狀態效果
    final statusResult = _statusService.processTurnEnd(
      state.playerStatusManager,
      isPlayer: true,
    );

    _applyStatusEffects(statusResult, isPlayer: true);
  }

  /// 執行敵人回合開始
  void _executeEnemyTurnStart() {
    print('戰鬥階段: 敵人回合開始');

    if (!_battleService.canContinueBattle(state)) return;

    // 處理敵人回合開始狀態效果
    final statusResult = _statusService.processTurnStart(
      state.enemyStatusManager,
      isPlayer: false,
    );

    // 更新狀態
    state = _battleService.startEnemyTurn(state);
    _applyStatusEffects(statusResult, isPlayer: false);
  }

  /// 執行敵人行動序列
  void _executeEnemyActions() {
    print('戰鬥階段: 敵人執行行動');

    final actionResults = _enemyActionService.executeActionQueue(
      state.enemyActionQueue,
      state.selectedEnemyAction,
      state.enemy,
    );

    // 應用每個行動的結果
    for (final actionResult in actionResults) {
      state = _battleService.applyEnemyActionResult(state, actionResult);

      // 檢查每個行動後是否戰鬥結束
      if (_checkBattleEnd()) return;
    }
  }

  /// 完成敵人回合
  void _completeEnemyTurn() {
    print('戰鬥階段: 敵人回合結束');

    // 處理敵人回合結束狀態效果
    final statusResult = _statusService.processTurnEnd(
      state.enemyStatusManager,
      isPlayer: false,
    );

    _applyStatusEffects(statusResult, isPlayer: false);

    // 檢查戰鬥是否結束
    if (_checkBattleEnd()) return;

    // 生成新的行動隊列
    final newActionQueue = _enemyAIService.generateActionQueue(
      enemy: state.enemy,
      playerParty: state.playerParty,
      turnNumber: state.turnNumber + 1,
    );

    final enhancedActionQueue = _enemyAIService.adjustActionsByEnemyType(
      newActionQueue,
      state.enemy,
    );

    // 準備下一回合
    state = _battleService.prepareNextTurn(state);
    state = state.copyWith(
      enemyActionQueue: enhancedActionQueue,
      selectedEnemyAction: null,
    );

    // 推進到玩家回合
    _setPhase(BattlePhase.playerTurn);
    advanceBattlePhase();
  }

  /// 處理戰鬥結束
  void _handleBattleEnd() {
    print('戰鬥階段: 戰鬥結束');

    final battleEndResult = _battleService.checkBattleEnd(state);

    switch (battleEndResult.result) {
      case BattleResult.victory:
        print('戰鬥結果: 玩家勝利');
        _handleVictory();
        break;
      case BattleResult.defeat:
        print('戰鬥結果: 玩家失敗');
        _handleDefeat();
        break;
      case BattleResult.escaped:
        print('戰鬥結果: 玩家逃跑');
        _handleEscape();
        break;
      case BattleResult.ongoing:
        // 不應該到達這裡
        print('警告: 戰鬥結束處理但結果為進行中');
        break;
    }

    _cleanupBattleEndEffects();
  }

  /// 處理勝利
  void _handleVictory() {
    // TODO: 實現勝利獎勵邏輯
    // - 經驗值獎勵
    // - 物品掉落
    // - 金幣獎勵
    print('處理勝利獎勵');
  }

  /// 處理失敗
  void _handleDefeat() {
    // TODO: 實現失敗處理邏輯
    // - 遊戲結束
    // - 死亡懲罰
    // - 復活選項
    print('處理失敗邏輯');
  }

  /// 處理逃跑
  void _handleEscape() {
    // TODO: 實現逃跑處理邏輯
    // - 回到上一個場景
    // - 可能的懲罰
    print('處理逃跑邏輯');
  }

  // ===== 輔助方法 =====

  /// 設置戰鬥階段
  void _setPhase(BattlePhase phase) {
    state = state.copyWith(currentPhase: phase);
  }

  /// 集中檢查戰鬥是否結束
  bool _checkBattleEnd() {
    final battleEndResult = _battleService.checkBattleEnd(state);

    if (battleEndResult.isEnded) {
      state = _battleService.endBattle(state, battleEndResult.result);
      return true;
    }

    return false;
  }

  /// 執行敵人的先手攻擊
  void _executeEnemyFirstStrike() {
    print('戰鬥階段: 敵人先手攻擊');
    final result = _battleService.executeEnemyFirstStrike(state);
    state = result.newState;
  }

  // ===== 以下是現有的輔助方法，保持不變 =====

  /// 應用技能執行結果到戰鬥狀態
  Future<void> _applySkillExecutionResult(SkillExecutionResult result) async {
    for (final chain in result.effectChains) {
      final targetId = chain.targetId;
      final effectResult = chain.processedResult;

      if (targetId == state.enemy.id) {
        await _applyEffectToEnemy(effectResult);
      } else if (targetId == 'party') {
        await _applyEffectToParty(effectResult);
      }

      _processTriggeredEvents(chain.triggeredEvents);
    }
  }

  /// 對敵人應用效果
  Future<void> _applyEffectToEnemy(EffectResult effectResult) async {
    switch (effectResult.type) {
      case EffectType.damage:
        final newEnemy = state.enemy.takeDamage(effectResult.actualValue);
        state = state.copyWith(enemy: newEnemy);

        final newStats = state.statistics.copyWith(
          totalDamageDealt:
              state.statistics.totalDamageDealt + effectResult.actualValue,
        );
        state = state.copyWith(statistics: newStats);
        break;

      case EffectType.statusEffect:
        final statusId = _extractStatusIdFromReasons(
          effectResult.modificationReasons,
        );
        if (statusId != null) {
          await _applyStatusEffectToEnemy(statusId);
        }
        break;

      default:
        break;
    }
  }

  /// 對隊伍應用效果
  Future<void> _applyEffectToParty(EffectResult effectResult) async {
    switch (effectResult.type) {
      case EffectType.heal:
        _applyPlayerHotHealing(effectResult.actualValue);
        break;

      case EffectType.damage:
        _applyPlayerDotDamage(effectResult.actualValue);
        break;

      case EffectType.statusEffect:
        final statusId = _extractStatusIdFromReasons(
          effectResult.modificationReasons,
        );
        if (statusId != null) {
          await _applyStatusEffectToPlayer(statusId);
        }
        break;

      default:
        break;
    }
  }

  /// 處理觸發事件列表
  void _processTriggeredEvents(List<TriggeredEvent> events) {
    for (final event in events) {
      _handleTriggeredEvent(event);
    }
  }

  /// 處理單個觸發事件
  void _handleTriggeredEvent(TriggeredEvent event) {
    switch (event.eventType) {
      case 'counterattack':
        final damage = event.eventData['damage'] as int;
        _applyPlayerDotDamage(damage);
        break;

      case 'defensive_boost':
        final defenseIncrease = event.eventData['defenseIncrease'] as int;
        _applyDefensiveBoostToEnemy(defenseIncrease);
        break;

      default:
        break;
    }
  }

  /// 更新技能使用統計
  void _updateSkillStatistics(SkillExecutionResult result) {
    final currentSkillsUsed = List<String>.from(
      state.statistics.skillsUsed ?? [],
    );
    currentSkillsUsed.add(result.skillId);

    final newStats = state.statistics.copyWith(skillsUsed: currentSkillsUsed);
    state = state.copyWith(statistics: newStats);
  }

  /// 對敵人施加狀態效果
  Future<void> _applyStatusEffectToEnemy(String statusId) async {
    try {
      final statusResult = await _statusService.applyStatusEffect(
        state.enemyStatusManager,
        statusId,
        isPlayer: false,
      );

      if (statusResult.success) {
        state = state.copyWith(enemyStatusManager: statusResult.statusManager);
      }
    } catch (e) {
      print('應用敵人狀態效果失敗: $e');
    }
  }

  /// 對玩家施加狀態效果
  Future<void> _applyStatusEffectToPlayer(String statusId) async {
    try {
      final statusResult = await _statusService.applyStatusEffect(
        state.playerStatusManager,
        statusId,
        isPlayer: true,
      );

      if (statusResult.success) {
        state = state.copyWith(playerStatusManager: statusResult.statusManager);
      }
    } catch (e) {
      print('應用玩家狀態效果失敗: $e');
    }
  }

  /// 對敵人應用防禦增強
  void _applyDefensiveBoostToEnemy(int defenseIncrease) {
    _applyStatusEffectToEnemy('defense_boost');
  }

  /// 從修改原因中提取狀態效果ID
  String? _extractStatusIdFromReasons(List<String> reasons) {
    for (final reason in reasons) {
      if (reason.startsWith('status_applied:')) {
        return reason.split(':').last;
      }
    }
    return null;
  }

  /// 應用狀態效果結果
  void _applyStatusEffects(
    StatusEffectResult statusResult, {
    required bool isPlayer,
  }) {
    if (statusResult.dotDamage > 0) {
      if (isPlayer) {
        _applyPlayerDotDamage(statusResult.dotDamage);
      } else {
        final result = _battleService.enemyTakeDamage(
          state,
          statusResult.dotDamage,
        );
        state = result.newState;
      }
    }

    if (statusResult.hotHealing > 0) {
      if (isPlayer) {
        _applyPlayerHotHealing(statusResult.hotHealing);
      } else {
        final result = _battleService.enemyReceiveHealing(
          state,
          statusResult.hotHealing,
        );
        state = result.newState;
      }
    }
  }

  /// 清理戰鬥結束時的狀態效果
  void _cleanupBattleEndEffects() {
    _statusService.clearBattleEndEffects(state.playerStatusManager);
    _statusService.clearBattleEndEffects(state.enemyStatusManager);
  }

  /// 應用玩家 DOT 傷害
  void _applyPlayerDotDamage(int damage) {
    // TODO: 與 PartyProvider 整合
    print('玩家受到 $damage 點 DOT 傷害');
  }

  /// 應用玩家 HOT 治療
  void _applyPlayerHotHealing(int healing) {
    // TODO: 與 PartyProvider 整合
    print('玩家回復 $healing 點生命值');
  }

  /// 重置戰鬥狀態
  void resetBattle() {
    state = BattleState.initial();
  }

  // ===== 為了兼容性保留的舊方法 =====

  void damageEnemy(String enemyId, int damage) => playerAttackEnemy(damage);

  void selectEnemyActionToNullify(String actionId) {
    if (!_battleService.isPlayerTurn(state)) return;

    final action = state.enemyActionQueue
        .where((a) => a.id == actionId && a.isTargetable)
        .firstOrNull;

    if (action != null) {
      if (state.selectedEnemyAction?.id == actionId) {
        state = state.copyWith(selectedEnemyAction: null);
      } else {
        state = state.copyWith(selectedEnemyAction: action);
      }
    }
  }

  void selectEnemy(Enemy enemy) {
    if (state.enemy.id == enemy.id) {
      state = state.copyWith(selectedEnemy: enemy);
    }
  }

  void performBasicAttack(Enemy enemy) {
    if (state.enemy.id == enemy.id) {
      playerAttackEnemy(10);
    }
  }

  void playerUseSkill(
    String skillId, {
    String? targetEnemyActionId,
    String? casterId,
  }) {
    if (targetEnemyActionId != null) {
      final result = _battleService.playerUseSkill(
        state,
        skillId,
        targetEnemyActionId: targetEnemyActionId,
      );
      state = result.newState;
      if (_checkBattleEnd()) advanceBattlePhase();
    } else if (casterId != null) {
      executePlayerSkill(skillId, casterId: casterId);
    }
  }

  void useSkillOnEnemy(dynamic skill, Enemy enemy) {}

  void useSkillOnAlly(dynamic skill, Character? character) {}

  void useSkill(dynamic skill) {}

  void useItem(dynamic item) {}
}

/// 戰鬥配置類
class BattleConfiguration {
  final List<Character> playerParty;
  final Enemy enemy;
  final bool canEscape;

  const BattleConfiguration({
    required this.playerParty,
    required this.enemy,
    this.canEscape = true,
  });
}

/// 戰鬥 Provider 工廠
final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>((
  ref,
) {
  return BattleNotifier(
    battleService: BattleService(),
    enemyActionService: EnemyActionService(),
    statusService: StatusService(),
    enemyAIService: EnemyAIService(),
  );
});
