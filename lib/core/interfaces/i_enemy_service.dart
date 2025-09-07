// lib/core/interfaces/i_enemy_service.dart
import '../../models/character/character.dart';
import '../../models/enemy/enemy.dart';
import '../../models/enemy/enemy_action.dart';
import '../../shared/beans/battle/battle_action_result.dart';
import '../../shared/beans/enemy/enemy_action_queue_result.dart';
import '../../shared/beans/enemy/enemy_encounter_result.dart';

/// 敵人服務統一接口
abstract interface class IEnemyService {
  // ==========================================
  // 數據管理
  // ==========================================

  /// 初始化敵人數據
  Future<void> initialize();

  /// 獲取所有敵人數據
  List<EnemyData> getAllEnemyData();

  /// 根據ID獲取敵人數據
  EnemyData? getEnemyDataById(String id);

  /// 根據類型獲取敵人數據列表
  List<EnemyData> getEnemiesByType(EnemyType type);

  /// 創建敵人實例
  Enemy createEnemy({required String enemyId, int? level});

  /// 驗證敵人數據完整性
  bool validateEnemyData();

  // ==========================================
  // 戰鬥功能（BattleProvider 需要的方法）
  // ==========================================

  /// 生成敵人行動隊列
  EnemyActionQueueResult generateActionQueue({
    required Enemy enemy,
    required List<Character> playerParty,
    required int turnNumber,
  });

  /// 執行敵人行動隊列
  List<EnemyActionResult> executeActionQueue(
    List<EnemyAction> actionQueue,
    EnemyAction? nullifiedAction,
    Enemy enemy,
  );

  /// 根據敵人類型調整行動強度
  List<EnemyAction> adjustActionsByEnemyType(
    List<EnemyAction> actions,
    Enemy enemy,
  );

  // ==========================================
  // 整合戰鬥功能（高層API）
  // ==========================================

  /// 處理敵人完整回合（AI決策 + 行動執行）
  Future<BattleActionResult> processEnemyTurn({
    required Enemy enemy,
    required List<Character> playerParty,
    required int turnNumber,
    EnemyAction? nullifiedAction,
  });

  // ==========================================
  // 遭遇生成
  // ==========================================

  /// 生成隨機敵人遭遇
  EnemyEncounterResult generateRandomEncounter({
    required int playerLevel,
    required int maxEnemies,
    double eliteChance = 0.2,
    double bossChance = 0.05,
  });

  /// 生成特定區域敵人遭遇
  EnemyEncounterResult generateAreaEncounter({
    required String areaId,
    required int playerLevel,
    required int maxEnemies,
  });

  // ==========================================
  // 統計和工具
  // ==========================================

  /// 獲取敵人統計信息
  Map<String, int> getStatistics();
}
