// lib/models/skill/skill_execution_result.dart

/// 技能執行結果
class SkillExecutionResult {
  final String skillId;
  final String casterId;
  final List<EffectChain> effectChains;
  final bool success;
  final String message;

  const SkillExecutionResult({
    required this.skillId,
    required this.casterId,
    required this.effectChains,
    required this.success,
    required this.message,
  });
}

/// 單個目標的效果鏈
class EffectChain {
  final String targetId;
  final EffectIntent originalIntent;
  final EffectResult processedResult;
  final List<TriggeredEvent> triggeredEvents;

  const EffectChain({
    required this.targetId,
    required this.originalIntent,
    required this.processedResult,
    required this.triggeredEvents,
  });
}

/// 原始效果意圖
class EffectIntent {
  final EffectType type;
  final int baseValue;
  final Map<String, dynamic> metadata;

  const EffectIntent({
    required this.type,
    required this.baseValue,
    this.metadata = const {},
  });
}

/// 處理後的效果結果
class EffectResult {
  final EffectType type;
  final int actualValue;
  final bool wasModified;
  final List<String> modificationReasons;

  const EffectResult({
    required this.type,
    required this.actualValue,
    this.wasModified = false,
    this.modificationReasons = const [],
  });
}

/// 觸發的事件
class TriggeredEvent {
  final String eventType;
  final String sourceId;
  final Map<String, dynamic> eventData;

  const TriggeredEvent({
    required this.eventType,
    required this.sourceId,
    required this.eventData,
  });
}

/// 效果類型
enum EffectType { damage, heal, statusEffect, shield }

/// 目標化意圖
class TargetedIntent {
  final String targetId;
  final EffectIntent intent;

  const TargetedIntent({required this.targetId, required this.intent});
}
