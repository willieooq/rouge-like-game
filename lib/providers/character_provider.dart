// lib/providers/character_provider.dart (更新版)
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character/character.dart';
import '../models/skill/skills.dart';
import '../services/skill_service.dart';
import 'battle_provider.dart';
import 'party_provider.dart';

/// CharacterProvider = Service Layer
class CharacterProvider extends StateNotifier<Character> {
  final Ref ref;

  CharacterProvider(super.character, this.ref);

  // 使用技能的主要方法（更新版 - 異步）
  Future<bool> useSkill(String skillId) async {
    print('CharacterProvider: ${state.name} 開始使用技能 $skillId');

    final skillCost = SkillService.getSkillCost(skillId);
    final partyNotifier = ref.read(partyProvider.notifier);

    // 檢查Party是否有足夠Cost
    if (!partyNotifier.canUseSkill(skillCost)) {
      print('CharacterProvider: cost 不足，無法使用技能');
      return false;
    }

    // 扣除Party Cost
    partyNotifier.useSkill(skillCost);
    print('CharacterProvider: 扣除 $skillCost cost');

    // 委託給 BattleProvider 執行實際技能效果（使用 await）
    final battleNotifier = ref.read(battleProvider.notifier);
    print('CharacterProvider: 開始調用 BattleProvider.executePlayerSkill');

    final result = await battleNotifier.executePlayerSkill(
      skillId,
      casterId: state.id,
    );
    print('CharacterProvider: BattleProvider 返回結果，成功: ${result.success}');

    // 檢查是否需要自動結束回合
    final party = ref.read(partyProvider);
    if (SkillService.shouldAutoEndTurn(party.currentTurnCost)) {
      print('CharacterProvider: 觸發自動結束回合');
      battleNotifier.endPlayerTurn();
    }

    return result.success;
  }

  // 檢查角色是否可以使用特定技能
  bool canUseSkill(String skillId) {
    // 1. 角色是否擁有這個技能
    if (!state.skillIds.contains(skillId)) return false;

    // 2. 技能是否存在
    if (!SkillService.hasSkill(skillId)) return false;

    // 3. Party是否有足夠Cost
    final skillCost = SkillService.getSkillCost(skillId);
    final party = ref.read(partyProvider);

    return party.currentTurnCost >= skillCost;
  }

  // 取得角色可用的技能列表
  List<String> getAvailableSkills() {
    return state.skillIds.where((skillId) => canUseSkill(skillId)).toList();
  }

  // 取得角色的完整技能數據
  List<Skills> getSkillsData() {
    return SkillService.getCharacterSkills(state.skillIds);
  }

  // 取得特定技能的數據
  Skills? getSkillData(String skillId) {
    if (!state.skillIds.contains(skillId)) return null;
    return SkillService.getSkill(skillId);
  }

  // 檢查技能是否為攻擊類型
  bool isAttackSkill(String skillId) {
    final skill = SkillService.getSkill(skillId);
    return skill?.isAttackSkill ?? false;
  }

  // 檢查技能是否為治療類型
  bool isHealSkill(String skillId) {
    final skill = SkillService.getSkill(skillId);
    return skill?.isHealSkill ?? false;
  }

  // 檢查技能是否為輔助類型
  bool isSupportSkill(String skillId) {
    final skill = SkillService.getSkill(skillId);
    return skill?.isSupportSkill ?? false;
  }

  // 計算技能的預期傷害（用於UI顯示）
  int calculateExpectedDamage(String skillId) {
    final skill = SkillService.getSkill(skillId);
    if (skill == null || !skill.isAttackSkill) return 0;

    // 簡化計算，不考慮BUFF和浮動值
    final baseAttack = state.attackPower.toDouble();
    final skillMultiplier = skill.damageMultiplier;
    final expectedDamage = baseAttack * (1 + skillMultiplier) + skill.damage;

    return expectedDamage.round();
  }

  // 取得技能的目標類型描述
  String getSkillTargetDescription(String skillId) {
    final skill = SkillService.getSkill(skillId);
    if (skill == null) return '未知';

    if (skill.isAttackSkill) {
      return '敵人';
    } else if (skill.isHealSkill) {
      return '隊伍';
    } else if (skill.isSupportSkill) {
      return skill.defaultTarget == 'enemy' ? '敵人' : '隊伍';
    }

    return '未知';
  }

  // 移除已廢棄的執行技能效果方法
  // 原本的 _executeSkillEffect 方法已被新的技能系統取代
}

final characterProviderFamily =
    StateNotifierProvider.family<CharacterProvider, Character, Character>(
      (ref, character) => CharacterProvider(character, ref),
    );
