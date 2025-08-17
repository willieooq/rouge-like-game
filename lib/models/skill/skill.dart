import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

// 先定義SkillType enum
enum SkillType {
  @JsonValue('attack') // JSON序列化時的值
  attack('攻擊'),

  @JsonValue('heal')
  heal('治療'),

  @JsonValue('support')
  support('輔助');

  const SkillType(this.displayName);
  final String displayName;

  bool get isOffensive => this == SkillType.attack;
  bool get isDefensive => this == SkillType.heal || this == SkillType.support;
}

@freezed
abstract class Skill with _$Skill {
  const factory Skill({
    required String id,
    required String name,
    required String description,
    required int cost,
    required int baseDamage,
    required String element,
    required SkillType type,
  }) = _Skill;

  const Skill._();

  // 計算實際傷害
  int calculateDamage(int attackerPower) {
    return (baseDamage * attackerPower * 0.1).round();
  }

  // Getter methods
  bool get isAttackSkill => type == SkillType.attack;
  bool get isHealSkill => type == SkillType.heal;
  bool get isSupportSkill => type == SkillType.support;
  double get costEfficiency => cost > 0 ? baseDamage / cost : 0;

  // JSON序列化支持
  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
