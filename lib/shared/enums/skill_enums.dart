/// 效果類型枚舉
enum EffectType {
  damage,
  heal,
  statusEffect,
  shield,
  costReduction,
  buff,
  debuff,
}

/// 技能目標類型枚舉
enum SkillTargetType { self, ally, allAllies, enemy, allEnemies, any }
