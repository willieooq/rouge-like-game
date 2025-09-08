// lib/shared/beans/skill/effect_chain_bean.dart
// ================================

import '../../../models/skill/skill_execution_result.dart';

/// 效果鏈 Bean
class EffectChainBean {
  final String targetId;
  final EffectIntentBean originalIntent;
  final EffectResultBean processedResult;
  final List<TriggeredEventBean> triggeredEvents;

  const EffectChainBean({
    required this.targetId,
    required this.originalIntent,
    required this.processedResult,
    required this.triggeredEvents,
  });

  EffectChainBean copyWith({
    String? targetId,
    EffectIntentBean? originalIntent,
    EffectResultBean? processedResult,
    List<TriggeredEventBean>? triggeredEvents,
  }) {
    return EffectChainBean(
      targetId: targetId ?? this.targetId,
      originalIntent: originalIntent ?? this.originalIntent,
      processedResult: processedResult ?? this.processedResult,
      triggeredEvents: triggeredEvents ?? this.triggeredEvents,
    );
  }
}

/// 效果意圖 Bean
class EffectIntentBean {
  final EffectType type;
  final int baseValue;
  final Map<String, dynamic> metadata;

  const EffectIntentBean({
    required this.type,
    required this.baseValue,
    this.metadata = const {},
  });

  EffectIntentBean copyWith({
    EffectType? type,
    int? baseValue,
    Map<String, dynamic>? metadata,
  }) {
    return EffectIntentBean(
      type: type ?? this.type,
      baseValue: baseValue ?? this.baseValue,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// 效果結果 Bean
class EffectResultBean {
  final EffectType type;
  final int actualValue;
  final bool wasModified;
  final List<String> modificationReasons;

  const EffectResultBean({
    required this.type,
    required this.actualValue,
    this.wasModified = false,
    this.modificationReasons = const [],
  });

  EffectResultBean copyWith({
    EffectType? type,
    int? actualValue,
    bool? wasModified,
    List<String>? modificationReasons,
  }) {
    return EffectResultBean(
      type: type ?? this.type,
      actualValue: actualValue ?? this.actualValue,
      wasModified: wasModified ?? this.wasModified,
      modificationReasons: modificationReasons ?? this.modificationReasons,
    );
  }
}

/// 觸發事件 Bean
class TriggeredEventBean {
  final String eventType;
  final String sourceId;
  final Map<String, dynamic> eventData;

  const TriggeredEventBean({
    required this.eventType,
    required this.sourceId,
    required this.eventData,
  });

  TriggeredEventBean copyWith({
    String? eventType,
    String? sourceId,
    Map<String, dynamic>? eventData,
  }) {
    return TriggeredEventBean(
      eventType: eventType ?? this.eventType,
      sourceId: sourceId ?? this.sourceId,
      eventData: eventData ?? this.eventData,
    );
  }
}
