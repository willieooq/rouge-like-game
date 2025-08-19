// lib/services/enemy_action_service.dart
import '../models/enemy/enemy.dart';
import '../models/enemy/enemy_action.dart';

/// 敵人行動服務
///
/// 遵循 Single Responsibility Principle：
/// 專門負責敵人行動的執行邏輯
class EnemyActionService {
  /// 執行敵人行動隊列
  List<EnemyActionResult> executeActionQueue(
    List<EnemyAction> actionQueue,
    EnemyAction? nullifiedAction,
    Enemy enemy,
  ) {
    final results = <EnemyActionResult>[];

    for (final action in actionQueue) {
      // 檢查行動是否被無效化
      if (nullifiedAction?.id == action.id) {
        results.add(action.createResult(wasExecuted: false, message: '行動被無效化'));
        continue;
      }

      // 執行行動
      final result = _executeAction(action, enemy);
      results.add(result);
    }

    return results;
  }

  /// 執行單個行動
  EnemyActionResult _executeAction(EnemyAction action, Enemy enemy) {
    switch (action.type) {
      case EnemyActionType.attack:
        return _executeAttackAction(action, enemy);
      case EnemyActionType.skill:
        return _executeSkillAction(action, enemy);
      case EnemyActionType.defend:
        return _executeDefendAction(action, enemy);
      case EnemyActionType.buff:
        return _executeBuffAction(action, enemy);
      case EnemyActionType.debuff:
        return _executeDebuffAction(action, enemy);
      case EnemyActionType.special:
        return _executeSpecialAction(action, enemy);
    }
  }

  /// 執行攻擊行動
  EnemyActionResult _executeAttackAction(EnemyAction action, Enemy enemy) {
    final damage = (enemy.attack * action.damageMultiplier).round();

    return action.createResult(
      wasExecuted: true,
      damageDealt: damage,
      message: '${enemy.name} 對玩家造成 $damage 點傷害',
    );
  }

  /// 執行技能行動
  EnemyActionResult _executeSkillAction(EnemyAction action, Enemy enemy) {
    // 技能執行邏輯，需要根據具體技能ID來處理
    return action.createResult(
      wasExecuted: true,
      message: '${enemy.name} 使用了技能：${action.name}',
    );
  }

  /// 執行防禦行動
  EnemyActionResult _executeDefendAction(EnemyAction action, Enemy enemy) {
    return action.createResult(
      wasExecuted: true,
      statusEffectsApplied: ['defense_boost'],
      message: '${enemy.name} 進入防禦狀態',
    );
  }

  /// 執行增益行動
  EnemyActionResult _executeBuffAction(EnemyAction action, Enemy enemy) {
    return action.createResult(
      wasExecuted: true,
      statusEffectsApplied: ['attack_boost'],
      message: '${enemy.name} 獲得了增益效果',
    );
  }

  /// 執行減益行動
  EnemyActionResult _executeDebuffAction(EnemyAction action, Enemy enemy) {
    return action.createResult(
      wasExecuted: true,
      statusEffectsApplied: ['attack_down'],
      message: '${enemy.name} 對玩家施加了減益效果',
    );
  }

  /// 執行特殊行動
  EnemyActionResult _executeSpecialAction(EnemyAction action, Enemy enemy) {
    return action.createResult(
      wasExecuted: true,
      message: '${enemy.name} 執行了特殊行動：${action.name}',
    );
  }
}
