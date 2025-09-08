// lib/providers/enemy_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/interfaces/i_enemy_service.dart';
import '../models/enemy/enemy.dart';
import '../services/enemy_service_impl.dart';
import '../shared/beans/enemy/enemy_encounter_result.dart';

/// 敵人服務 Provider
final enemyServiceProvider = Provider<IEnemyService>((ref) {
  return EnemyServiceImpl();
});

/// 敵人系統初始化 Provider
final enemyInitializationProvider = FutureProvider<bool>((ref) async {
  final enemyService = ref.watch(enemyServiceProvider);
  await enemyService.initialize();
  return enemyService.validateEnemyData();
});

/// 當前戰鬥敵人 Provider
final currentBattleEnemyProvider = StateProvider<Enemy?>((ref) => null);

/// 敵人遭遇生成 Provider
final enemyEncounterProvider =
    StateNotifierProvider<EnemyEncounterNotifier, EnemyEncounterResult>((ref) {
      return EnemyEncounterNotifier(ref.watch(enemyServiceProvider));
    });

class EnemyEncounterNotifier extends StateNotifier<EnemyEncounterResult> {
  final IEnemyService _enemyService;

  EnemyEncounterNotifier(this._enemyService)
    : super(EnemyEncounterResult.empty);

  void generateRandomEncounter({
    required int playerLevel,
    required int maxEnemies,
    double eliteChance = 0.2,
    double bossChance = 0.05,
  }) {
    final result = _enemyService.generateRandomEncounter(
      playerLevel: playerLevel,
      maxEnemies: maxEnemies,
      eliteChance: eliteChance,
      bossChance: bossChance,
    );
    state = result;
  }

  void generateAreaEncounter({
    required String areaId,
    required int playerLevel,
    required int maxEnemies,
  }) {
    final result = _enemyService.generateAreaEncounter(
      areaId: areaId,
      playerLevel: playerLevel,
      maxEnemies: maxEnemies,
    );
    state = result;
  }

  void clearEncounter() {
    state = EnemyEncounterResult.empty;
  }
}
