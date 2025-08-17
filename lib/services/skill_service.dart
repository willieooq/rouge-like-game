import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/skill/skill_data.dart';

class SkillService {
  static Map<String, SkillData>? _skillCache;

  // 載入技能數據
  static Future<void> loadSkills() async {
    if (_skillCache != null) return; // 已載入過

    final String jsonString = await rootBundle.loadString(
      'assets/data/skills.json',
    );
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    _skillCache = {};
    jsonData.forEach((key, value) {
      _skillCache![key] = SkillData.fromJson(value);
    });
  }

  // 取得技能資料
  static SkillData? getSkill(String skillId) {
    return _skillCache?[skillId];
  }

  // 取得技能Cost
  static int getSkillCost(String skillId) {
    return getSkill(skillId)?.cost ?? 0;
  }

  // 取得角色的技能列表
  static List<SkillData> getCharacterSkills(List<String> skillIds) {
    return skillIds
        .map((id) => getSkill(id))
        .where((skill) => skill != null)
        .cast<SkillData>()
        .toList();
  }

  // 檢查技能是否存在
  static bool hasSkill(String skillId) {
    return _skillCache?.containsKey(skillId) ?? false;
  }
}
