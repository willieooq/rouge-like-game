// lib/services/skill_service.dart
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../models/skill/skills.dart';

class SkillService {
  static Map<String, Skills>? _skillCache;
  static final Random _random = Random();

  // 載入技能數據
  static Future<void> loadSkills() async {
    if (_skillCache != null) return; // 已載入過

    final String jsonString = await rootBundle.loadString(
      'assets/data/skills.json',
    );
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    _skillCache = {};
    jsonData.forEach((key, value) {
      _skillCache![key] = Skills.fromJson(value);
    });
  }

  // 取得技能資料
  static Skills? getSkill(String skillId) {
    return _skillCache?[skillId];
  }

  // 取得技能Cost
  static int getSkillCost(String skillId) {
    return getSkill(skillId)?.cost ?? 0;
  }

  // 取得角色的技能列表
  static List<Skills> getCharacterSkills(List<String> skillIds) {
    return skillIds
        .map((id) => getSkill(id))
        .where((skill) => skill != null)
        .cast<Skills>()
        .toList();
  }

  // 檢查技能是否存在
  static bool hasSkill(String skillId) {
    return _skillCache?.containsKey(skillId) ?? false;
  }

  // 計算技能傷害
  static int calculateSkillDamage(
    Skills skill,
    int casterAttackPower,
    double buffMultiplier,
  ) {
    // 傷害公式：角色攻擊力 * (1 + 技能倍率) * BUFF倍率 * 浮動值
    final baseAttack = casterAttackPower.toDouble();
    final skillMultiplier = skill.damageMultiplier;
    final randomFactor = 0.95 + (_random.nextDouble() * 0.05); // 0.95~1.0

    final totalDamage =
        baseAttack * (1 + skillMultiplier) * buffMultiplier * randomFactor;

    // 如果技能有固定傷害值，加上固定傷害
    final finalDamage = totalDamage + skill.damage;

    return finalDamage.round();
  }

  // 計算最終傷害（考慮防禦）
  static int calculateFinalDamage(int skillDamage, int enemyDefense) {
    // 防禦計算：技能傷害 - 敵人防禦值
    final finalDamage = (skillDamage - enemyDefense).clamp(1, skillDamage);
    return finalDamage;
  }

  // 自動結束回合檢查
  static bool shouldAutoEndTurn(int currentCost) {
    // 預留函式：當cost歸零時是否自動結束回合
    // 之後可以從設置中讀取
    return currentCost <= 0;
  }
}
