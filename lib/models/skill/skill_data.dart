import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_data.freezed.dart';
part 'skill_data.g.dart';

@freezed
abstract class SkillData with _$SkillData {
  const factory SkillData({
    required String id,
    required String name,
    required int cost,
    required int damage,
    required String description,
    required String element, // 技能屬性
    required String type, // attack/heal/support
  }) = _SkillData;

  factory SkillData.fromJson(Map<String, dynamic> json) =>
      _$SkillDataFromJson(json);
}
