// lib/providers/battle_provider.dart (狀態機重構版)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/providers/party_provider.dart';
import 'package:rouge_project/services/enemy_ai_service.dart';

import '../models/battle/battle_state.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/skill/skill_execution_result.dart';
import '../models/status/status_effect.dart';
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
  final Ref ref; // 添加 ref 字段

  BattleNotifier({
    required BattleService battleService,
    required EnemyActionService enemyActionService,
    required StatusService statusService,
    required EnemyAIService enemyAIService,
    required this.ref, // 添加 ref 參數
  }) : _battleService = battleService,
       _enemyActionService = enemyActionService,
       _statusService = statusService,
       _enemyAIService = enemyAIService,
       super(BattleState.initial());

  /// 開始戰鬥 (為了與現有代碼兼容)
  void startBattle(List<Enemy> enemies) {
    if (enemies.isEmpty) return;

    final enemy = enemies.first;

    // 從 PartyProvider 獲取玩家隊伍，而不是使用空隊伍
    final party = ref.read(partyProvider);
    final playerParty = party.characters;

    print('BattleProvider: 開始戰鬥，玩家隊伍角色數: ${playerParty.length}');
    for (final character in playerParty) {
      print(
        'BattleProvider: 隊伍角色 - ID: ${character.id}, 名稱: ${character.name}',
      );
    }

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

  /// 玩家使用技能 - UI 調用
  Future<SkillExecutionResult> executePlayerSkill(
    String skillId, {
    required String casterId,
  }) async {
    print('BattleProvider: 接收到技能使用請求 - 技能: $skillId, 施法者: $casterId');

    if (!_battleService.isPlayerTurn(state)) {
      print('BattleProvider: 當前不是玩家回合，拒絕技能使用');
      return SkillExecutionResult(
        skillId: skillId,
        casterId: casterId,
        effectChains: [],
        success: false,
        message: '不是玩家回合',
      );
    }

    // 執行技能邏輯
    print('BattleProvider: 調用 BattleService.executePlayerSkill');
    final result = _battleService.executePlayerSkill(state, skillId, casterId);
    print(
      'BattleProvider: BattleService 返回結果 - 成功: ${result.success}, 效果鏈數量: ${result.effectChains.length}',
    );

    if (result.success) {
      // 應用技能效果到遊戲狀態
      print('BattleProvider: 開始應用技能效果到遊戲狀態');
      await _applySkillExecutionResult(result);
      print('BattleProvider: 技能效果應用完成');

      // 更新統計數據
      _updateSkillStatistics(result);

      // 使用技能後檢查戰鬥是否結束
      if (_checkBattleEnd()) {
        print('BattleProvider: 技能使用後戰鬥結束');
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

  /// 執行敵人行動序列
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
      // 先應用到戰鬥狀態
      state = _battleService.applyEnemyActionResult(state, actionResult);

      // 如果行動造成傷害，應用到玩家隊伍
      if (actionResult.wasExecuted && actionResult.damageDealt > 0) {
        final partyNotifier = ref.read(partyProvider.notifier);
        partyNotifier.takeDamage(actionResult.damageDealt);
        print(
          '${state.enemy.name} 造成 ${actionResult.damageDealt} 傷害，玩家血量: ${ref.read(partyProvider).sharedHp}',
        );
      } else if (actionResult.wasExecuted) {
        // 沒有傷害的行動訊息
        print('敵人行動: ${actionResult.message}');
      }

      // 檢查每個行動後是否戰鬥結束
      if (_checkBattleEnd()) return;
    }
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

  // 設置戰鬥階段並自動處理階段邏輯
  void _setPhase(BattlePhase newPhase) {
    if (state.currentPhase == newPhase) return; // 避免重複設置

    final oldPhase = state.currentPhase;
    state = state.copyWith(currentPhase: newPhase);

    print('戰鬥階段變更: $oldPhase -> $newPhase');

    // 根據新階段執行對應邏輯
    _handlePhaseTransition(newPhase);
  }

  /// 處理階段轉換邏輯
  void _handlePhaseTransition(BattlePhase phase) {
    // 統一在這裡檢查戰鬥是否結束
    if (_checkBattleEnd()) {
      _setPhase(BattlePhase.battleEnd);
      _handleBattleEnd();
      return;
    }

    switch (phase) {
      case BattlePhase.playerTurn:
        _executePlayerTurnStart();
        break;

      case BattlePhase.enemyTurn:
        _executeEnemyTurnStart();
        _executeEnemyActions();
        _completeEnemyTurn();
        break;

      case BattlePhase.battleEnd:
        _handleBattleEnd();
        break;

      case BattlePhase.preparation:
      case BattlePhase.victory:
      case BattlePhase.defeat:
        // 這些階段不需要額外處理
        break;
    }
  }

  /// 移除原本的 advanceBattlePhase，改用直接的階段轉換
  void endPlayerTurn() {
    print('戰鬥階段: 玩家回合結束');
    if (!_battleService.isPlayerTurn(state)) return;

    _executePlayerTurnEnd();
    _setPhase(BattlePhase.enemyTurn); // 直接設置階段，讓 _handlePhaseTransition 處理
  }

  /// 完成敵人回合
  void _completeEnemyTurn() {
    print('戰鬥階段: 敵人回合結束');

    _processStatusEffects(isPlayer: false, timing: StatusTiming.turnEnd);

    if (_checkBattleEnd()) return; // 只在必要時檢查

    _prepareNextTurn();
    _setPhase(BattlePhase.playerTurn);
  }

  /// 檢查戰鬥是否結束 - 統一入口點
  bool _checkBattleEnd() {
    final party = ref.read(partyProvider);

    if (party.sharedHp <= 0) {
      print('檢測到玩家血量為0，戰鬥結束');
      state = state.copyWith(
        currentPhase: BattlePhase.battleEnd,
        result: BattleResult.defeat,
      );
      return true;
    }

    if (state.enemy.isDead) {
      print('檢測到敵人死亡，戰鬥結束');
      state = state.copyWith(
        currentPhase: BattlePhase.battleEnd,
        result: BattleResult.victory,
      );
      return true;
    }

    if (state.result == BattleResult.escaped) {
      print('檢測到玩家逃跑，戰鬥結束');
      state = state.copyWith(currentPhase: BattlePhase.battleEnd);
      return true;
    }

    return false;
  }

  /// 統一的狀態效果處理方法
  void _processStatusEffects({
    required bool isPlayer,
    required StatusTiming timing,
  }) {
    final statusManager = isPlayer
        ? state.playerStatusManager
        : state.enemyStatusManager;

    final statusResult = timing == StatusTiming.turnStart
        ? _statusService.processTurnStart(statusManager, isPlayer: isPlayer)
        : _statusService.processTurnEnd(statusManager, isPlayer: isPlayer);

    _applyStatusEffects(statusResult, isPlayer: isPlayer);
    _updateStatusManager(isPlayer: isPlayer, statusManager: statusManager);
  }

  /// 更新狀態管理器
  void _updateStatusManager({
    required bool isPlayer,
    required StatusEffectManager statusManager,
  }) {
    if (isPlayer) {
      state = state.copyWith(playerStatusManager: statusManager);
    } else {
      state = state.copyWith(enemyStatusManager: statusManager);
    }
  }

  /// 更新敵人狀態
  void _updateEnemyState(Enemy newEnemy) {
    state = state.copyWith(enemy: newEnemy);
  }

  /// 重構後的執行方法
  void _executePlayerTurnStart() {
    print('戰鬥階段: 玩家回合開始');

    // 恢復玩家 Cost
    final partyNotifier = ref.read(partyProvider.notifier);
    partyNotifier.startNewTurn();
    print('BattleProvider: 玩家回合開始，恢復 Cost');

    // 處理回合開始狀態效果
    _processStatusEffects(isPlayer: true, timing: StatusTiming.turnStart);
  }

  void _executePlayerTurnEnd() {
    print('戰鬥階段: 玩家回合結束處理');
    _processStatusEffects(isPlayer: true, timing: StatusTiming.turnEnd);
  }

  void _executeEnemyTurnStart() {
    print('戰鬥階段: 敵人回合開始');
    _processStatusEffects(isPlayer: false, timing: StatusTiming.turnStart);
  }

  /// 準備下一回合
  void _prepareNextTurn() {
    final newActionQueue = _enemyAIService.generateActionQueue(
      enemy: state.enemy,
      playerParty: state.playerParty,
      turnNumber: state.turnNumber + 1,
    );

    final enhancedActionQueue = _enemyAIService.adjustActionsByEnemyType(
      newActionQueue,
      state.enemy,
    );

    state = state.copyWith(
      turnNumber: state.turnNumber + 1,
      enemyActionQueue: enhancedActionQueue,
      selectedEnemyAction: null,
    );
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
    print(
      'BattleProvider: 對敵人應用效果 - 類型: ${effectResult.type}, 數值: ${effectResult.actualValue}',
    );

    switch (effectResult.type) {
      case EffectType.damage:
        final oldHp = state.enemy.currentHp;
        final newEnemy = state.enemy.takeDamage(effectResult.actualValue);
        state = state.copyWith(enemy: newEnemy);

        print('BattleProvider: 敵人受到傷害 - 血量: $oldHp -> ${newEnemy.currentHp}');

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
          print('BattleProvider: 對敵人施加狀態效果: $statusId');
          await _applyStatusEffectToEnemy(statusId);
        }
        break;

      default:
        print('BattleProvider: 未處理的敵人效果類型: ${effectResult.type}');
        break;
    }
  }

  /// 對隊伍應用效果
  Future<void> _applyEffectToParty(EffectResult effectResult) async {
    print(
      'BattleProvider: 對隊伍應用效果 - 類型: ${effectResult.type}, 數值: ${effectResult.actualValue}',
    );

    switch (effectResult.type) {
      case EffectType.heal:
        print('BattleProvider: 隊伍回復生命值: ${effectResult.actualValue}');
        _applyPlayerHotHealing(effectResult.actualValue);
        break;

      case EffectType.damage:
        print('BattleProvider: 隊伍受到傷害: ${effectResult.actualValue}');
        _applyPlayerDotDamage(effectResult.actualValue);
        break;

      case EffectType.statusEffect:
        final statusId = _extractStatusIdFromReasons(
          effectResult.modificationReasons,
        );
        if (statusId != null) {
          print('BattleProvider: 對隊伍施加狀態效果: $statusId');
          await _applyStatusEffectToPlayer(statusId);
        }
        break;

      default:
        print('BattleProvider: 未處理的隊伍效果類型: ${effectResult.type}');
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
    final target = isPlayer ? "玩家" : "敵人";

    // 處理DOT傷害
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
      print('⚡ $target 受到 ${statusResult.dotDamage} 點DOT傷害');
    }

    // 處理HOT治療
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
      print('💚 $target 回復 ${statusResult.hotHealing} 點HOT生命值');
    }

    // 顯示觸發的狀態效果
    if (statusResult.triggeredEffects.isNotEmpty) {
      print('🔥 觸發狀態效果: ${statusResult.triggeredEffects.join(", ")}');
    } else if (statusResult.dotDamage == 0 && statusResult.hotHealing == 0) {
      print('📝 狀態效果處理完成，無DOT/HOT觸發');
    }
  }

  /// 清理戰鬥結束時的狀態效果
  void _cleanupBattleEndEffects() {
    _statusService.clearBattleEndEffects(state.playerStatusManager);
    _statusService.clearBattleEndEffects(state.enemyStatusManager);
  }

  /// 應用玩家 DOT 傷害
  void _applyPlayerDotDamage(int damage) {
    final partyNotifier = ref.read(partyProvider.notifier);
    partyNotifier.takeDamage(damage);
    print('玩家受到 $damage 點 DOT 傷害，當前血量: ${ref.read(partyProvider).sharedHp}');
  }

  /// 應用玩家 HOT 治療
  void _applyPlayerHotHealing(int healing) {
    final partyNotifier = ref.read(partyProvider.notifier);
    partyNotifier.heal(healing);
    print('玩家回復 $healing 點生命值，當前血量: ${ref.read(partyProvider).sharedHp}');
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

/// 狀態效果觸發時機
enum StatusTiming { turnStart, turnEnd }

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
    ref: ref, // 傳入 ref
  );
});
