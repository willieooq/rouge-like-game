// lib/core/interfaces/i_status_service.dart
import '../../models/status/status_effect.dart';
import '../../shared/beans/status/status_application_result.dart';
import '../../shared/beans/status/status_effect_result.dart';
import '../../shared/beans/status/status_trigger_context.dart';

/// 狀態效果服務介面
///
/// 定義所有狀態效果相關的業務操作
/// 遵循 Interface Segregation Principle
abstract class IStatusService {
  // ===== 狀態效果週期處理 =====

  /// 處理回合開始時的狀態效果
  StatusEffectResult processTurnStart(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  });

  /// 處理回合結束時的狀態效果
  StatusEffectResult processTurnEnd(
    StatusEffectManager statusManager, {
    required bool isPlayer,
  });

  /// 清理戰鬥結束時的狀態效果
  void clearBattleEndEffects(StatusEffectManager statusManager);

  // ===== 狀態效果管理 =====

  /// 添加狀態效果
  void addStatusEffect(
    StatusEffectManager statusManager,
    StatusTemplate template, {
    int? customDuration,
    int stacks = 1,
  });

  /// 移除狀態效果
  bool removeStatusEffect(StatusEffectManager statusManager, String statusId);

  /// 引爆狀態效果
  int detonateStatus(StatusEffectManager statusManager, String statusId);

  /// 應用狀態效果到狀態管理器
  Future<StatusApplicationResult> applyStatusEffect(
    StatusEffectManager statusManager,
    String statusId, {
    required bool isPlayer,
    int? customDuration,
    int stacks = 1,
  });

  // ===== 觸發系統 =====

  /// 處理技能觸發的狀態效果
  StatusEffectResult processSkillTriggeredEffects(
    StatusEffectManager statusManager,
    StatusTrigger trigger, {
    StatusTriggerContext? context,
  });

  // ===== 查詢操作 =====

  /// 獲取所有可用的狀態效果ID
  List<String> getAvailableStatusEffects();

  /// 獲取狀態效果模板
  StatusTemplate? getStatusTemplate(String statusId);

  /// 檢查模板是否已載入
  bool get isTemplatesLoaded;
}
