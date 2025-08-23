// lib/models/skill/skills.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'skills.freezed.dart';
part 'skills.g.dart';

@freezed
abstract class Skills with _$Skills {
  const factory Skills({
    required String id,
    required String name,
    required int cost,
    required int damage,
    required String description,
    required String element,
    required String type, // "attack", "heal", "support"
    // 新增技能相關屬性
    @Default(0.0) double damageMultiplier, // 傷害倍率
    @Default([]) List<String> statusEffects, // 附加的狀態效果ID
    @Default(false) bool isAOE, // 是否為範圍攻擊
    @Default("enemy") String defaultTarget, // 默認目標類型
  }) = _Skills;

  const Skills._();

  // 技能類型判斷
  bool get isAttackSkill => type == "attack";

  bool get isHealSkill => type == "heal";

  bool get isSupportSkill => type == "support";

  factory Skills.fromJson(Map<String, dynamic> json) => _$SkillsFromJson(json);
}
