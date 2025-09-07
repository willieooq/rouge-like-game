//lib/models/battle/battle_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

import '../character/character.dart';
import '../enemy/enemy.dart';
import '../enemy/enemy_action.dart';
import '../party/party.dart';
import '../status/status_effect.dart';

part 'battle_state.freezed.dart';

/// 戰鬥階段
enum BattlePhase {
  preparation,
  playerTurn,
  enemyTurn,
  battleEnd,
  victory,
  defeat,
}

/// 戰鬥結果
enum BattleResult { ongoing, victory, defeat, escaped }

/// 戰鬥狀態
///
/// 遵循 Single Responsibility Principle：
/// 只負責保存戰鬥相關的狀態數據
@freezed
abstract class BattleState with _$BattleState {
  const factory BattleState({
    // 基本戰鬥狀態
    required BattlePhase currentPhase,
    required BattleResult result,
    required int turnNumber,
    required bool playerHasFirstTurn,

    // 參戰單位
    required Party party,
    required Enemy enemy, // 單個敵人
    // 狀態效果管理器
    required StatusEffectManager playerStatusManager,
    required StatusEffectManager enemyStatusManager,

    // 敵人行動系統
    required List<EnemyAction> enemyActionQueue,
    required int currentEnemyActionIndex,
    @Default(null) EnemyAction? selectedEnemyAction,

    // 戰鬥統計
    required BattleStatistics statistics,

    // 戰鬥設定
    required bool canEscape,
    required double baseEscapeChance,

    // 為了向後兼容添加的欄位
    @Default(null) Enemy? selectedEnemy,
    @Default(null) Enemy? targetedEnemy,
    @Default(null) Character? selectedCharacter,
    @Default(3) int currentActionPoints,
    @Default(3) int maxActionPoints,
  }) = _BattleState;

  /// 創建初始戰鬥狀態
  factory BattleState.initial() {
    return BattleState(
      currentPhase: BattlePhase.preparation,
      result: BattleResult.ongoing,
      turnNumber: 1,
      playerHasFirstTurn: true,
      party: new Party(
        characters: [],
        sharedHp: 9999,
        maxHp: 9999,
        currentTurnCost: 10,
        maxTurnCost: 10,
      ),
      enemy: _createEmptyEnemy(),
      playerStatusManager: StatusEffectManager(),
      enemyStatusManager: StatusEffectManager(),
      enemyActionQueue: [],
      currentEnemyActionIndex: 0,
      statistics: BattleStatistics.initial(),
      canEscape: true,
      baseEscapeChance: 0.7,
    );
  }

  /// 創建空敵人（用於初始化）
  static Enemy _createEmptyEnemy() {
    return const Enemy(
      id: '',
      name: '',
      type: EnemyType.normal,
      aiBehavior: AIBehavior.balanced,
      maxHp: 1,
      currentHp: 1,
      attack: 1,
      defense: 1,
      speed: 1,
      iconPath: '',
      description: '',
      skillIds: [],
      expReward: 0,
      goldReward: 0,
    );
  }
}

/// 戰鬥統計數據
///
/// 遵循 Single Responsibility Principle：
/// 只負責記錄戰鬥過程中的統計信息
@freezed
abstract class BattleStatistics with _$BattleStatistics {
  const factory BattleStatistics({
    required int totalDamageDealt,
    required int totalDamageReceived,
    required int totalHealingReceived,
    required List<String> skillsUsed,
    required int statusEffectsApplied,
    required int turnCount,
  }) = _BattleStatistics;

  factory BattleStatistics.initial() {
    return const BattleStatistics(
      totalDamageDealt: 0,
      totalDamageReceived: 0,
      totalHealingReceived: 0,
      skillsUsed: [],
      statusEffectsApplied: 0,
      turnCount: 0,
    );
  }
}

/// 戰鬥狀態擴展方法
///
/// 遵循 Open/Closed Principle：
/// 通過擴展方法添加功能，而不修改原始類
extension BattleStateExtensions on BattleState {
  /// 是否為玩家回合
  bool get isPlayerTurn => currentPhase == BattlePhase.playerTurn;

  /// 是否為敵人回合
  bool get isEnemyTurn => currentPhase == BattlePhase.enemyTurn;

  /// 戰鬥是否進行中
  bool get isBattleOngoing => result == BattleResult.ongoing;

  /// 戰鬥是否已結束
  bool get isBattleEnded => !isBattleOngoing;

  /// 敵人是否已死亡
  bool get isEnemyDefeated => enemy.isDead;

  /// 是否還有敵人行動待執行
  bool get hasMoreEnemyActions =>
      currentEnemyActionIndex < enemyActionQueue.length;

  /// 獲取當前敵人行動
  EnemyAction? get currentEnemyAction {
    if (!hasMoreEnemyActions) return null;
    return enemyActionQueue[currentEnemyActionIndex];
  }

  /// 獲取可被無效化的敵人行動
  List<EnemyAction> get targetableEnemyActions {
    return enemyActionQueue.where((action) => action.isTargetable).toList();
  }

  /// 為了向後兼容，提供 enemies 的 getter
  List<Enemy> get enemies => [enemy];

  /// 為了向後兼容，提供便利方法
  bool get canAttack => isPlayerTurn && currentActionPoints > 0;

  bool get canUseSkill => isPlayerTurn && currentActionPoints > 0;

  bool get canUseItem => isPlayerTurn;

  bool get canFlee => canEscape && isPlayerTurn;

  /// 計算逃跑成功率
  double calculateEscapeChance() {
    double chance = baseEscapeChance;

    // 根據敵人類型調整逃跑難度
    switch (enemy.type) {
      case EnemyType.boss:
        chance *= 0.3;
        break;
      case EnemyType.elite:
        chance *= 0.6;
        break;
      case EnemyType.normal:
        break;
    }

    // 根據玩家狀態調整（例如：中毒時更難逃跑）
    final debuffCount = playerStatusManager.getStatusCount(StatusType.debuff);
    chance *= (1.0 - (debuffCount * 0.1)).clamp(0.1, 1.0);

    return chance.clamp(0.0, 1.0);
  }

  /// 創建戰鬥結果摘要
  BattleSummary createBattleSummary() {
    return BattleSummary(
      result: result,
      turnCount: statistics.turnCount,
      damageDealt: statistics.totalDamageDealt,
      damageReceived: statistics.totalDamageReceived,
      expGained: result == BattleResult.victory ? enemy.expReward : 0,
      goldGained: result == BattleResult.victory ? enemy.goldReward : 0,
    );
  }
}

/// 戰鬥結果摘要
@freezed
abstract class BattleSummary with _$BattleSummary {
  const factory BattleSummary({
    required BattleResult result,
    required int turnCount,
    required int damageDealt,
    required int damageReceived,
    required int expGained,
    required int goldGained,
  }) = _BattleSummary;
}
