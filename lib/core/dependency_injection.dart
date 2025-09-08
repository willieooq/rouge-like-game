// lib/core/dependency_injection.dart
// 統一的依賴注入管理

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/battle_service_impl.dart';
import '../services/enemy_service_impl.dart';
import '../services/game_data_initialization_service_impl.dart';
// === Service Implementations ===
import '../services/skill_service_impl.dart';
import '../services/status_service_impl.dart';
import 'interfaces/i_battle_service.dart';
import 'interfaces/i_enemy_service.dart';
import 'interfaces/i_game_data_initialization_service.dart';
// === Interfaces ===
import 'interfaces/i_skill_service.dart';
import 'interfaces/i_status_service.dart';

// ================================
// Service Providers
// ================================

/// 敵人服務 Provider（使用 autoDispose 確保生命週期管理）
final enemyServiceProvider = Provider.autoDispose<IEnemyService>((ref) {
  return EnemyServiceImpl();
});

/// 技能服務 Provider
final skillServiceProvider = Provider.autoDispose<ISkillService>((ref) {
  return SkillServiceImpl();
});

/// 戰鬥服務 Provider
final battleServiceProvider = Provider.autoDispose<IBattleService>((ref) {
  final skillService = ref.watch(skillServiceProvider);
  final enemyService = ref.watch(enemyServiceProvider);
  final statusService = ref.watch(statusServiceProvider);

  return BattleServiceImpl(
    skillService: skillService,
    enemyService: enemyService,
    statusService: statusService,
  );
});

/// 狀態服務 Provider
final statusServiceProvider = Provider.autoDispose<IStatusService>((ref) {
  return StatusServiceImpl();
});

/// 遊戲數據初始化服務 Provider
final gameDataInitServiceProvider =
    Provider.autoDispose<IGameDataInitializationService>((ref) {
      final skillService = ref.watch(skillServiceProvider);
      return GameDataInitializationServiceImpl(skillService: skillService);
    });

// ================================
// 初始化 Provider
// ================================

/// 遊戲初始化 Provider - 負責載入所有必要數據
final gameInitializationProvider = FutureProvider<bool>((ref) async {
  try {
    // 載入技能數據
    final skillService = ref.read(skillServiceProvider);
    await skillService.loadSkills();

    // 載入其他必要數據
    final gameDataService = ref.read(gameDataInitServiceProvider);
    await gameDataService.initializeGameData();

    return true;
  } catch (e) {
    print('遊戲初始化失敗: $e');
    return false;
  }
});

// ================================
// Composite Providers（組合型 Provider）
// ================================

/// 戰鬥系統相關的服務組合
final battleSystemProvider = Provider<BattleSystemServices>((ref) {
  return BattleSystemServices(
    battleService: ref.watch(battleServiceProvider),
    skillService: ref.watch(skillServiceProvider),
    enemyService: ref.watch(enemyServiceProvider),
    statusService: ref.watch(statusServiceProvider),
  );
});

/// 戰鬥系統服務組合類
class BattleSystemServices {
  final IBattleService battleService;
  final ISkillService skillService;
  final IEnemyService enemyService;
  final IStatusService statusService;

  const BattleSystemServices({
    required this.battleService,
    required this.skillService,
    required this.enemyService,
    required this.statusService,
  });
}
