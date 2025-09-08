// lib/providers/character_provider.dart (重构后)
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dependency_injection.dart';
import '../core/interfaces/i_battle_service.dart';
import '../core/interfaces/i_skill_service.dart';
import '../models/character/character.dart';
import '../models/skill/skills.dart';
import 'battle_provider.dart';
import 'party_provider.dart';

/// CharacterProvider = Service Layer
///
/// 遵循 Dependency Inversion Principle：
/// 依赖抽象接口而非具体实现
class CharacterProvider extends StateNotifier<Character> {
  final Ref ref;
  final ISkillService _skillService;
  final IBattleService _battleService;

  CharacterProvider({
    required Character character,
    required this.ref,
    required ISkillService skillService,
    required IBattleService battleService,
  }) : _skillService = skillService,
       _battleService = battleService,
       super(character);

  // ================================
  // 技能使用相关方法
  // ================================

  /// 使用技能的主要方法（更新版 - 使用新的 Bean 接口）
  Future<bool> useSkill(String skillId) async {
    print('CharacterProvider: ${state.name} 开始使用技能 $skillId');

    // ✅ 使用注入的服务而非静态调用
    final skillCost = _skillService.getSkillCost(skillId);
    final partyNotifier = ref.read(partyProvider.notifier);

    // 检查Party是否有足够Cost
    if (!partyNotifier.canUseSkill(skillCost)) {
      print('CharacterProvider: cost 不足，无法使用技能');
      return false;
    }

    // 扣除Party Cost
    partyNotifier.useSkill(skillCost);
    print('CharacterProvider: 扣除 $skillCost cost');

    // ✅ 使用新的 Bean 接口执行技能
    try {
      final battleState = ref.read(battleProvider);
      if (battleState == null) {
        print('CharacterProvider: 战斗状态为空，无法执行技能');
        return false;
      }

      // 使用新的 Bean 接口
      final response = await _battleService.executePlayerSkillWithBeans(
        battleState,
        skillId,
        state.id,
        targetIds: [], // 可以根据技能类型和目标选择来设置
      );

      print('CharacterProvider: 技能执行结果，成功: ${response.success}');
      print('CharacterProvider: 消息: ${response.message}');

      // 应用技能效果到战斗状态
      if (response.success) {
        final battleNotifier = ref.read(battleProvider.notifier);
        // 这里需要一个新方法来应用 SkillExecutionResponse
        // battleNotifier.applySkillExecutionResponse(response);

        // 检查是否需要自动结束回合
        final party = ref.read(partyProvider);
        if (_skillService.shouldAutoEndTurn(party.currentTurnCost)) {
          print('CharacterProvider: 触发自动结束回合');
          battleNotifier.endPlayerTurn();
        }
      }

      return response.success;
    } catch (e) {
      print('CharacterProvider: 技能执行失败: $e');
      return false;
    }
  }

  /// 检查角色是否可以使用特定技能
  bool canUseSkill(String skillId) {
    // 1. 角色是否拥有这个技能
    if (!state.skillIds.contains(skillId)) return false;

    // 2. 技能是否存在
    if (!_skillService.hasSkill(skillId)) return false;

    // 3. Party是否有足够Cost
    final skillCost = _skillService.getSkillCost(skillId);
    final party = ref.read(partyProvider);

    return party.currentTurnCost >= skillCost;
  }

  /// 获取角色可用的技能列表
  List<String> getAvailableSkills() {
    return state.skillIds.where((skillId) => canUseSkill(skillId)).toList();
  }

  /// 获取角色的完整技能数据
  List<Skills> getSkillsData() {
    return _skillService.getCharacterSkills(state.skillIds);
  }

  /// 获取特定技能的数据
  Skills? getSkillData(String skillId) {
    if (!state.skillIds.contains(skillId)) return null;
    return _skillService.getSkill(skillId);
  }

  // ================================
  // 技能类型判断方法
  // ================================

  /// 检查技能是否为攻击类型
  bool isAttackSkill(String skillId) {
    final skill = _skillService.getSkill(skillId);
    return skill?.isAttackSkill ?? false;
  }

  /// 检查技能是否为治疗类型
  bool isHealSkill(String skillId) {
    final skill = _skillService.getSkill(skillId);
    return skill?.isHealSkill ?? false;
  }

  /// 检查技能是否为辅助类型
  bool isSupportSkill(String skillId) {
    final skill = _skillService.getSkill(skillId);
    return skill?.isSupportSkill ?? false;
  }

  // ================================
  // UI 辅助方法
  // ================================

  /// 计算技能的预期伤害（用于UI显示）
  int calculateExpectedDamage(String skillId) {
    final skill = _skillService.getSkill(skillId);
    if (skill == null || !skill.isAttackSkill) return 0;

    // 简化计算，不考虑BUFF和浮动值
    final baseAttack = state.attackPower.toDouble();
    final skillMultiplier = skill.damageMultiplier;
    final expectedDamage = baseAttack * (1 + skillMultiplier) + skill.damage;

    return expectedDamage.round();
  }

  /// 获取技能的目标类型描述
  String getSkillTargetDescription(String skillId) {
    final skill = _skillService.getSkill(skillId);
    if (skill == null) return '未知';

    if (skill.isAttackSkill) {
      return '敌人';
    } else if (skill.isHealSkill) {
      return '队伍';
    } else if (skill.isSupportSkill) {
      return skill.defaultTarget == 'enemy' ? '敌人' : '队伍';
    }

    return '未知';
  }

  /// 获取技能的Cost消耗
  int getSkillCost(String skillId) {
    return _skillService.getSkillCost(skillId);
  }

  /// 获取技能描述
  String getSkillDescription(String skillId) {
    final skill = _skillService.getSkill(skillId);
    return skill?.description ?? '未知技能';
  }

  /// 检查技能是否有状态效果
  bool hasStatusEffects(String skillId) {
    final skill = _skillService.getSkill(skillId);
    return skill?.statusEffects.isNotEmpty ?? false;
  }

  /// 获取技能的状态效果列表
  List<String> getSkillStatusEffects(String skillId) {
    final skill = _skillService.getSkill(skillId);
    return skill?.statusEffects ?? [];
  }

  // ================================
  // 高级技能操作
  // ================================

  /// 使用技能并指定目标
  Future<bool> useSkillWithTargets(
    String skillId,
    List<String> targetIds,
  ) async {
    print('CharacterProvider: ${state.name} 使用技能 $skillId，目标: $targetIds');

    final skillCost = _skillService.getSkillCost(skillId);
    final partyNotifier = ref.read(partyProvider.notifier);

    if (!partyNotifier.canUseSkill(skillCost)) {
      print('CharacterProvider: cost 不足，无法使用技能');
      return false;
    }

    partyNotifier.useSkill(skillCost);

    try {
      final battleState = ref.read(battleProvider);
      if (battleState == null) {
        print('CharacterProvider: 战斗状态为空，无法执行技能');
        return false;
      }

      final response = await _battleService.executePlayerSkillWithBeans(
        battleState,
        skillId,
        state.id,
        targetIds: targetIds,
      );

      print('CharacterProvider: 技能执行结果，成功: ${response.success}');
      return response.success;
    } catch (e) {
      print('CharacterProvider: 技能执行失败: $e');
      return false;
    }
  }

  /// 获取技能的有效目标
  List<String> getValidTargets(String skillId) {
    final battleState = ref.read(battleProvider);
    if (battleState == null) return [];

    final skill = _skillService.getSkill(skillId);
    if (skill == null) return [];

    return _skillService.getValidTargets(
      skill: skill,
      allies: battleState.party.characters,
      enemies: [battleState.enemy],
    );
  }

  /// 检查角色是否可以使用技能（考虑目标）
  bool canUseSkillWithContext(String skillId) {
    if (!canUseSkill(skillId)) return false;

    // 检查是否有有效目标
    final validTargets = getValidTargets(skillId);
    return validTargets.isNotEmpty;
  }
}

// ================================
// Provider 定义
// ================================

/// Character Provider Factory
/// 使用依赖注入模式创建 CharacterProvider
final characterProviderFamily =
    StateNotifierProvider.family<CharacterProvider, Character, Character>((
      ref,
      character,
    ) {
      // ✅ 注入依赖的服务
      final skillService = ref.watch(skillServiceProvider);
      final battleService = ref.watch(battleServiceProvider);

      return CharacterProvider(
        character: character,
        ref: ref,
        skillService: skillService,
        battleService: battleService,
      );
    });

// ================================
// 便利 Provider
// ================================

/// 获取当前活跃角色的技能数据
final currentCharacterSkillsProvider = Provider.family<List<Skills>, Character>(
  (ref, character) {
    final characterNotifier = ref.watch(
      characterProviderFamily(character).notifier,
    );
    return characterNotifier.getSkillsData();
  },
);

/// 获取角色可用技能列表
final availableSkillsProvider = Provider.family<List<String>, Character>((
  ref,
  character,
) {
  final characterNotifier = ref.watch(
    characterProviderFamily(character).notifier,
  );
  return characterNotifier.getAvailableSkills();
});

/// 检查特定技能是否可用
final canUseSkillProvider =
    Provider.family<bool, ({Character character, String skillId})>((
      ref,
      params,
    ) {
      final characterNotifier = ref.watch(
        characterProviderFamily(params.character).notifier,
      );
      return characterNotifier.canUseSkill(params.skillId);
    });

/// 获取技能预期伤害
final skillExpectedDamageProvider =
    Provider.family<int, ({Character character, String skillId})>((
      ref,
      params,
    ) {
      final characterNotifier = ref.watch(
        characterProviderFamily(params.character).notifier,
      );
      return characterNotifier.calculateExpectedDamage(params.skillId);
    });
