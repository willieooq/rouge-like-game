// lib/shared/beans/battle/battle_end_result.dart
/// 戰鬥結束檢查結果 Bean
class BattleEndResult {
  final bool isEnded;
  final String resultType; // 使用 String 替代 enum 暫時

  const BattleEndResult({required this.isEnded, required this.resultType});

  BattleEndResult copyWith({bool? isEnded, String? resultType}) {
    return BattleEndResult(
      isEnded: isEnded ?? this.isEnded,
      resultType: resultType ?? this.resultType,
    );
  }
}
