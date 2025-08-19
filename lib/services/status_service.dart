// lib/services/status_service.dart
import '../models/status/status_effect.dart';

/// 狀態效果結果
class StatusEffectResult {
  final int dotDamage;
  final int hotHealing;
  final List<String> triggeredEffects;

  const StatusEffectResult({
    required this.dotDamage,
    required this.hotHealing,
    required this.triggeredEffects,
  });

  static const StatusEffectResult empty = StatusEffectResult(
    dotDamage: 0,
    hotHealing: 0,
    triggeredEffects: [],
  );
}

/// 狀態服務
///
/// 遵循 Single Responsibility Principle：
/// 專門負責狀態效果的處理邏輯
class StatusService {
  /// 處理回合開始時的狀態效果
  StatusEffectResult processTurnStart(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  }) {
    final result = statusManager.processTurnStart();
    return _convertToStatusEffectResult(result);
  }

  /// 處理回合結束時的狀態效果
  StatusEffectResult processTurnEnd(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  }) {
    final result = statusManager.processTurnEnd();
    return _convertToStatusEffectResult(result);
  }

  /// 清理戰鬥結束時的狀態效果
  void clearBattleEndEffects(StatusEffectManager statusManager) {
    statusManager.clearBattleEndEffects();
  }

  /// 添加狀態效果
  void addStatusEffect(
    StatusEffectManager statusManager,
    StatusTemplate template, {
    int? customDuration,
    int stacks = 1,
  }) {
    statusManager.addStatusEffect(
      template,
      customDuration: customDuration,
      stacks: stacks,
    );
  }

  /// 移除狀態效果
  bool removeStatusEffect(StatusEffectManager statusManager, String statusId) {
    return statusManager.removeStatusEffect(statusId);
  }

  /// 引爆狀態效果
  int detonateStatus(StatusEffectManager statusManager, String statusId) {
    return statusManager.detonateStatus(statusId);
  }

  /// 轉換狀態管理器結果為服務結果
  StatusEffectResult _convertToStatusEffectResult(Map<String, dynamic> result) {
    return StatusEffectResult(
      dotDamage: result['dotDamage'] as int? ?? 0,
      hotHealing: result['hotHealing'] as int? ?? 0,
      triggeredEffects: List<String>.from(result['triggeredEffects'] ?? []),
    );
  }
}
