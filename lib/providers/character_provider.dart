import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character/character.dart';
import '../services/skill_service.dart';
import 'party_provider.dart'; // 需要存取Party

/// CharacterProvider = Service Layer
class CharacterProvider extends StateNotifier<Character> {
  final Ref ref;

  CharacterProvider(super.character, this.ref);

  // 使用技能的主要方法
  bool useSkill(String skillId) {
    final skillCost = SkillService.getSkillCost(skillId);
    final partyNotifier = ref.read(partyProvider.notifier);

    // 檢查Party是否有足夠Cost
    if (partyNotifier.canUseSkill(skillCost)) {
      // 扣除Party Cost
      partyNotifier.useSkill(skillCost);

      // 執行技能效果
      _executeSkillEffect(skillId);

      return true;
    }

    return false;
  }

  // 檢查角色是否可以使用特定技能
  bool canUseSkill(String skillId) {
    // 1. 角色是否擁有這個技能
    if (!state.skillIds.contains(skillId)) return false;

    // 2. Party是否有足夠Cost
    final skillCost = SkillService.getSkillCost(skillId);
    final party = ref.read(partyProvider);

    return party.currentTurnCost >= skillCost;
  }

  // 取得角色可用的技能列表
  List<String> getAvailableSkills() {
    return state.skillIds.where((skillId) => canUseSkill(skillId)).toList();
  }

  // 執行技能效果（暫時簡化）
  void _executeSkillEffect(String skillId) {
    final skill = SkillService.getSkill(skillId);
    if (skill != null) {
      print('${state.name} 使用了 ${skill.name}！造成 ${skill.damage} 傷害');
      // 這裡之後會加入實際的戰鬥邏輯
    }
  }
}

// Provider定義需要傳入ref
final characterProviderFamily =
    StateNotifierProvider.family<CharacterProvider, Character, Character>(
      (ref, character) => CharacterProvider(character, ref),
    );
