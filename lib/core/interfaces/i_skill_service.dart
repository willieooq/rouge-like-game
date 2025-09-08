// ================================
// lib/core/interfaces/i_skill_service.dart
// ================================

import '../../models/character/character.dart';
import '../../models/enemy/enemy.dart';
import '../../models/skill/skills.dart';
import '../../shared/beans/skill/skill_execution_request.dart';
import '../../shared/beans/skill/skill_execution_response.dart';

/// 技能服務接口
abstract class ISkillService {
  /// 載入技能數據
  Future<void> loadSkills();

  /// 取得技能資料
  Skills? getSkill(String skillId);

  /// 取得技能Cost
  int getSkillCost(String skillId);

  /// 取得角色的技能列表
  List<Skills> getCharacterSkills(List<String> skillIds);

  /// 檢查技能是否存在
  bool hasSkill(String skillId);

  /// 執行技能（新的Bean接口）
  Future<SkillExecutionResponse> executeSkill(SkillExecutionRequest request);

  /// 計算技能傷害
  int calculateSkillDamage(
    Skills skill,
    int casterAttackPower,
    double buffMultiplier,
  );

  /// 計算最終傷害（考慮防禦）
  int calculateFinalDamage(int skillDamage, int enemyDefense);

  /// 自動結束回合檢查
  bool shouldAutoEndTurn(int currentCost);

  /// 驗證技能是否可以使用
  bool canUseSkill({
    required String skillId,
    required Character caster,
    required int currentCost,
  });

  /// 獲取技能有效目標
  List<String> getValidTargets({
    required Skills skill,
    required List<Character> allies,
    required List<Enemy> enemies,
  });
}
