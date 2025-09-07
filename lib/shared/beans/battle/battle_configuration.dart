// lib/shared/beans/battle/battle_configuration.dart
import 'package:rouge_project/models/enemy/enemy.dart';
import 'package:rouge_project/models/party/party.dart';

/// 戰鬥配置 Bean
class BattleConfiguration {
  final Party party; // 暫時用ID列表，避免循環依賴
  final Enemy enemy;
  final bool canEscape;
  final Map<String, dynamic>? additionalConfig;

  const BattleConfiguration({
    required this.party,
    required this.enemy,
    this.canEscape = true,
    this.additionalConfig,
  });

  BattleConfiguration copyWith({
    Party? party,
    Enemy? enemy,
    bool? canEscape,
    Map<String, dynamic>? additionalConfig,
  }) {
    return BattleConfiguration(
      party: party ?? this.party,
      enemy: enemy ?? this.enemy,
      canEscape: canEscape ?? this.canEscape,
      additionalConfig: additionalConfig ?? this.additionalConfig,
    );
  }
}
