// lib/shared/beans/status/status_effect_result.dart
/// 狀態效果處理結果 Bean
class StatusEffectResult {
  final int dotDamage;
  final int hotHealing;
  final List<String> triggeredEffects;

  const StatusEffectResult({
    required this.dotDamage,
    required this.hotHealing,
    required this.triggeredEffects,
  });

  StatusEffectResult copyWith({
    int? dotDamage,
    int? hotHealing,
    List<String>? triggeredEffects,
  }) {
    return StatusEffectResult(
      dotDamage: dotDamage ?? this.dotDamage,
      hotHealing: hotHealing ?? this.hotHealing,
      triggeredEffects: triggeredEffects ?? this.triggeredEffects,
    );
  }

  static const StatusEffectResult empty = StatusEffectResult(
    dotDamage: 0,
    hotHealing: 0,
    triggeredEffects: [],
  );
}
