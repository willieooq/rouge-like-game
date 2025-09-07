// lib/shared/beans/status/status_trigger_context.dart
/// 狀態觸發上下文 Bean
class StatusTriggerContext {
  final Map<String, dynamic> data;

  const StatusTriggerContext({this.data = const {}});

  /// 獲取傷害數值
  int? get damageDealt => data['damageDealt'] as int?;

  /// 獲取治療數值
  int? get healingReceived => data['healingReceived'] as int?;

  /// 獲取技能ID
  String? get skillId => data['skillId'] as String?;

  /// 獲取施法者ID
  String? get casterId => data['casterId'] as String?;

  StatusTriggerContext copyWith({Map<String, dynamic>? data}) {
    return StatusTriggerContext(data: data ?? this.data);
  }

  /// 建立傷害觸發上下文
  factory StatusTriggerContext.damage(int damageDealt) {
    return StatusTriggerContext(data: {'damageDealt': damageDealt});
  }

  /// 建立治療觸發上下文
  factory StatusTriggerContext.healing(int healingReceived) {
    return StatusTriggerContext(data: {'healingReceived': healingReceived});
  }

  /// 建立技能觸發上下文
  factory StatusTriggerContext.skill({
    required String skillId,
    required String casterId,
    int? damageDealt,
    int? healingReceived,
  }) {
    return StatusTriggerContext(
      data: {
        'skillId': skillId,
        'casterId': casterId,
        if (damageDealt != null) 'damageDealt': damageDealt,
        if (healingReceived != null) 'healingReceived': healingReceived,
      },
    );
  }
}
