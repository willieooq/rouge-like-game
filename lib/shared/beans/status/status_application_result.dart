// lib/shared/beans/status/status_application_result.dart
import '../../../models/status/status_effect.dart';

/// 狀態效果應用結果 Bean
class StatusApplicationResult {
  final StatusEffectManager statusManager;
  final bool success;
  final String message;

  const StatusApplicationResult({
    required this.statusManager,
    required this.success,
    required this.message,
  });

  StatusApplicationResult copyWith({
    StatusEffectManager? statusManager,
    bool? success,
    String? message,
  }) {
    return StatusApplicationResult(
      statusManager: statusManager ?? this.statusManager,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }
}
