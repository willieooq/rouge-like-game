// lib/services/enemy_ai_service.dart
import 'dart:math';

import '../models/character/character.dart';
import '../models/enemy/enemy.dart';
import '../models/enemy/enemy_action.dart';

/// 敵人 AI 決策服務
///
/// 遵循 Single Responsibility Principle：
/// 專門負責敵人的 AI 決策邏輯
class EnemyAIService {
  final Random _random = Random();

  /// 生成敵人行動隊列
  ///
  /// 根據敵人的 AI 行為模式和當前戰鬥狀況生成行動序列
  List<EnemyAction> generateActionQueue({
    required Enemy enemy,
    required List<Character> playerParty,
    required int turnNumber,
  }) {
    switch (enemy.aiBehavior) {
      case AIBehavior.aggressive:
        return _generateAggressiveActions(enemy, playerParty, turnNumber);
      case AIBehavior.defensive:
        return _generateDefensiveActions(enemy, playerParty, turnNumber);
      case AIBehavior.balanced:
        return _generateBalancedActions(enemy, playerParty, turnNumber);
      case AIBehavior.support:
        return _generateSupportActions(enemy, playerParty, turnNumber);
    }
  }

  /// 生成攻擊型 AI 行動
  List<EnemyAction> _generateAggressiveActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];

    // 攻擊型 AI：優先使用攻擊技能
    if (enemy.isInDanger && _random.nextDouble() < 0.3) {
      // 血量危險時可能會使用治療
      actions.add(_createHealAction(enemy));
    }

    // 主要攻擊行動
    if (_random.nextDouble() < 0.7) {
      actions.add(_createAttackAction(enemy, isHeavy: false));
    }

    // 有機會使用重擊
    if (_random.nextDouble() < 0.4) {
      actions.add(_createAttackAction(enemy, isHeavy: true));
    }

    // 攻擊型很少使用防禦
    if (_random.nextDouble() < 0.1) {
      actions.add(_createDefendAction(enemy));
    }

    return _shuffleAndLimit(actions, maxActions: 3);
  }

  /// 生成防禦型 AI 行動
  List<EnemyAction> _generateDefensiveActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];

    // 防禦型 AI：優先防禦和治療
    actions.add(_createDefendAction(enemy));

    if (enemy.hpPercentage < 0.7) {
      actions.add(_createHealAction(enemy));
    }

    // 適度攻擊
    if (_random.nextDouble() < 0.5) {
      actions.add(_createAttackAction(enemy, isHeavy: false));
    }

    return _shuffleAndLimit(actions, maxActions: 3);
  }

  /// 生成平衡型 AI 行動
  List<EnemyAction> _generateBalancedActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];

    // 平衡型 AI：根據情況選擇行動

    // 基本攻擊
    actions.add(_createAttackAction(enemy, isHeavy: false));

    // 根據血量決定是否治療
    if (enemy.hpPercentage < 0.5) {
      actions.add(_createHealAction(enemy));
    } else if (_random.nextDouble() < 0.3) {
      // 血量健康時可能使用增益
      actions.add(_createBuffAction(enemy));
    }

    // 隨機添加重擊或防禦
    if (_random.nextDouble() < 0.4) {
      actions.add(_createAttackAction(enemy, isHeavy: true));
    } else if (_random.nextDouble() < 0.3) {
      actions.add(_createDefendAction(enemy));
    }

    return _shuffleAndLimit(actions, maxActions: 3);
  }

  /// 生成輔助型 AI 行動
  List<EnemyAction> _generateSupportActions(
    Enemy enemy,
    List<Character> playerParty,
    int turnNumber,
  ) {
    final actions = <EnemyAction>[];

    // 輔助型 AI：優先使用增益和減益技能

    // 對玩家施加減益
    actions.add(_createDebuffAction(enemy));

    // 自我增益
    if (_random.nextDouble() < 0.6) {
      actions.add(_createBuffAction(enemy));
    }

    // 治療自己
    if (enemy.hpPercentage < 0.8) {
      actions.add(_createHealAction(enemy));
    }

    // 較少使用攻擊
    if (_random.nextDouble() < 0.3) {
      actions.add(_createAttackAction(enemy, isHeavy: false));
    }

    return _shuffleAndLimit(actions, maxActions: 3);
  }

  /// 創建攻擊行動
  EnemyAction _createAttackAction(Enemy enemy, {required bool isHeavy}) {
    return EnemyAction(
      id: 'attack_${_generateUniqueId()}',
      name: isHeavy ? '重擊' : '攻擊',
      description: isHeavy
          ? '對玩家造成 ${(enemy.attack * 1.5).round()} 點傷害'
          : '對玩家造成 ${enemy.attack} 點傷害',
      type: EnemyActionType.attack,
      skillId: isHeavy ? 'heavy_attack' : 'basic_attack',
      priority: isHeavy ? 2 : 1,
      isTargetable: true,
      color: isHeavy ? '#FF4444' : '#FF6B6B',
      damageMultiplier: isHeavy ? 1.5 : 1.0,
      parameters: {'damage': (enemy.attack * (isHeavy ? 1.5 : 1.0)).round()},
    );
  }

  /// 創建防禦行動
  EnemyAction _createDefendAction(Enemy enemy) {
    return EnemyAction(
      id: 'defend_${_generateUniqueId()}',
      name: '防禦',
      description: '提升防禦力，減少受到的傷害',
      type: EnemyActionType.defend,
      skillId: 'defend',
      priority: 3,
      isTargetable: true,
      color: '#4ECDC4',
      parameters: {'defenseBoost': (enemy.defense * 0.5).round()},
    );
  }

  /// 創建增益行動
  EnemyAction _createBuffAction(Enemy enemy) {
    final buffTypes = ['attack_boost', 'defense_boost', 'speed_boost'];
    final selectedBuff = buffTypes[_random.nextInt(buffTypes.length)];

    String name;
    String description;
    switch (selectedBuff) {
      case 'attack_boost':
        name = '攻擊強化';
        description = '提升攻擊力 3 回合';
        break;
      case 'defense_boost':
        name = '防禦強化';
        description = '提升防禦力 3 回合';
        break;
      case 'speed_boost':
        name = '速度強化';
        description = '提升速度 2 回合';
        break;
      default:
        name = '強化';
        description = '提升能力';
    }

    return EnemyAction(
      id: 'buff_${_generateUniqueId()}',
      name: name,
      description: description,
      type: EnemyActionType.buff,
      skillId: selectedBuff,
      priority: 2,
      isTargetable: true,
      color: '#F39C12',
      parameters: {'buffType': selectedBuff, 'duration': 3},
    );
  }

  /// 創建減益行動
  EnemyAction _createDebuffAction(Enemy enemy) {
    final debuffTypes = ['attack_down', 'defense_down', 'poison'];
    final selectedDebuff = debuffTypes[_random.nextInt(debuffTypes.length)];

    String name;
    String description;
    switch (selectedDebuff) {
      case 'attack_down':
        name = '攻擊削弱';
        description = '降低玩家攻擊力 3 回合';
        break;
      case 'defense_down':
        name = '防禦削弱';
        description = '降低玩家防禦力 3 回合';
        break;
      case 'poison':
        name = '中毒';
        description = '對玩家施加中毒效果 4 回合';
        break;
      default:
        name = '削弱';
        description = '降低玩家能力';
    }

    return EnemyAction(
      id: 'debuff_${_generateUniqueId()}',
      name: name,
      description: description,
      type: EnemyActionType.debuff,
      skillId: selectedDebuff,
      priority: 2,
      isTargetable: true,
      color: '#9B59B6',
      parameters: {'debuffType': selectedDebuff, 'duration': 3},
    );
  }

  /// 創建治療行動
  EnemyAction _createHealAction(Enemy enemy) {
    final healAmount = (enemy.maxHp * 0.3).round();

    return EnemyAction(
      id: 'heal_${_generateUniqueId()}',
      name: '治療',
      description: '恢復 $healAmount 點生命值',
      type: EnemyActionType.special,
      skillId: 'heal_self',
      priority: 1,
      isTargetable: true,
      color: '#2ECC71',
      parameters: {'healAmount': healAmount},
    );
  }

  /// 打亂並限制行動數量
  List<EnemyAction> _shuffleAndLimit(
    List<EnemyAction> actions, {
    required int maxActions,
  }) {
    if (actions.isEmpty) {
      // 如果沒有行動，至少添加一個基本攻擊
      actions.add(
        _createAttackAction(
          Enemy(
            id: 'temp',
            name: 'temp',
            type: EnemyType.normal,
            aiBehavior: AIBehavior.balanced,
            maxHp: 50,
            currentHp: 50,
            attack: 10,
            defense: 2,
            speed: 5,
            iconPath: '',
            description: '',
            skillIds: [],
            expReward: 0,
            goldReward: 0,
          ),
          isHeavy: false,
        ),
      );
    }

    // 打亂順序
    actions.shuffle(_random);

    // 限制數量
    if (actions.length > maxActions) {
      actions = actions.take(maxActions).toList();
    }

    // 按優先級排序
    actions.sort((a, b) => a.priority.compareTo(b.priority));

    return actions;
  }

  /// 生成唯一 ID
  String _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        _random.nextInt(1000).toString();
  }

  /// 根據敵人類型調整行動強度
  List<EnemyAction> adjustActionsByEnemyType(
    List<EnemyAction> actions,
    Enemy enemy,
  ) {
    switch (enemy.type) {
      case EnemyType.elite:
        // 精英敵人：行動更強，可能有額外行動
        return actions.map((action) => _enhanceAction(action, 1.2)).toList();

      case EnemyType.boss:
        // Boss：大幅強化，可能有特殊行動
        final enhancedActions = actions
            .map((action) => _enhanceAction(action, 1.5))
            .toList();
        if (_random.nextDouble() < 0.3) {
          enhancedActions.add(_createSpecialBossAction(enemy));
        }
        return enhancedActions;

      case EnemyType.normal:
        return actions;
    }
  }

  /// 強化行動
  EnemyAction _enhanceAction(EnemyAction action, double multiplier) {
    final enhancedParameters = Map<String, dynamic>.from(action.parameters);

    // 強化傷害相關參數
    if (enhancedParameters.containsKey('damage')) {
      enhancedParameters['damage'] = (enhancedParameters['damage'] * multiplier)
          .round();
    }

    return action.copyWith(
      damageMultiplier: action.damageMultiplier * multiplier,
      parameters: enhancedParameters,
    );
  }

  /// 創建特殊 Boss 行動
  EnemyAction _createSpecialBossAction(Enemy enemy) {
    return EnemyAction(
      id: 'boss_special_${_generateUniqueId()}',
      name: 'Boss 特殊攻擊',
      description: '強大的特殊攻擊，無法被無效化',
      type: EnemyActionType.special,
      skillId: 'boss_special',
      priority: 0,
      // 最高優先級
      isTargetable: false,
      // 無法被無效化
      color: '#8B0000',
      damageMultiplier: 2.0,
      parameters: {'damage': (enemy.attack * 2.0).round()},
    );
  }
}
