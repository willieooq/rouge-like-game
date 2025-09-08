// lib/shared/beans/skill/skill_execution_response.dart
// ================================

import 'effect_chain_bean.dart';

/// 技能執行響應 Bean
class SkillExecutionResponse {
  final String skillId;
  final String casterId;
  final List<EffectChainBean> effectChains;
  final bool success;
  final String message;
  final Map<String, dynamic>? metadata;

  const SkillExecutionResponse({
    required this.skillId,
    required this.casterId,
    required this.effectChains,
    required this.success,
    required this.message,
    this.metadata,
  });

  SkillExecutionResponse copyWith({
    String? skillId,
    String? casterId,
    List<EffectChainBean>? effectChains,
    bool? success,
    String? message,
    Map<String, dynamic>? metadata,
  }) {
    return SkillExecutionResponse(
      skillId: skillId ?? this.skillId,
      casterId: casterId ?? this.casterId,
      effectChains: effectChains ?? this.effectChains,
      success: success ?? this.success,
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
    );
  }
}
