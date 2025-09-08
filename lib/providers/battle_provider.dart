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
// === Bean imports ===
import '../shared/beans/skill/skill_execution_request.dart';
import '../shared/beans/skill/skill_execution_response.dart';

// ================================
// BattleProvider 定義
// ================================

final battleProvider = StateNotifierProvider<BattleNotifier, BattleState?>((
  ref,
) {
  // 使用依賴注入獲取服務
  final battleSystemServices = ref.watch(battleSystemProvider);
  final partyNotifier = ref.watch(partyProvider.notifier);

  return BattleNotifier(
    battleService: battleSystemServices.battleService,
    skillService: battleSystemServices.skillService,
    enemyService: battleSystemServices.enemyService,
    statusService: battleSystemServices.statusService,
    partyNotifier: partyNotifier,
  );
});

// ================================
// BattleNotifier 實現
// ================================

class BattleNotifier extends StateNotifier<BattleState?> {
  // === 服務依賴（使用接口） ===
  final IBattleService _battleService;
  final ISkillService _skillService;
  final IEnemyService _enemyService;
  final IStatusService _statusService;
  final dynamic _partyNotifier; // PartyNotifier 類型

  BattleNotifier({
    required IBattleService battleService,
    required ISkillService skillService,
    required IEnemyService enemyService,
    required IStatusService statusService,
    required dynamic partyNotifier,
  }) : _battleService = battleService,
       _skillService = skillService,
       _enemyService = enemyService,
       _statusService = statusService,
       _partyNotifier = partyNotifier,
       super(null);

  // ================================
  // 公開方法
  // ================================

  /// 開始戰鬥
  Future<void> startBattle({
    required Party party,
    required Enemy enemy,
    bool canEscape = true,
  }) async {
    try {
      // 使用 Bean 配置
      final config = BattleConfiguration(
        party: party,
        enemy: enemy,
        canEscape: canEscape,
      );

      // 使用服務初始化戰鬥
      final battleState = _battleService.initializeBattle(config);
      state = battleState;

      print('戰鬥開始: ${enemy.name} vs ${party.characters.length}人隊伍');
    } catch (e) {
      print('戰鬥開始失敗: $e');
      // 可以在這裡處理錯誤，比如顯示錯誤訊息
    }
  }

  /// 使用技能（新的 Bean 接口）
  Future<void> useSkill({
    required String skillId,
    required String casterId,
    List<String> targetIds = const [],
  }) async {
    if (state == null) return;

    try {
      // 檢查是否可以使用技能
      final caster = state!.party.characters.firstWhere(
        (c) => c.id == casterId,
      );
      final canUse = _skillService.canUseSkill(
        skillId: skillId,
        caster: caster,
        currentCost: state!.party.currentTurnCost,
      );

      if (!canUse) {
        print('無法使用技能 $skillId: cost不足');
        return;
      }

      // 扣除 cost（通過 PartyProvider）
      final skillCost = _skillService.getSkillCost(skillId);
      _partyNotifier.useSkill(skillCost);

      // 建立技能執行請求 Bean
      final request = SkillExecutionRequest(
        skillId: skillId,
        casterId: casterId,
        allies: state!.party.characters,
        enemies: [state!.enemy],
        targetIds: targetIds,
        context: {'battleState': state},
      );

      // 執行技能
      final response = await _skillService.executeSkill(request);

      if (response.success) {
        // 應用技能效果到戰鬥狀態
        final newState = _applySkillEffects(state!, response);
        state = newState;

        print('技能執行成功: ${response.message}');
      } else {
        print('技能執行失敗: ${response.message}');
      }
    } catch (e) {
      print('使用技能時發生錯誤: $e');
    }
  }

  /// 結束玩家回合
  void endPlayerTurn() {
    if (state == null) return;

    // 開始敵人回合
    final newState = _battleService.startEnemyTurn(state!);
    state = newState;

    // 執行敵人行動（可以異步執行）
    _executeEnemyTurn();
  }

  /// 結束戰鬥
  void endBattle(String result) {
    if (state == null) return;

    final newState = _battleService.endBattle(state!, result);
    state = newState;
  }

  // ================================
  // 私有方法
  // ================================

  /// 應用技能效果到戰鬥狀態
  BattleState _applySkillEffects(
    BattleState currentState,
    SkillExecutionResponse response,
  ) {
    var newState = currentState;

    for (final effectChain in response.effectChains) {
      // 處理對敵人的效果
      if (effectChain.targetId == currentState.enemy.id) {
        if (effectChain.processedResult.type == EffectType.damage) {
          final damage = effectChain.processedResult.actualValue;
          final newEnemy = currentState.enemy.takeDamage(damage);
          newState = newState.copyWith(enemy: newEnemy);
        }
      }

      // 處理對隊伍的效果
      if (effectChain.targetId == 'party') {
        if (effectChain.processedResult.type == EffectType.heal) {
          final healing = effectChain.processedResult.actualValue;
          _partyNotifier.heal(healing);
        }
      }

      // 處理狀態效果
      if (effectChain.processedResult.type == EffectType.statusEffect) {
        // 這裡可以調用 StatusService 來應用狀態效果
        // await _statusService.applyStatusEffect(...)
      }
    }

    return newState;
  }

  /// 執行敵人回合
  Future<void> _executeEnemyTurn() async {
    // 這裡實現敵人回合邏輯
    // 可以使用 _enemyService 來處理敵人行動
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
