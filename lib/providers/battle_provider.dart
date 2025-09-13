// lib/providers/battle_provider.dart
// 更新後的 BattleProvider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/providers/party_provider.dart';

// === 依賴注入 ===
import '../core/dependency_injection.dart';
// === 新的 Interface imports ===
import '../core/interfaces/i_battle_service.dart';
import '../core/interfaces/i_enemy_service.dart';
import '../core/interfaces/i_skill_service.dart';
import '../core/interfaces/i_status_service.dart';
// === Model imports ===
import '../models/battle/battle_state.dart';
import '../models/enemy/enemy.dart';
import '../models/party/party.dart';
import '../models/skill/skill_execution_result.dart';
import '../shared/beans/battle/battle_configuration.dart';
import '../shared/beans/skill/skill_execution_response.dart';
import 'battle_log_provider.dart';

// ================================
// BattleProvider 定義
// ================================

final battleProvider = StateNotifierProvider<BattleNotifier, BattleState?>((
  ref,
) {
  // 使用依賴注入獲取服務
  final battleSystemServices = ref.watch(battleSystemProvider);
  final partyNotifier = ref.watch(partyProvider.notifier);
  final logNotifier = ref.watch(battleLogProvider.notifier);

  return BattleNotifier(
    battleService: battleSystemServices.battleService,
    skillService: battleSystemServices.skillService,
    enemyService: battleSystemServices.enemyService,
    statusService: battleSystemServices.statusService,
    partyNotifier: partyNotifier,
    logNotifier: logNotifier,
  );
});

// ================================
// BattleNotifier 實現
// ================================
// 在 BattleNotifier 類中的狀態機實現

class BattleNotifier extends StateNotifier<BattleState?> {
  // === 服務依賴（使用接口） ===
  final IBattleService _battleService;
  final ISkillService _skillService;
  final IEnemyService _enemyService;
  final IStatusService _statusService;
  final dynamic _partyNotifier; // PartyNotifier 類型
  final BattleLogNotifier _logNotifier; // 戰鬥日誌記錄器

  BattleNotifier({
    required IBattleService battleService,
    required ISkillService skillService,
    required IEnemyService enemyService,
    required IStatusService statusService,
    required dynamic partyNotifier,
    required BattleLogNotifier logNotifier, // 新增日誌記錄器依賴
  }) : _battleService = battleService,
       _skillService = skillService,
       _enemyService = enemyService,
       _statusService = statusService,
       _partyNotifier = partyNotifier,
       _logNotifier = logNotifier,
       super(null);

  // ================================
  // 中央狀態機 - 核心流程控制
  // ================================

  /// 推進戰鬥階段 - 中央狀態機
  Future<void> advanceBattlePhase() async {
    if (state == null) {
      print('BattleProvider: 戰鬥未初始化，無法推進階段');
      return;
    }

    print('BattleProvider: 當前階段: ${state!.currentPhase}');

    // 首先檢查戰鬥是否應該結束
    if (_shouldEndBattle()) {
      await _handleBattleEnd();
      return;
    }

    // 基於當前階段執行對應邏輯
    switch (state!.currentPhase) {
      case BattlePhase.preparation:
        await _handlePreparationPhase();
        break;

      case BattlePhase.playerTurn:
        await _handlePlayerTurnPhase();
        break;

      case BattlePhase.enemyTurn:
        await _handleEnemyTurnPhase();
        break;

      case BattlePhase.battleEnd:
      case BattlePhase.victory:
      case BattlePhase.defeat:
        // 戰鬥已結束，不需要推進
        print('BattleProvider: 戰鬥已結束');
        break;
    }
  }

  // ================================
  // 階段處理方法 - 解耦的狀態處理
  // ================================

  /// 處理準備階段
  Future<void> _handlePreparationPhase() async {
    print('BattleProvider: 處理準備階段');

    try {
      // 執行戰鬥初始化後的設置
      final newState = _battleService.startPlayerTurn(state!);
      state = newState;

      print('BattleProvider: 準備完成，切換到玩家回合');

      // 自動推進到玩家回合處理
      await advanceBattlePhase();
    } catch (e) {
      print('BattleProvider: 準備階段處理失敗: $e');
    }
  }

  /// 處理玩家回合階段
  Future<void> _handlePlayerTurnPhase() async {
    print('BattleProvider: 處理玩家回合階段');

    // 玩家回合主要是等待玩家操作
    // 這裡可以處理回合開始時的效果
    try {
      // 處理玩家回合開始的狀態效果
      await _processPlayerTurnStartEffects();

      // 玩家回合不自動推進，等待玩家操作
      print('BattleProvider: 等待玩家操作...');
    } catch (e) {
      print('BattleProvider: 玩家回合處理失敗: $e');
    }
  }

  /// 處理敵人回合階段
  Future<void> _handleEnemyTurnPhase() async {
    print('BattleProvider: 處理敵人回合階段');

    try {
      // 1. 執行敵人回合
      await _executeEnemyTurn();

      // 2. 檢查戰鬥是否結束
      if (_shouldEndBattle()) {
        await advanceBattlePhase(); // 會觸發戰鬥結束處理
        return;
      }

      // 3. 準備下一回合
      await _prepareNextTurn();

      // 4. 切換到玩家回合
      await _transitionToPlayerTurn();
    } catch (e) {
      print('BattleProvider: 敵人回合處理失敗: $e');
      // 錯誤處理：強制切換到玩家回合
      await _transitionToPlayerTurn();
    }
  }

  // ================================
  // 公開 API - 外部觸發的操作
  // ================================

  /// 開始戰鬥
  Future<void> startBattle({
    required Party party,
    required Enemy enemy,
    bool canEscape = true,
  }) async {
    try {
      final config = BattleConfiguration(
        party: party,
        enemy: enemy,
        canEscape: canEscape,
      );

      final battleState = _battleService.initializeBattle(config);
      state = battleState;

      print('BattleProvider: 戰鬥初始化完成');
      _logNotifier.addBattleEvent('戰鬥初始化完成');

      // 啟動狀態機
      await advanceBattlePhase();
    } catch (e) {
      print('BattleProvider: 戰鬥開始失敗: $e');
      _logNotifier.addSystemMessage('戰鬥開始失敗: $e');
    }
  }

  /// 使用技能（帶詳細日誌記錄）
  Future<void> useSkill({
    required String skillId,
    required String casterId,
    List<String> targetIds = const [],
  }) async {
    if (state == null || !state!.isPlayerTurn) {
      print('BattleProvider: 不在玩家回合，無法使用技能');
      _logNotifier.addSystemMessage('不在玩家回合，無法使用技能');
      return;
    }

    try {
      // 獲取施法者和技能信息
      final caster = state!.party.characters
          .where((c) => c.id == casterId)
          .firstOrNull;
      final skill = _skillService.getSkill(skillId);

      if (caster == null) {
        _logNotifier.addSystemMessage('找不到施法者');
        return;
      }

      if (skill == null) {
        _logNotifier.addSystemMessage('技能不存在: $skillId');
        return;
      }

      // 檢查技能使用條件
      if (!_canUseSkill(skillId, casterId)) {
        print('BattleProvider: 無法使用技能 $skillId');
        _logNotifier.addPlayerAction(
          characterName: caster.name,
          skillName: skill.name,
          result: '技能使用失敗：cost不足',
        );
        return;
      }

      // 扣除 Cost
      final skillCost = _skillService.getSkillCost(skillId);
      _partyNotifier.useSkill(skillCost);

      // 執行技能
      final response = await _battleService.executePlayerSkillWithBeans(
        state!,
        skillId,
        casterId,
        targetIds: targetIds,
      );

      if (response.success) {
        // 應用技能效果並記錄詳細日誌
        final newState = _applySkillEffectsWithLogging(
          state!,
          response,
          caster.name,
          skill.name,
        );
        state = newState;

        print('BattleProvider: 技能執行成功: ${response.message}');
      } else {
        print('BattleProvider: 技能執行失敗: ${response.message}');
        _logNotifier.addPlayerAction(
          characterName: caster.name,
          skillName: skill.name,
          result: BattleLogHelper.formatSkillFailResult(response.message),
        );
      }
    } catch (e) {
      print('BattleProvider: 使用技能時發生錯誤: $e');
      _logNotifier.addSystemMessage('使用技能時發生錯誤: $e');
    }
  }

  /// 執行敵人回合（帶詳細日誌記錄）
  Future<void> _executeEnemyTurn() async {
    if (state == null) return;

    print('BattleProvider: 執行敵人回合');
    _logNotifier.addBattleEvent('${state!.enemy.name} 開始行動');

    try {
      // 使用敵人服務處理敵人回合
      final result = await _enemyService.processEnemyTurn(
        enemy: state!.enemy,
        playerParty: state!.party.characters,
        turnNumber: state!.turnNumber,
        nullifiedAction: state!.selectedEnemyAction,
      );

      // 應用敵人行動結果並記錄日誌
      if (result.actionSuccess) {
        var newState = result.newState;

        // 記錄敵人造成的傷害
        if (result.totalDamageDealt != null && result.totalDamageDealt! > 0) {
          _partyNotifier.takeDamage(result.totalDamageDealt);

          _logNotifier.addEnemyAction(
            enemyName: state!.enemy.name,
            actionName: '攻擊',
            result: BattleLogHelper.formatDamageResult(
              result.totalDamageDealt!,
              '玩家隊伍',
            ),
          );

          print('BattleProvider: 敵人對玩家造成 ${result.totalDamageDealt} 點傷害');
        }

        // 記錄敵人的治療
        if (result.totalHealingReceived != null &&
            result.totalHealingReceived! > 0) {
          final healedEnemy = state!.enemy.heal(result.totalHealingReceived!);
          newState = newState.copyWith(enemy: healedEnemy);

          _logNotifier.addEnemyAction(
            enemyName: state!.enemy.name,
            actionName: '治療',
            result: BattleLogHelper.formatHealResult(
              result.totalHealingReceived!,
              state!.enemy.name,
            ),
          );

          print('BattleProvider: 敵人恢復了 ${result.totalHealingReceived} 點生命值');
        }

        // 記錄狀態效果
        if ((result.statusEffectsApplied ?? []).isNotEmpty) {
          for (final effect in result.statusEffectsApplied!) {
            _logNotifier.addStatusEffect(
              effectName: effect,
              result: BattleLogHelper.formatBuffResult(effect, '玩家隊伍'),
              isPositive: false, // 敵人施加的效果通常是負面的
            );
          }
          print('BattleProvider: 敵人施加了狀態效果: ${result.statusEffectsApplied}');
        }

        // 記錄具體的敵人行動
        if (result.actionResults != null) {
          for (final actionResult in result.actionResults!) {
            if (actionResult.wasExecuted) {
              _logNotifier.addEnemyAction(
                enemyName: state!.enemy.name,
                actionName: actionResult.message ?? '未知行動',
                result: actionResult.message,
              );
            }
          }
        }

        state = newState;
        print('BattleProvider: 敵人回合執行完成: ${result.message}');
        _logNotifier.addBattleEvent('${state!.enemy.name} 行動完成');
      } else {
        print('BattleProvider: 敵人回合執行失敗: ${result.message}');
        _logNotifier.addSystemMessage('敵人回合執行失敗: ${result.message}');
      }

      // 延遲讓玩家看到敵人行動
      await Future.delayed(const Duration(milliseconds: 1500));
    } catch (e) {
      print('BattleProvider: 敵人回合執行失敗: $e');
      _logNotifier.addSystemMessage('敵人回合執行失敗: $e');
      // 執行基本攻擊作為後備
      await _executeBasicEnemyAttack();
    }
  }

  /// 處理玩家回合開始效果（帶狀態效果日誌）
  Future<void> _processPlayerTurnStartEffects() async {
    print('BattleProvider: 處理玩家回合開始效果');

    // 這裡可以處理DOT/HOT等狀態效果
    // 示例：處理毒素傷害
    await _processStatusEffects(isPlayerTurn: true, isStartOfTurn: true);
  }

  /// 處理玩家回合結束效果（帶狀態效果日誌）
  Future<void> _processPlayerTurnEndEffects() async {
    print('BattleProvider: 處理玩家回合結束效果');

    // 處理回合結束時的狀態效果
    await _processStatusEffects(isPlayerTurn: true, isStartOfTurn: false);
  }

  /// 處理狀態效果（DOT/HOT等）
  Future<void> _processStatusEffects({
    required bool isPlayerTurn,
    required bool isStartOfTurn,
  }) async {
    // 示例：模擬DOT/HOT效果
    // 在實際實現中，這裡會調用 StatusService

    // 模擬玩家的DOT傷害
    if (isPlayerTurn && isStartOfTurn) {
      // 假設玩家有中毒效果
      const dotDamage = 5;
      if (dotDamage > 0) {
        _partyNotifier.takeDamage(dotDamage);
        _logNotifier.addStatusEffect(
          effectName: '中毒',
          result: BattleLogHelper.formatDotResult(dotDamage, '玩家隊伍'),
          isPositive: false,
        );
      }
    }

    // 模擬敵人的DOT傷害
    if (!isPlayerTurn && isStartOfTurn && state != null) {
      // 假設敵人有燃燒效果
      const dotDamage = 8;
      if (dotDamage > 0) {
        final newEnemy = state!.enemy.takeDamage(dotDamage);
        state = state!.copyWith(enemy: newEnemy);

        _logNotifier.addStatusEffect(
          effectName: '燃燒',
          result: BattleLogHelper.formatDotResult(dotDamage, state!.enemy.name),
          isPositive: false,
        );
      }
    }

    // 模擬HOT治療效果
    if (isStartOfTurn) {
      const hotHealing = 3;
      if (hotHealing > 0) {
        _partyNotifier.heal(hotHealing);
        _logNotifier.addStatusEffect(
          effectName: '再生',
          result: BattleLogHelper.formatHotResult(hotHealing, '玩家隊伍'),
          isPositive: true,
        );
      }
    }
  }

  /// 應用技能效果並記錄詳細日誌
  BattleState _applySkillEffectsWithLogging(
    BattleState currentState,
    SkillExecutionResponse response,
    String casterName,
    String skillName,
  ) {
    var newState = currentState;
    var totalDamage = 0;
    var totalHealing = 0;
    final statusEffects = <String>[];

    for (final effectChain in response.effectChains) {
      if (effectChain.targetId == currentState.enemy.id) {
        // 對敵人的效果
        if (effectChain.processedResult.type == EffectType.damage) {
          final damage = effectChain.processedResult.actualValue;
          totalDamage += damage;
          final newEnemy = currentState.enemy.takeDamage(damage);
          newState = newState.copyWith(enemy: newEnemy);
        }
      } else if (effectChain.targetId == 'party') {
        // 對隊伍的效果
        if (effectChain.processedResult.type == EffectType.heal) {
          final healing = effectChain.processedResult.actualValue;
          totalHealing += healing;
          _partyNotifier.heal(healing);
        }
      }

      // 記錄狀態效果
      if (effectChain.processedResult.type == EffectType.statusEffect) {
        final statusId =
            effectChain.originalIntent.metadata['statusId'] as String? ??
            '未知效果';
        statusEffects.add(statusId);
      }
    }

    // 記錄技能使用的完整結果
    final results = <String>[];

    if (totalDamage > 0) {
      results.add(
        BattleLogHelper.formatDamageResult(
          totalDamage,
          currentState.enemy.name,
        ),
      );
    }

    if (totalHealing > 0) {
      results.add(BattleLogHelper.formatHealResult(totalHealing, '玩家隊伍'));
    }

    for (final effect in statusEffects) {
      results.add(
        BattleLogHelper.formatBuffResult(effect, currentState.enemy.name),
      );
    }

    final resultText = results.isNotEmpty ? results.join(', ') : '無效果';

    _logNotifier.addPlayerAction(
      characterName: casterName,
      skillName: skillName,
      result: resultText,
    );

    return newState;
  }

  /// 基本敵人攻擊（錯誤後備，帶日誌）
  Future<void> _executeBasicEnemyAttack() async {
    if (state == null) return;

    print('BattleProvider: 執行基本敵人攻擊（錯誤後備）');

    try {
      final baseDamage = state!.enemy.attack;
      final actualDamage = (baseDamage * 0.8).round();

      _partyNotifier.takeDamage(actualDamage);

      _logNotifier.addEnemyAction(
        enemyName: state!.enemy.name,
        actionName: '基本攻擊',
        result: BattleLogHelper.formatDamageResult(actualDamage, '玩家隊伍'),
      );

      print('BattleProvider: 敵人造成 $actualDamage 點傷害（基本攻擊）');

      await Future.delayed(const Duration(milliseconds: 1000));
    } catch (e) {
      print('BattleProvider: 基本敵人攻擊失敗: $e');
      _logNotifier.addSystemMessage('基本敵人攻擊失敗: $e');
    }
  }

  /// 處理戰鬥結束（帶日誌）
  Future<void> _handleBattleEnd() async {
    print('BattleProvider: 處理戰鬥結束');

    try {
      final battleEnd = _battleService.checkBattleEnd(state!);
      final endState = _battleService.endBattle(state!, battleEnd.resultType);
      state = endState;

      // 記錄戰鬥結束日誌
      _logNotifier.addBattleEvent(
        BattleLogHelper.formatBattleEndResult(battleEnd.resultType),
      );

      print('BattleProvider: 戰鬥結束 - ${battleEnd.resultType}');
    } catch (e) {
      print('BattleProvider: 戰鬥結束處理失敗: $e');
      _logNotifier.addSystemMessage('戰鬥結束處理失敗: $e');
    }
  }

  /// 切換到敵人回合（帶日誌）
  Future<void> _transitionToEnemyTurn() async {
    print('BattleProvider: 切換到敵人回合');
    _logNotifier.addBattleEvent('敵人回合開始');

    final newState = _battleService.startEnemyTurn(state!);
    state = newState;

    // 處理敵人回合開始的狀態效果
    await _processStatusEffects(isPlayerTurn: false, isStartOfTurn: true);

    // 自動推進到敵人回合處理
    await advanceBattlePhase();
  }

  /// 切換到玩家回合（帶日誌）
  Future<void> _transitionToPlayerTurn() async {
    print('BattleProvider: 切換到玩家回合');
    _logNotifier.addBattleEvent('玩家回合開始');

    final newState = _battleService.startPlayerTurn(state!);
    state = newState;

    // 恢復玩家 Cost
    _partyNotifier.startNewTurn();

    // 自動推進到玩家回合處理
    await advanceBattlePhase();
  }

  /// 結束玩家回合（玩家操作）
  Future<void> endPlayerTurn() async {
    if (state == null || !state!.isPlayerTurn) {
      print('BattleProvider: 不在玩家回合，無法結束回合');
      return;
    }

    print('BattleProvider: 玩家結束回合');

    // 處理玩家回合結束效果
    await _processPlayerTurnEndEffects();

    // 切換到敵人回合
    await _transitionToEnemyTurn();
  }

  // ================================
  // 輔助方法 - 具體的業務邏輯
  // ================================

  /// 檢查戰鬥是否應該結束
  bool _shouldEndBattle() {
    if (state == null) return true;

    final battleEnd = _battleService.checkBattleEnd(state!);
    return battleEnd.isEnded || _isPlayerDefeated();
  }

  /// 檢查玩家是否被擊敗
  bool _isPlayerDefeated() {
    return _partyNotifier.isDefeated;
  }

  /// 檢查是否可以使用技能
  bool _canUseSkill(String skillId, String casterId) {
    if (state == null) return false;

    final caster = state!.party.characters
        .where((c) => c.id == casterId)
        .firstOrNull;

    if (caster == null) return false;

    return _skillService.canUseSkill(
      skillId: skillId,
      caster: caster,
      currentCost: state!.party.currentTurnCost,
    );
  }

  /// 準備下一回合
  Future<void> _prepareNextTurn() async {
    if (state == null) return;

    print('BattleProvider: 準備下一回合');

    try {
      final newState = _battleService.prepareNextTurn(state!);
      state = newState;

      print('BattleProvider: 第 ${state!.turnNumber} 回合準備完成');
    } catch (e) {
      print('BattleProvider: 準備下一回合失敗: $e');
    }
  }

  /// 應用技能效果到戰鬥狀態
  BattleState _applySkillEffects(
    BattleState currentState,
    SkillExecutionResponse response,
  ) {
    var newState = currentState;

    for (final effectChain in response.effectChains) {
      if (effectChain.targetId == currentState.enemy.id) {
        if (effectChain.processedResult.type == EffectType.damage) {
          final damage = effectChain.processedResult.actualValue;
          final newEnemy = currentState.enemy.takeDamage(damage);
          newState = newState.copyWith(enemy: newEnemy);
        }
      } else if (effectChain.targetId == 'party') {
        if (effectChain.processedResult.type == EffectType.heal) {
          final healing = effectChain.processedResult.actualValue;
          _partyNotifier.heal(healing);
        }
      }
    }

    return newState;
  }

  // ================================
  // 便利方法 - 狀態查詢
  // ================================

  /// 選擇要無效化的敵人行動
  void selectEnemyActionToNullify(String actionId) {
    if (state == null) return;

    final newState = _battleService.selectEnemyActionToNullify(
      state!,
      actionId,
    );
    state = newState;
  }

  /// 結束戰鬥
  void endBattle(String result) {
    if (state == null) return;

    final newState = _battleService.endBattle(state!, result);
    state = newState;
  }
}
// ================================
// 便利 Provider
// ================================

/// 當前戰鬥狀態 Provider
final currentBattleStateProvider = Provider<BattleState?>((ref) {
  return ref.watch(battleProvider);
});

/// 戰鬥是否進行中 Provider
final isBattleActiveProvider = Provider<bool>((ref) {
  final battleState = ref.watch(battleProvider);
  return battleState != null && battleState.isBattleOngoing;
});

/// 是否為玩家回合 Provider
final isPlayerTurnProvider = Provider<bool>((ref) {
  final battleState = ref.watch(battleProvider);
  if (battleState == null) return false;

  final battleService = ref.watch(battleServiceProvider);
  return battleService.isPlayerTurn(battleState);
});
