// lib/core/interfaces/i_battle_service.dart
import '../../models/battle/battle_state.dart';
import '../../models/enemy/enemy_action.dart';
import '../../models/skill/skill_execution_result.dart';
import '../../shared/beans/battle/battle_action_result.dart';
import '../../shared/beans/battle/battle_configuration.dart';
import '../../shared/beans/battle/battle_end_result.dart';
import '../../shared/beans/skill/skill_execution_response.dart';

/// 戰鬥服務接口
///
/// 定義戰鬥系統的核心業務規則和操作
abstract class IBattleService {
  // ================================
  // 戰鬥生命週期管理
  // ================================

  /// 初始化戰鬥
  BattleState initializeBattle(BattleConfiguration config);

  /// 開始玩家回合
  BattleState startPlayerTurn(BattleState state);

  /// 開始敵人回合
  BattleState startEnemyTurn(BattleState state);

  /// 結束戰鬥
  BattleState endBattle(BattleState state, String result);

  /// 檢查戰鬥是否結束
  BattleEndResult checkBattleEnd(BattleState state);

  /// 檢查戰鬥是否可以繼續
  bool canContinueBattle(BattleState state);

  /// 檢查是否為玩家回合
  bool isPlayerTurn(BattleState state);

  // ================================
  // 玩家行動
  // ================================

  /// 玩家攻擊敵人
  BattleActionResult playerAttackEnemy(BattleState state, int damage);

  /// 玩家使用技能（舊接口，保留相容性）
  BattleActionResult playerUseSkill(
    BattleState state,
    String skillId, {
    String? targetEnemyActionId,
  });

  /// 執行玩家技能（舊接口，保留相容性）
  SkillExecutionResult executePlayerSkill(
    BattleState state,
    String skillId,
    String casterId,
  );

  /// 執行玩家技能（新 Bean 接口）
  Future<SkillExecutionResponse> executePlayerSkillWithBeans(
    BattleState state,
    String skillId,
    String casterId, {
    List<String> targetIds = const [],
  });

  /// 應用技能執行結果（舊接口）
  BattleState applySkillExecutionResult(
    BattleState state,
    SkillExecutionResult result,
  );

  /// 嘗試逃跑
  BattleActionResult attemptEscape(BattleState state);

  // ================================
  // 敵人行動
  // ================================

  /// 敵人受到傷害
  BattleActionResult enemyTakeDamage(BattleState state, int damage);

  /// 敵人接受治療
  BattleActionResult enemyReceiveHealing(BattleState state, int healing);

  /// 執行敵人先手攻擊
  BattleActionResult executeEnemyFirstStrike(BattleState state);

  /// 應用敵人行動結果
  BattleState applyEnemyActionResult(
    BattleState state,
    EnemyActionResult actionResult,
  );

  // ================================
  // 戰術操作
  // ================================

  /// 選擇要無效化的敵人行動
  BattleState selectEnemyActionToNullify(BattleState state, String actionId);

  /// 準備下一回合
  BattleState prepareNextTurn(BattleState state);
}
