// lib/providers/battle_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/services/enemy_ai_service.dart';

import '../models/battle/battle_state.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../services/battle_service.dart';
import '../services/enemy_action_service.dart';
import '../services/status_service.dart';

/// 戰鬥狀態管理 Provider
///
/// 職責：
/// - 管理戰鬥狀態
/// - 協調各種戰鬥服務
/// - 提供 UI 所需的狀態更新
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

    // 使用第一個敵人 (因為現在設計是單敵人)
    final enemy = enemies.first;

    // 創建空的玩家隊伍 (需要與 PartyProvider 整合)
    const playerParty = <Character>[];

    initializeBattle(playerParty: playerParty, enemy: enemy, canEscape: true);
  }

  /// 對敵人造成傷害 (為了與現有代碼兼容)
  void damageEnemy(String enemyId, int damage) {
    if (!_battleService.isPlayerTurn(state)) return;
    if (state.enemy.id != enemyId) return;

    final result = _battleService.playerAttackEnemy(state, damage);
    state = result.newState;

    // 檢查戰鬥是否結束
    _checkBattleEnd();
  }

  /// 初始化戰鬥
  void initializeBattle({
    required List<Character> playerParty,
    required Enemy enemy,
    bool canEscape = true,
  }) {
    // 生成敵人行動隊列
    final actionQueue = _enemyAIService.generateActionQueue(
      enemy: enemy,
      playerParty: playerParty,
      turnNumber: 1,
    );

    // 根據敵人類型調整行動
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

    _startPlayerTurn();
  }

  /// 開始玩家回合
  void _startPlayerTurn() {
    if (!_battleService.canContinueBattle(state)) return;

    // 處理回合開始狀態效果
    final statusResult = _statusService.processTurnStart(
      state.playerStatusManager,
      isPlayer: true,
    );

    // 更新狀態並應用效果
    state = _battleService.startPlayerTurn(state);
    _applyStatusEffects(statusResult, isPlayer: true);

    // 檢查戰鬥是否結束
    _checkBattleEnd();
  }

  /// 結束玩家回合
  void endPlayerTurn() {
    if (!_battleService.isPlayerTurn(state)) return;

    // 處理回合結束狀態效果
    final statusResult = _statusService.processTurnEnd(
      state.playerStatusManager,
      isPlayer: true,
    );

    _applyStatusEffects(statusResult, isPlayer: true);

    // 檢查戰鬥是否結束
    if (_checkBattleEnd()) return;

    // 開始敵人回合
    _startEnemyTurn();
  }

  /// 開始敵人回合
  void _startEnemyTurn() {
    if (!_battleService.canContinueBattle(state)) return;

    // 處理敵人回合開始狀態效果
    final statusResult = _statusService.processTurnStart(
      state.enemyStatusManager,
      isPlayer: false,
    );

    // 更新狀態
    state = _battleService.startEnemyTurn(state);
    _applyStatusEffects(statusResult, isPlayer: false);

    // 檢查戰鬥是否結束
    if (_checkBattleEnd()) return;

    // 執行敵人行動序列
    _executeEnemyActions();
  }

  /// 玩家攻擊敵人
  void playerAttackEnemy(int damage) {
    if (!_battleService.isPlayerTurn(state)) return;

    final result = _battleService.playerAttackEnemy(state, damage);
    state = result.newState;

    // 檢查戰鬥是否結束
    _checkBattleEnd();
  }

  /// 玩家使用技能
  void playerUseSkill(String skillId, {String? targetEnemyActionId}) {
    if (!_battleService.isPlayerTurn(state)) return;

    final result = _battleService.playerUseSkill(
      state,
      skillId,
      targetEnemyActionId: targetEnemyActionId,
    );

    state = result.newState;
    _checkBattleEnd();
  }

  /// 玩家嘗試逃跑
  bool attemptEscape() {
    if (!state.canEscape || !_battleService.isPlayerTurn(state)) {
      return false;
    }

    final result = _battleService.attemptEscape(state);
    state = result.newState;

    return result.success;
  }

  /// 選擇要無效化的敵人行動
  void selectEnemyActionToNullify(String actionId) {
    if (!_battleService.isPlayerTurn(state)) return;

    final action = state.enemyActionQueue
        .where((a) => a.id == actionId && a.isTargetable)
        .firstOrNull;

    if (action != null) {
      // 如果已經選擇了相同的行動，則取消選擇
      if (state.selectedEnemyAction?.id == actionId) {
        state = state.copyWith(selectedEnemyAction: null);
      } else {
        state = state.copyWith(selectedEnemyAction: action);
      }
    }
  }

  /// 選擇敵人 (為了與現有代碼兼容)
  void selectEnemy(Enemy enemy) {
    if (state.enemy.id == enemy.id) {
      state = state.copyWith(selectedEnemy: enemy);
    }
  }

  /// 基本攻擊 (為了與現有代碼兼容)
  void performBasicAttack(Enemy enemy) {
    if (state.enemy.id == enemy.id) {
      // 使用默認傷害值
      playerAttackEnemy(10);
    }
  }

  /// 使用技能對敵人 (為了與現有代碼兼容)
  void useSkillOnEnemy(dynamic skill, Enemy enemy) {
    // 暫時空實現，需要與技能系統整合
  }

  /// 使用技能對友方 (為了與現有代碼兼容)
  void useSkillOnAlly(dynamic skill, Character? character) {
    // 暫時空實現，需要與技能系統整合
  }

  /// 使用技能 (為了與現有代碼兼容)
  void useSkill(dynamic skill) {
    // 暫時空實現，需要與技能系統整合
  }

  /// 使用道具 (為了與現有代碼兼容)
  void useItem(dynamic item) {
    // 暫時空實現，需要與道具系統整合
  }

  /// 執行敵人的先手攻擊
  void _executeEnemyFirstStrike() {
    final result = _battleService.executeEnemyFirstStrike(state);
    state = result.newState;
  }

  /// 執行敵人行動序列
  void _executeEnemyActions() {
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

    _endEnemyTurn();
  }

  /// 結束敵人回合
  void _endEnemyTurn() {
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

    // 準備下一輪
    state = _battleService.prepareNextTurn(state);
    state = state.copyWith(
      enemyActionQueue: enhancedActionQueue,
      selectedEnemyAction: null, // 清除選擇的行動
    );

    _startPlayerTurn();
  }

  /// 應用狀態效果結果
  void _applyStatusEffects(
    StatusEffectResult statusResult, {
    required bool isPlayer,
  }) {
    if (statusResult.dotDamage > 0) {
      if (isPlayer) {
        // 玩家受到 DOT 傷害 - 需要與隊伍系統整合
        _applyPlayerDotDamage(statusResult.dotDamage);
      } else {
        // 敵人受到 DOT 傷害
        final result = _battleService.enemyTakeDamage(
          state,
          statusResult.dotDamage,
        );
        state = result.newState;
      }
    }

    if (statusResult.hotHealing > 0) {
      if (isPlayer) {
        // 玩家受到 HOT 治療
        _applyPlayerHotHealing(statusResult.hotHealing);
      } else {
        // 敵人受到 HOT 治療
        final result = _battleService.enemyReceiveHealing(
          state,
          statusResult.hotHealing,
        );
        state = result.newState;
      }
    }
  }

  /// 檢查戰鬥是否結束
  bool _checkBattleEnd() {
    final battleEndResult = _battleService.checkBattleEnd(state);

    if (battleEndResult.isEnded) {
      state = _battleService.endBattle(state, battleEndResult.result);
      _cleanupBattleEndEffects();
      return true;
    }

    return false;
  }

  /// 清理戰鬥結束時的狀態效果
  void _cleanupBattleEndEffects() {
    _statusService.clearBattleEndEffects(state.playerStatusManager);
    _statusService.clearBattleEndEffects(state.enemyStatusManager);
  }

  /// 應用玩家 DOT 傷害
  void _applyPlayerDotDamage(int damage) {
    // TODO: 與 PartyProvider 整合
    // ref.read(partyProvider.notifier).takeDamage(damage);
  }

  /// 應用玩家 HOT 治療
  void _applyPlayerHotHealing(int healing) {
    // TODO: 與 PartyProvider 整合
    // ref.read(partyProvider.notifier).receiveHealing(healing);
  }

  /// 重置戰鬥狀態
  void resetBattle() {
    state = BattleState.initial();
  }
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
