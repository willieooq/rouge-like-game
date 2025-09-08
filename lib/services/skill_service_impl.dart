// lib/services/skill_service_impl.dart
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../core/interfaces/i_skill_service.dart';
import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/skill/skill_execution_result.dart';
import '../models/skill/skills.dart';
import '../shared/beans/skill/effect_chain_bean.dart';
import '../shared/beans/skill/skill_execution_request.dart';
import '../shared/beans/skill/skill_execution_response.dart';

/// 技能服務實現
///
/// 遵循 Single Responsibility Principle：
/// 專門負責技能相關的業務邏輯
///
/// 遵循 Dependency Inversion Principle：
/// 實現 ISkillService 抽象接口
class SkillServiceImpl implements ISkillService {
  static Map<String, Skills>? _skillCache;
  static final Random _random = Random();

  @override
  Future<void> loadSkills() async {
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

  @override
  Skills? getSkill(String skillId) {
    return _skillCache?[skillId];
  }

  @override
  int getSkillCost(String skillId) {
    return getSkill(skillId)?.cost ?? 0;
  }

  @override
  List<Skills> getCharacterSkills(List<String> skillIds) {
    return skillIds
        .map((id) => getSkill(id))
        .where((skill) => skill != null)
        .cast<Skills>()
        .toList();
  }

  @override
  bool hasSkill(String skillId) {
    return _skillCache?.containsKey(skillId) ?? false;
  }

  @override
  Future<SkillExecutionResponse> executeSkill(
    SkillExecutionRequest request,
  ) async {
    print('SkillService: 開始執行技能 ${request.skillId}，施法者: ${request.casterId}');

    // 1. 載入技能數據
    final skill = getSkill(request.skillId);
    if (skill == null) {
      print('SkillService: 技能不存在 - ${request.skillId}');
      return SkillExecutionResponse(
        skillId: request.skillId,
        casterId: request.casterId,
        effectChains: [],
        success: false,
        message: '技能不存在：${request.skillId}',
      );
    }

    print('SkillService: 找到技能 ${skill.name}，類型: ${skill.type}');

    // 2. 找到施法者
    Character? caster;
    try {
      caster = request.allies.firstWhere((c) => c.id == request.casterId);
      print('SkillService: 找到施法者 ${caster.name}，攻擊力: ${caster.attackPower}');
    } catch (e) {
      // 如果找不到指定的施法者，使用第一個角色（如果存在）
      if (request.allies.isNotEmpty) {
        caster = request.allies.first;
        print('SkillService: 找不到指定施法者，使用 ${caster.name}');
      }
    }

    if (caster == null) {
      print('SkillService: 無可用的施法者');
      return SkillExecutionResponse(
        skillId: request.skillId,
        casterId: request.casterId,
        effectChains: [],
        success: false,
        message: '找不到施法者',
      );
    }

    // 3. 計算技能的原始效果意圖
    final intents = _calculateSkillIntents(skill, caster, request);
    print('SkillService: 計算出 ${intents.length} 個效果意圖');

    // 4. 對每個目標處理效果鏈
    final effectChains = <EffectChainBean>[];
    for (final intent in intents) {
      print(
        'SkillService: 處理效果鏈 - 目標: ${intent.targetId}, 類型: ${intent.intent.type}, 基礎值: ${intent.intent.baseValue}',
      );
      final chain = _processEffectChain(request, intent);
      effectChains.add(chain);
      print(
        'SkillService: 效果鏈處理完成 - 實際值: ${chain.processedResult.actualValue}',
      );
    }

    print('SkillService: 技能執行完成，成功: true');
    return SkillExecutionResponse(
      skillId: request.skillId,
      casterId: request.casterId,
      effectChains: effectChains,
      success: true,
      message: '${caster.name} 使用了 ${skill.name}',
    );
  }

  @override
  int calculateSkillDamage(
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

  @override
  int calculateFinalDamage(int skillDamage, int enemyDefense) {
    // 防禦計算：技能傷害 - 敵人防禦值
    final finalDamage = (skillDamage - enemyDefense).clamp(1, skillDamage);
    return finalDamage;
  }

  @override
  bool shouldAutoEndTurn(int currentCost) {
    // 預留函式：當cost歸零時是否自動結束回合
    // 之後可以從設置中讀取
    return currentCost <= 0;
  }

  @override
  bool canUseSkill({
    required String skillId,
    required Character caster,
    required int currentCost,
  }) {
    final skill = getSkill(skillId);
    if (skill == null) return false;

    // 檢查cost是否足夠
    final requiredCost = getSkillCost(skillId);
    return currentCost >= requiredCost;
  }

  @override
  List<String> getValidTargets({
    required Skills skill,
    required List<Character> allies,
    required List<Enemy> enemies,
  }) {
    final targets = <String>[];

    switch (skill.defaultTarget) {
      case "self":
        // 只能選擇自己，這裡暫時返回第一個盟友的ID
        if (allies.isNotEmpty) targets.add(allies.first.id);
        break;
      case "ally":
        // 可以選擇任何活著的盟友
        targets.addAll(allies.map((a) => a.id));
        break;
      case "enemy":
        // 可以選擇任何活著的敵人
        targets.addAll(
          enemies.where((enemy) => !enemy.isDead).map((e) => e.id),
        );
        break;
      case "all":
        // 可以選擇任何目標
        targets.addAll(allies.map((a) => a.id));
        targets.addAll(
          enemies.where((enemy) => !enemy.isDead).map((e) => e.id),
        );
        break;
      default:
        // 默認為敵人
        targets.addAll(
          enemies.where((enemy) => !enemy.isDead).map((e) => e.id),
        );
    }

    return targets;
  }

  // ===== 私有方法 =====

  /// 計算技能的原始效果意圖
  List<TargetedIntentBean> _calculateSkillIntents(
    Skills skill,
    Character caster,
    SkillExecutionRequest request,
  ) {
    final intents = <TargetedIntentBean>[];

    if (skill.isAttackSkill) {
      // 攻擊技能
      final buffMultiplier = 1.0; // 暫時設為1.0，之後可以從狀態管理中獲取
      final skillDamage = calculateSkillDamage(
        skill,
        caster.attackPower,
        buffMultiplier,
      );

      // 確定目標敵人
      final targetEnemies = request.targetIds.isNotEmpty
          ? request.enemies.where((e) => request.targetIds.contains(e.id))
          : request.enemies.where((e) => !e.isDead); // 敵人使用isDead

      for (final enemy in targetEnemies) {
        intents.add(
          TargetedIntentBean(
            targetId: enemy.id,
            intent: EffectIntentBean(
              type: EffectType.damage,
              baseValue: skillDamage,
              metadata: {
                'element': skill.element,
                'skillId': skill.id,
                'casterId': caster.id,
              },
            ),
          ),
        );
      }

      // 如果技能有附加狀態效果
      for (final statusId in skill.statusEffects) {
        for (final enemy in targetEnemies) {
          intents.add(
            TargetedIntentBean(
              targetId: enemy.id,
              intent: EffectIntentBean(
                type: EffectType.statusEffect,
                baseValue: 1,
                metadata: {
                  'statusId': statusId,
                  'skillId': skill.id,
                  'casterId': caster.id,
                },
              ),
            ),
          );
        }
      }
    } else if (skill.isHealSkill) {
      // 治療技能
      intents.add(
        TargetedIntentBean(
          targetId: 'party',
          intent: EffectIntentBean(
            type: EffectType.heal,
            baseValue: skill.damage, // 治療量直接使用damage值
            metadata: {'skillId': skill.id, 'casterId': caster.id},
          ),
        ),
      );
    } else if (skill.isSupportSkill) {
      // 輔助技能 - 施加狀態效果
      for (final statusId in skill.statusEffects) {
        intents.add(
          TargetedIntentBean(
            targetId: skill.defaultTarget == "enemy"
                ? (request.enemies.isNotEmpty
                      ? request.enemies.first.id
                      : 'unknown')
                : 'party',
            intent: EffectIntentBean(
              type: EffectType.statusEffect,
              baseValue: 1, // 狀態效果層數
              metadata: {
                'statusId': statusId,
                'skillId': skill.id,
                'casterId': caster.id,
              },
            ),
          ),
        );
      }
    }

    return intents;
  }

  /// 處理單個效果鏈
  EffectChainBean _processEffectChain(
    SkillExecutionRequest request,
    TargetedIntentBean targetedIntent,
  ) {
    final targetId = targetedIntent.targetId;
    final intent = targetedIntent.intent;

    // 目標對象處理效果
    final processedResult = _processEffectOnTarget(request, targetId, intent);

    // 檢查觸發的後續事件
    final triggeredEvents = _checkTriggeredEvents(
      request,
      targetId,
      processedResult,
    );

    return EffectChainBean(
      targetId: targetId,
      originalIntent: intent,
      processedResult: processedResult,
      triggeredEvents: triggeredEvents,
    );
  }

  /// 目標處理效果
  EffectResultBean _processEffectOnTarget(
    SkillExecutionRequest request,
    String targetId,
    EffectIntentBean intent,
  ) {
    // 檢查是否為敵人目標
    final isEnemyTarget = request.enemies.any((e) => e.id == targetId);

    if (isEnemyTarget) {
      return _processEffectOnEnemy(request, targetId, intent);
    } else if (targetId == 'party') {
      return _processEffectOnParty(request, intent);
    } else {
      return _processEffectOnCharacter(request, targetId, intent);
    }
  }

  /// 敵人處理效果
  EffectResultBean _processEffectOnEnemy(
    SkillExecutionRequest request,
    String enemyId,
    EffectIntentBean intent,
  ) {
    final enemy = request.enemies.firstWhere((e) => e.id == enemyId);

    switch (intent.type) {
      case EffectType.damage:
        // 應用防禦計算
        final skillDamage = intent.baseValue;
        final actualDamage = calculateFinalDamage(skillDamage, enemy.defense);

        return EffectResultBean(
          type: EffectType.damage,
          actualValue: actualDamage,
          wasModified: actualDamage != skillDamage,
          modificationReasons: actualDamage != skillDamage
              ? ['defense_reduction']
              : [],
        );

      case EffectType.statusEffect:
        // 對敵人施加狀態效果
        final statusId = intent.metadata['statusId'] as String;
        return EffectResultBean(
          type: EffectType.statusEffect,
          actualValue: intent.baseValue,
          modificationReasons: ['status_applied:$statusId'],
        );

      default:
        return EffectResultBean(type: intent.type, actualValue: 0);
    }
  }

  /// 隊伍處理效果
  EffectResultBean _processEffectOnParty(
    SkillExecutionRequest request,
    EffectIntentBean intent,
  ) {
    switch (intent.type) {
      case EffectType.heal:
        // 治療效果
        final actualHealing = intent.baseValue; // 暫時不加修正
        return EffectResultBean(
          type: EffectType.heal,
          actualValue: actualHealing,
          wasModified: false,
        );

      case EffectType.statusEffect:
        // 對隊伍施加狀態效果
        final statusId = intent.metadata['statusId'] as String;
        return EffectResultBean(
          type: EffectType.statusEffect,
          actualValue: intent.baseValue,
          modificationReasons: ['status_applied:$statusId'],
        );

      default:
        return EffectResultBean(
          type: intent.type,
          actualValue: intent.baseValue,
        );
    }
  }

  /// 角色處理效果
  EffectResultBean _processEffectOnCharacter(
    SkillExecutionRequest request,
    String characterId,
    EffectIntentBean intent,
  ) {
    // 類似隊伍處理，但針對特定角色
    return _processEffectOnParty(request, intent);
  }

  /// 檢查觸發事件
  List<TriggeredEventBean> _checkTriggeredEvents(
    SkillExecutionRequest request,
    String targetId,
    EffectResultBean result,
  ) {
    final events = <TriggeredEventBean>[];

    // 檢查是否為敵人目標且受到傷害
    final targetEnemy = request.enemies
        .where((e) => e.id == targetId)
        .firstOrNull;

    if (targetEnemy != null && result.type == EffectType.damage) {
      // 情境1：敵人受到物理傷害時反擊
      if (targetEnemy.skillIds.contains('counterattack')) {
        events.add(
          TriggeredEventBean(
            eventType: 'counterattack',
            sourceId: targetId,
            eventData: {'damage': 2000},
          ),
        );
      }

      // 敵人受傷後可能觸發防禦增強
      if (targetEnemy.skillIds.contains('defensive_boost')) {
        events.add(
          TriggeredEventBean(
            eventType: 'defensive_boost',
            sourceId: targetId,
            eventData: {'defenseIncrease': 20},
          ),
        );
      }
    }

    return events;
  }
}

/// 目標化意圖 Bean
class TargetedIntentBean {
  final String targetId;
  final EffectIntentBean intent;

  const TargetedIntentBean({required this.targetId, required this.intent});
}
