// ================================
// lib/utils/enemy_utils.dart - 敵人專用工具類
// ================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dependency_injection.dart';
import '../core/interfaces/i_enemy_service.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/enemy/enemy_action.dart';
import '../shared/beans/battle/battle_action_result.dart';
import '../shared/beans/enemy/enemy_action_queue_result.dart';
import '../shared/beans/enemy/enemy_encounter_result.dart';

/// 敵人專用工具類 - 敵人操作的主要入口點
///
/// 職責：提供所有敵人相關的便利方法
/// 設計原則：直接訪問敵人服務，作為敵人領域的主要工具類
class EnemyUtils {
  EnemyUtils._();

  // ================================
  // 核心敵人訪問方法
  // ================================

  /// 從 Ref 獲取敵人服務
  static IEnemyService _getEnemyService(Ref ref) {
    return ref.read(enemyServiceProvider);
  }

  /// 獲取敵人數據
  static EnemyData? getEnemyData(Ref ref, String enemyId) {
    try {
      return _getEnemyService(ref).getEnemyDataById(enemyId);
    } catch (e) {
      return null;
    }
  }

  /// 獲取所有敵人數據
  static List<EnemyData> getAllEnemyData(Ref ref) {
    try {
      return _getEnemyService(ref).getAllEnemyData();
    } catch (e) {
      return [];
    }
  }

  /// 創建敵人實例
  static Enemy? createEnemy(Ref ref, String enemyId, {int? level}) {
    try {
      return _getEnemyService(ref).createEnemy(enemyId: enemyId, level: level);
    } catch (e) {
      return null;
    }
  }

  /// 檢查敵人是否存在
  static bool hasEnemy(Ref ref, String enemyId) {
    return getEnemyData(ref, enemyId) != null;
  }

  /// 根據類型獲取敵人數據列表
  static List<EnemyData> getEnemiesByType(Ref ref, EnemyType type) {
    try {
      return _getEnemyService(ref).getEnemiesByType(type);
    } catch (e) {
      return [];
    }
  }

  /// 獲取敵人統計資訊
  static Map<String, int> getEnemyStatistics(Ref ref) {
    try {
      return _getEnemyService(ref).getStatistics();
    } catch (e) {
      return {'total': 0, 'normal': 0, 'elite': 0, 'boss': 0};
    }
  }

  // ================================
  // 敵人類型檢查
  // ================================

  /// 檢查敵人類型
  static bool isBossEnemy(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.type == EnemyType.boss;
  }

  static bool isEliteEnemy(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.type == EnemyType.elite;
  }

  static bool isNormalEnemy(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.type == EnemyType.normal;
  }

  /// 獲取敵人類型描述
  static String getEnemyType(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    switch (enemy?.type) {
      case EnemyType.boss:
        return 'Boss';
      case EnemyType.elite:
        return '精英';
      case EnemyType.normal:
        return '普通';
      case null:
        return '未知';
    }
  }

  /// 獲取敵人類型顏色
  static String getEnemyTypeColor(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    switch (enemy?.type) {
      case EnemyType.boss:
        return '#8B0000'; // 深紅色
      case EnemyType.elite:
        return '#FF6347'; // 番茄紅
      case EnemyType.normal:
        return '#808080'; // 灰色
      case null:
        return '#000000'; // 黑色
    }
  }

  // ================================
  // AI行為分析
  // ================================

  /// 檢查AI行為類型
  static bool isAggressiveAI(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.aiBehavior == AIBehavior.aggressive;
  }

  static bool isDefensiveAI(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.aiBehavior == AIBehavior.defensive;
  }

  static bool isBalancedAI(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.aiBehavior == AIBehavior.balanced;
  }

  static bool isSupportAI(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.aiBehavior == AIBehavior.support;
  }

  /// 獲取AI行為描述
  static String getAIBehaviorDescription(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    switch (enemy?.aiBehavior) {
      case AIBehavior.aggressive:
        return '攻擊型：優先攻擊低血量角色';
      case AIBehavior.defensive:
        return '防守型：優先使用防禦技能';
      case AIBehavior.balanced:
        return '平衡型：隨機選擇行動';
      case AIBehavior.support:
        return '輔助型：優先治療盟友';
      case null:
        return '未知行為模式';
    }
  }

  // ================================
  // 敵人屬性分析
  // ================================

  /// 獲取敵人血量
  static int getEnemyHP(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.baseHp ?? 0;
  }

  /// 獲取敵人攻擊力
  static int getEnemyAttack(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.baseAttack ?? 0;
  }

  /// 獲取敵人防禦力
  static int getEnemyDefense(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.baseDefense ?? 0;
  }

  /// 獲取敵人速度
  static int getEnemySpeed(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.baseSpeed ?? 0;
  }

  /// 檢查敵人是否為高血量
  static bool isHighHPEnemy(Ref ref, String enemyId) {
    final hp = getEnemyHP(ref, enemyId);
    return hp >= 500; // 可調整閾值
  }

  /// 檢查敵人是否為高攻擊
  static bool isHighAttackEnemy(Ref ref, String enemyId) {
    final attack = getEnemyAttack(ref, enemyId);
    return attack >= 100; // 可調整閾值
  }

  /// 檢查敵人是否為高防禦
  static bool isHighDefenseEnemy(Ref ref, String enemyId) {
    final defense = getEnemyDefense(ref, enemyId);
    return defense >= 50; // 可調整閾值
  }

  /// 檢查敵人是否為高速
  static bool isHighSpeedEnemy(Ref ref, String enemyId) {
    final speed = getEnemySpeed(ref, enemyId);
    return speed >= 80; // 可調整閾值
  }

  // ================================
  // 敵人難度評估
  // ================================

  /// 計算敵人戰鬥力
  static int calculateEnemyPower(Ref ref, String enemyId, {int level = 1}) {
    final enemy = getEnemyData(ref, enemyId);
    if (enemy == null) return 0;

    // 基於等級調整屬性
    final scaleFactor = 1.0 + ((level - 1) * 0.15);

    final hp = (enemy.baseHp * scaleFactor).round();
    final attack = (enemy.baseAttack * scaleFactor).round();
    final defense = (enemy.baseDefense * scaleFactor).round();
    final speed = (enemy.baseSpeed * scaleFactor).round();

    // 戰鬥力計算公式（可根據遊戲平衡調整）
    var power = (hp * 2) + (attack * 3) + (defense * 2) + speed;

    // 類型加成
    switch (enemy.type) {
      case EnemyType.elite:
        power = (power * 1.3).round();
        break;
      case EnemyType.boss:
        power = (power * 1.8).round();
        break;
      case EnemyType.normal:
        break;
    }

    return power;
  }

  /// 獲取敵人難度等級
  static String getEnemyDifficulty(Ref ref, String enemyId, {int level = 1}) {
    final power = calculateEnemyPower(ref, enemyId, level: level);

    if (power >= 1200) return '地獄';
    if (power >= 900) return '困難';
    if (power >= 600) return '普通';
    if (power >= 300) return '簡單';
    return '極簡';
  }

  /// 獲取敵人威脅等級 (1-5 星)
  static int getEnemyThreatLevel(Ref ref, String enemyId, {int level = 1}) {
    final power = calculateEnemyPower(ref, enemyId, level: level);

    if (power >= 1200) return 5;
    if (power >= 900) return 4;
    if (power >= 600) return 3;
    if (power >= 300) return 2;
    return 1;
  }

  /// 獲取難度顏色
  static String getDifficultyColor(Ref ref, String enemyId, {int level = 1}) {
    final difficulty = getEnemyDifficulty(ref, enemyId, level: level);

    switch (difficulty) {
      case '地獄':
        return '#8B0000'; // 深紅
      case '困難':
        return '#FF4500'; // 橙紅
      case '普通':
        return '#FFD700'; // 金色
      case '簡單':
        return '#32CD32'; // 綠色
      case '極簡':
        return '#87CEEB'; // 淺藍
      default:
        return '#808080'; // 灰色
    }
  }

  // ================================
  // 敵人技能和能力
  // ================================

  /// 獲取敵人技能列表
  static List<String> getEnemySkills(Ref ref, String enemyId) {
    final enemy = getEnemyData(ref, enemyId);
    return enemy?.skillIds ?? [];
  }

  /// 檢查敵人是否有特定技能
  static bool hasSkill(Ref ref, String enemyId, String skillId) {
    final skills = getEnemySkills(ref, enemyId);
    return skills.contains(skillId);
  }

  /// 獲取敵人技能數量
  static int getSkillCount(Ref ref, String enemyId) {
    return getEnemySkills(ref, enemyId).length;
  }

  /// 檢查敵人是否有治療技能
  static bool hasHealingSkills(Ref ref, String enemyId) {
    final skills = getEnemySkills(ref, enemyId);
    // 這裡可以根據技能ID或類型判斷，暫時用簡單的字串匹配
    return skills.any(
      (skill) => skill.contains('heal') || skill.contains('recover'),
    );
  }

  /// 檢查敵人是否有AOE技能
  static bool hasAOESkills(Ref ref, String enemyId) {
    final skills = getEnemySkills(ref, enemyId);
    return skills.any(
      (skill) => skill.contains('aoe') || skill.contains('area'),
    );
  }

  // ================================
  // 敵人推薦和篩選
  // ================================

  /// 根據難度篩選敵人
  static List<String> getEnemiesByDifficulty(
    Ref ref,
    String difficulty, { // 'easy', 'medium', 'hard', 'extreme'
    int level = 1,
  }) {
    final allEnemies = getAllEnemyData(ref);
    final List<String> result = [];

    for (final enemy in allEnemies) {
      final enemyDifficulty = getEnemyDifficulty(ref, enemy.id, level: level);

      bool matches = false;
      switch (difficulty.toLowerCase()) {
        case 'easy':
          matches = enemyDifficulty == '極簡' || enemyDifficulty == '簡單';
          break;
        case 'medium':
          matches = enemyDifficulty == '普通';
          break;
        case 'hard':
          matches = enemyDifficulty == '困難';
          break;
        case 'extreme':
          matches = enemyDifficulty == '地獄';
          break;
      }

      if (matches) {
        result.add(enemy.id);
      }
    }

    return result;
  }

  /// 獲取適合玩家等級的敵人
  static List<String> getEnemiesForPlayerLevel(
    Ref ref,
    int playerLevel, {
    double difficultyRange = 0.3, // 難度範圍
  }) {
    final allEnemies = getAllEnemyData(ref);
    final List<String> result = [];

    // 計算玩家期望的敵人戰鬥力範圍
    final expectedPower = playerLevel * 100; // 簡單的基準
    final minPower = (expectedPower * (1 - difficultyRange)).round();
    final maxPower = (expectedPower * (1 + difficultyRange)).round();

    for (final enemy in allEnemies) {
      final enemyPower = calculateEnemyPower(ref, enemy.id, level: playerLevel);

      if (enemyPower >= minPower && enemyPower <= maxPower) {
        result.add(enemy.id);
      }
    }

    return result;
  }

  /// 推薦敵人（基於特定條件）
  static List<String> getRecommendedEnemies(
    Ref ref, {
    EnemyType? preferredType,
    AIBehavior? preferredBehavior,
    int? maxThreatLevel,
    int level = 1,
  }) {
    final allEnemies = getAllEnemyData(ref);

    return allEnemies
        .where((enemy) {
          if (preferredType != null && enemy.type != preferredType)
            return false;
          if (preferredBehavior != null &&
              enemy.aiBehavior != preferredBehavior)
            return false;
          if (maxThreatLevel != null &&
              getEnemyThreatLevel(ref, enemy.id, level: level) > maxThreatLevel)
            return false;
          return true;
        })
        .map((enemy) => enemy.id)
        .toList();
  }

  // ================================
  // 戰鬥相關功能
  // ================================

  /// 生成敵人行動隊列
  static EnemyActionQueueResult? generateActionQueue(
    Ref ref, {
    required Enemy enemy,
    required List<Character> playerParty,
    required int turnNumber,
  }) {
    try {
      return _getEnemyService(ref).generateActionQueue(
        enemy: enemy,
        playerParty: playerParty,
        turnNumber: turnNumber,
      );
    } catch (e) {
      return null;
    }
  }

  /// 執行敵人行動隊列
  static List<EnemyActionResult> executeActionQueue(
    Ref ref,
    List<EnemyAction> actionQueue,
    EnemyAction? nullifiedAction,
    Enemy enemy,
  ) {
    try {
      return _getEnemyService(
        ref,
      ).executeActionQueue(actionQueue, nullifiedAction, enemy);
    } catch (e) {
      return [];
    }
  }

  /// 處理敵人完整回合
  static Future<BattleActionResult?> processEnemyTurn(
    Ref ref, {
    required Enemy enemy,
    required List<Character> playerParty,
    required int turnNumber,
    EnemyAction? nullifiedAction,
  }) async {
    try {
      return await _getEnemyService(ref).processEnemyTurn(
        enemy: enemy,
        playerParty: playerParty,
        turnNumber: turnNumber,
        nullifiedAction: nullifiedAction,
      );
    } catch (e) {
      return null;
    }
  }

  // ================================
  // 遭遇生成功能
  // ================================

  /// 生成隨機敵人遭遇
  static EnemyEncounterResult? generateRandomEncounter(
    Ref ref, {
    required int playerLevel,
    required int maxEnemies,
    double eliteChance = 0.2,
    double bossChance = 0.05,
  }) {
    try {
      return _getEnemyService(ref).generateRandomEncounter(
        playerLevel: playerLevel,
        maxEnemies: maxEnemies,
        eliteChance: eliteChance,
        bossChance: bossChance,
      );
    } catch (e) {
      return null;
    }
  }

  /// 生成特定區域敵人遭遇
  static EnemyEncounterResult? generateAreaEncounter(
    Ref ref, {
    required String areaId,
    required int playerLevel,
    required int maxEnemies,
  }) {
    try {
      return _getEnemyService(ref).generateAreaEncounter(
        areaId: areaId,
        playerLevel: playerLevel,
        maxEnemies: maxEnemies,
      );
    } catch (e) {
      return null;
    }
  }

  // ================================
  // 敵人資訊格式化
  // ================================

  /// 獲取敵人簡要描述
  static String getEnemySummary(Ref ref, String enemyId, {int level = 1}) {
    final enemy = getEnemyData(ref, enemyId);
    if (enemy == null) return '未知敵人';

    final type = getEnemyType(ref, enemyId);
    final hp = (enemy.baseHp * (1.0 + ((level - 1) * 0.15))).round();
    final attack = (enemy.baseAttack * (1.0 + ((level - 1) * 0.15))).round();
    final difficulty = getEnemyDifficulty(ref, enemyId, level: level);

    return '$type - HP:$hp ATK:$attack ($difficulty)';
  }

  /// 獲取敵人詳細資訊
  static String getEnemyDetails(Ref ref, String enemyId, {int level = 1}) {
    final enemy = getEnemyData(ref, enemyId);
    if (enemy == null) return '敵人不存在';

    final scaleFactor = 1.0 + ((level - 1) * 0.15);
    final hp = (enemy.baseHp * scaleFactor).round();
    final attack = (enemy.baseAttack * scaleFactor).round();
    final defense = (enemy.baseDefense * scaleFactor).round();
    final speed = (enemy.baseSpeed * scaleFactor).round();

    final power = calculateEnemyPower(ref, enemyId, level: level);
    final difficulty = getEnemyDifficulty(ref, enemyId, level: level);
    final threatLevel = getEnemyThreatLevel(ref, enemyId, level: level);
    final aiDescription = getAIBehaviorDescription(ref, enemyId);

    return '${enemy.name} (Lv.$level)\n'
        '類型: ${getEnemyType(ref, enemyId)}\n'
        '血量: $hp\n'
        '攻擊: $attack\n'
        '防禦: $defense\n'
        '速度: $speed\n'
        '戰鬥力: $power\n'
        '難度: $difficulty\n'
        '威脅等級: $threatLevel 星\n'
        'AI模式: $aiDescription\n'
        '技能數量: ${getSkillCount(ref, enemyId)}';
  }

  /// 獲取敵人顯示名稱（包含等級）
  static String getEnemyDisplayName(Ref ref, String enemyId, {int? level}) {
    final enemy = getEnemyData(ref, enemyId);
    if (enemy == null) return '未知敵人';

    if (level != null && level > 1) {
      return '${enemy.name} Lv.$level';
    }
    return enemy.name;
  }

  // ================================
  // 敵人比較和分析
  // ================================

  /// 比較兩個敵人的戰鬥力
  static int compareEnemiesByPower(
    Ref ref,
    String enemyId1,
    String enemyId2, {
    int level = 1,
  }) {
    final power1 = calculateEnemyPower(ref, enemyId1, level: level);
    final power2 = calculateEnemyPower(ref, enemyId2, level: level);

    return power2.compareTo(power1); // 降序排列
  }

  /// 比較兩個敵人的血量
  static int compareEnemiesByHP(Ref ref, String enemyId1, String enemyId2) {
    final hp1 = getEnemyHP(ref, enemyId1);
    final hp2 = getEnemyHP(ref, enemyId2);

    return hp2.compareTo(hp1); // 降序排列
  }

  /// 比較兩個敵人的攻擊力
  static int compareEnemiesByAttack(Ref ref, String enemyId1, String enemyId2) {
    final attack1 = getEnemyAttack(ref, enemyId1);
    final attack2 = getEnemyAttack(ref, enemyId2);

    return attack2.compareTo(attack1); // 降序排列
  }

  /// 分析敵人弱點
  static Map<String, dynamic> analyzeEnemyWeaknesses(
    Ref ref,
    String enemyId, {
    int level = 1,
  }) {
    final enemy = getEnemyData(ref, enemyId);
    if (enemy == null) {
      return {'error': '敵人不存在'};
    }

    final scaleFactor = 1.0 + ((level - 1) * 0.15);
    final hp = (enemy.baseHp * scaleFactor).round();
    final attack = (enemy.baseAttack * scaleFactor).round();
    final defense = (enemy.baseDefense * scaleFactor).round();
    final speed = (enemy.baseSpeed * scaleFactor).round();

    final weaknesses = <String>[];
    final recommendations = <String>[];

    // 分析屬性弱點
    if (defense < 30) {
      weaknesses.add('低防禦');
      recommendations.add('使用高攻擊技能');
    }

    if (hp < 200) {
      weaknesses.add('低血量');
      recommendations.add('集中火力快速解決');
    }

    if (speed < 50) {
      weaknesses.add('低速度');
      recommendations.add('使用先手技能');
    }

    if (attack < 50) {
      weaknesses.add('低攻擊');
      recommendations.add('可以採用持久戰術');
    }

    // 根據AI類型給出建議
    switch (enemy.aiBehavior) {
      case AIBehavior.aggressive:
        recommendations.add('注意其攻擊性，準備防禦技能');
        break;
      case AIBehavior.defensive:
        recommendations.add('使用破防技能，打持久戰');
        break;
      case AIBehavior.balanced:
        recommendations.add('保持靈活應對');
        break;
      case AIBehavior.support:
        recommendations.add('優先打斷其輔助行動');
        break;
    }

    // 根據類型給出建議
    switch (enemy.type) {
      case EnemyType.boss:
        recommendations.add('準備長期戰鬥');
        recommendations.add('使用輔助技能增強自身');
        break;
      case EnemyType.elite:
        recommendations.add('注意特殊能力');
        recommendations.add('保持技能多樣性');
        break;
      case EnemyType.normal:
        recommendations.add('可以嘗試新戰術');
        break;
    }

    return {
      'enemy': enemy,
      'level': level,
      'scaled_stats': {
        'hp': hp,
        'attack': attack,
        'defense': defense,
        'speed': speed,
      },
      'weaknesses': weaknesses,
      'recommendations': recommendations,
      'threat_level': getEnemyThreatLevel(ref, enemyId, level: level),
      'difficulty': getEnemyDifficulty(ref, enemyId, level: level),
      'ai_behavior': getAIBehaviorDescription(ref, enemyId),
    };
  }

  /// 獲取敵人分析統計
  static Map<String, dynamic> getEnemyAnalytics(
    Ref ref,
    List<String> enemyIds, {
    int level = 1,
  }) {
    if (enemyIds.isEmpty) return {'error': '沒有敵人數據'};

    final validEnemies = enemyIds.where((id) => hasEnemy(ref, id)).toList();
    if (validEnemies.isEmpty) return {'error': '沒有有效敵人'};

    final totalPower = validEnemies.fold(
      0,
      (sum, id) => sum + calculateEnemyPower(ref, id, level: level),
    );

    final avgPower = totalPower / validEnemies.length;

    final typeCount = <String, int>{};
    final behaviorCount = <String, int>{};
    final difficultyCount = <String, int>{};

    for (final enemyId in validEnemies) {
      final type = getEnemyType(ref, enemyId);
      final behavior =
          getEnemyData(ref, enemyId)?.aiBehavior.toString() ?? 'unknown';
      final difficulty = getEnemyDifficulty(ref, enemyId, level: level);

      typeCount[type] = (typeCount[type] ?? 0) + 1;
      behaviorCount[behavior] = (behaviorCount[behavior] ?? 0) + 1;
      difficultyCount[difficulty] = (difficultyCount[difficulty] ?? 0) + 1;
    }

    // 找出最強和最弱的敵人
    var strongestId = validEnemies.first;
    var weakestId = validEnemies.first;

    for (final enemyId in validEnemies) {
      if (compareEnemiesByPower(ref, enemyId, strongestId, level: level) < 0) {
        strongestId = enemyId;
      }
      if (compareEnemiesByPower(ref, enemyId, weakestId, level: level) > 0) {
        weakestId = enemyId;
      }
    }

    return {
      'total_enemies': validEnemies.length,
      'level': level,
      'total_power': totalPower,
      'average_power': avgPower.round(),
      'type_distribution': typeCount,
      'behavior_distribution': behaviorCount,
      'difficulty_distribution': difficultyCount,
      'strongest_enemy': {
        'id': strongestId,
        'name': getEnemyData(ref, strongestId)?.name ?? 'Unknown',
        'power': calculateEnemyPower(ref, strongestId, level: level),
      },
      'weakest_enemy': {
        'id': weakestId,
        'name': getEnemyData(ref, weakestId)?.name ?? 'Unknown',
        'power': calculateEnemyPower(ref, weakestId, level: level),
      },
    };
  }

  /// 查找相似敵人
  static List<String> findSimilarEnemies(
    Ref ref,
    String enemyId, {
    int level = 1,
    double powerTolerance = 0.2,
  }) {
    final targetEnemy = getEnemyData(ref, enemyId);
    if (targetEnemy == null) return [];

    final targetPower = calculateEnemyPower(ref, enemyId, level: level);
    final allEnemies = getAllEnemyData(ref);

    return allEnemies
        .where((enemy) {
          if (enemy.id == enemyId) return false; // 排除自己

          final power = calculateEnemyPower(ref, enemy.id, level: level);
          final powerDiff = (power - targetPower).abs() / targetPower;

          // 相似條件：戰鬥力相近且同類型或同AI行為
          final similarPower = powerDiff <= powerTolerance;
          final sameType = enemy.type == targetEnemy.type;
          final sameBehavior = enemy.aiBehavior == targetEnemy.aiBehavior;

          return similarPower && (sameType || sameBehavior);
        })
        .map((enemy) => enemy.id)
        .toList();
  }

  // ================================
  // 實例狀態管理（針對戰鬥中的敵人實例）
  // ================================

  /// 檢查敵人實例狀態
  static bool isEnemyInstanceDead(Enemy enemy) {
    return enemy.isDead;
  }

  static bool isEnemyInstanceInDanger(Enemy enemy) {
    return enemy.isInDanger;
  }

  static bool isEnemyInstanceFullHP(Enemy enemy) {
    return enemy.isFullHp;
  }

  static double getEnemyInstanceHPPercentage(Enemy enemy) {
    return enemy.hpPercentage;
  }

  /// 獲取敵人實例狀態描述
  static String getEnemyInstanceStatus(Enemy enemy) {
    if (enemy.isDead) return '已死亡';
    if (enemy.isInDanger) return '危險';
    if (enemy.hpPercentage < 0.5) return '受傷';
    if (enemy.isFullHp) return '滿血';
    return '健康';
  }

  /// 獲取敵人實例狀態顏色
  static String getEnemyInstanceStatusColor(Enemy enemy) {
    if (enemy.isDead) return '#808080'; // 灰色
    if (enemy.isInDanger) return '#FF0000'; // 紅色
    if (enemy.hpPercentage < 0.5) return '#FF8C00'; // 橙色
    if (enemy.isFullHp) return '#32CD32'; // 綠色
    return '#FFD700'; // 金色
  }
}
