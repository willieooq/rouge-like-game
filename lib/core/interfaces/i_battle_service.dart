// lib/core/interfaces/i_battle_service.dart
import '../../models/battle/battle_state.dart';
import '../../models/enemy/enemy_action.dart';
import '../../models/skill/skill_execution_result.dart';
import '../../shared/beans/battle/battle_action_result.dart';
import '../../shared/beans/battle/battle_configuration.dart';
import '../../shared/beans/battle/battle_end_result.dart';

/// 戰鬥服務介面
///
/// 定義所有戰鬥相關的核心業務操作
/// 遵循 Interface Segregation Principle
/// 所有方法都是無狀態的純函數
abstract class IBattleService {
  // ===== 戰鬥生命週期管理 =====

  /// 初始化戰鬥
  BattleState initializeBattle(BattleConfiguration config);

  /// 開始玩家回合
  BattleState startPlayerTurn(BattleState state);

  /// 開始敵人回合
  BattleState startEnemyTurn(BattleState state);

  /// 準備下一回合
  BattleState prepareNextTurn(BattleState state);

  /// 結束戰鬥
  BattleState endBattle(BattleState state, String result);

  // ===== 玩家行動 =====

  /// 玩家攻擊敵人
  BattleActionResult playerAttackEnemy(BattleState state, int damage);

  /// 玩家使用技能（舊接口）
  BattleActionResult playerUseSkill(
    BattleState state,
    String skillId, {
    String? targetEnemyActionId,
  });

  /// 執行玩家技能（完整實現）
  SkillExecutionResult executePlayerSkill(
    BattleState state,
    String skillId,
    String casterId,
  );

  /// 應用技能執行結果到遊戲狀態
  BattleState applySkillExecutionResult(
    BattleState state,
    SkillExecutionResult result,
  );

  /// 嘗試逃跑
  BattleActionResult attemptEscape(BattleState state);

  // ===== 敵人行動 =====

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

  // ===== 戰鬥狀態查詢 =====

  /// 檢查戰鬥是否結束
  BattleEndResult checkBattleEnd(BattleState state);

  /// 檢查戰鬥是否可以繼續
  bool canContinueBattle(BattleState state);

  /// 檢查是否為玩家回合
  bool isPlayerTurn(BattleState state);

  // ===== 特殊操作 =====

  /// 選擇要無效化的敵人行動
  BattleState selectEnemyActionToNullify(BattleState state, String actionId);
}
