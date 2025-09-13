// lib/screens/battle_screen_new.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dependency_injection.dart';
import '../models/battle/battle_state.dart';
import '../models/enemy/enemy.dart';
import '../models/party/party.dart';
import '../providers/battle_provider.dart';
import '../providers/operation_mode_provider.dart';
import '../providers/party_provider.dart';
import '../widgets/cost_dots.dart';
import '../widgets/party_formation.dart';

/// 更新後的戰鬥場景 - 適配新的 Clean Architecture
class BattleScreenNew extends ConsumerStatefulWidget {
  const BattleScreenNew({super.key});

  @override
  ConsumerState<BattleScreenNew> createState() => _BattleScreenNewState();
}

class _BattleScreenNewState extends ConsumerState<BattleScreenNew> {
  String? selectedCharacterId;
  String _battleLog = '戰鬥準備中...';

  @override
  void initState() {
    super.initState();
    _initializeBattle();
  }

  Future<void> _initializeBattle() async {
    try {
      // 等待遊戲數據初始化完成
      final gameInitialized = await ref.read(gameInitializationProvider.future);

      if (!gameInitialized) {
        setState(() {
          _battleLog = '遊戲初始化失敗';
        });
        return;
      }

      // 獲取敵人服務並生成測試敵人
      final enemyService = ref.read(enemyServiceProvider);
      await enemyService.initialize();

      // 創建測試敵人
      final testEnemy = Enemy(
        id: 'test_goblin',
        name: '測試哥布林',
        type: EnemyType.normal,
        aiBehavior: AIBehavior.balanced,
        maxHp: 80,
        currentHp: 80,
        attack: 12,
        defense: 3,
        speed: 8,
        iconPath: '',
        description: '用於測試戰鬥系統的哥布林',
        skillIds: ['basic_attack'],
        expReward: 15,
        goldReward: 10,
        primaryColor: '#8B4513',
        secondaryColor: '#DEB887',
      );

      // 獲取當前隊伍
      final currentParty = ref.read(partyProvider);

      // 開始戰鬥
      await ref
          .read(battleProvider.notifier)
          .startBattle(party: currentParty, enemy: testEnemy, canEscape: true);

      setState(() {
        _battleLog = '戰鬥開始！面對 ${testEnemy.name}';
      });
    } catch (e) {
      setState(() {
        _battleLog = '戰鬥初始化失敗: $e';
      });
      debugPrint('戰鬥初始化錯誤: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final battleState = ref.watch(battleProvider);
    final party = ref.watch(partyProvider);
    final partyNotifier = ref.read(partyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('戰鬥場景'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 重置戰鬥按鈕
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializeBattle,
            tooltip: '重新開始戰鬥',
          ),
        ],
      ),
      body: Column(
        children: [
          // 戰鬥狀態顯示區域
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 戰鬥階段指示器
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '戰鬥狀態',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (battleState != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getPhaseColor(battleState.currentPhase),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _getPhaseText(battleState.currentPhase),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // 戰鬥日誌
                Text(_battleLog, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),

          // 敵人顯示區域
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              child: battleState?.enemy != null
                  ? _buildEnemyDisplay(battleState!.enemy)
                  : const Center(
                      child: Text(
                        '沒有敵人',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
            ),
          ),

          // 戰鬥控制按鈕
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: battleState?.isPlayerTurn == true
                        ? () => _endPlayerTurn(battleState!)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: battleState?.isPlayerTurn == true
                          ? Colors.orange
                          : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      battleState?.isPlayerTurn == true ? '結束回合' : '等待回合',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 隊伍信息區域
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 隊伍血量顯示
                  Row(
                    children: [
                      Text(
                        'HP: ${party.sharedHp}/${party.maxHp}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getHpColor(partyNotifier.hpPercentage),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: partyNotifier.hpPercentage,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getHpColor(partyNotifier.hpPercentage),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Cost 顯示
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cost: ${party.currentTurnCost}/${party.maxTurnCost}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: CostDots(
                          currentCost: party.currentTurnCost,
                          maxCost: party.maxTurnCost,
                          dotSize: 12.0,
                          activeDotColor: Colors.blue[600]!,
                          inactiveDotColor: Colors.grey[300]!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 隊伍陣形
                  Expanded(
                    child: PartyFormation(
                      characters: party.characters,
                      selectedCharacterId: selectedCharacterId,
                      onCharacterSelected: (characterId) {
                        setState(() {
                          selectedCharacterId = characterId;
                        });
                      },
                      onModeSwitchPressed: () {
                        ref
                            .read(operationModeProvider.notifier)
                            .switchGlobalMode();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 構建敵人顯示區域
  Widget _buildEnemyDisplay(Enemy enemy) {
    return Center(
      child: Card(
        elevation: 4,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 敵人圖標
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                    int.parse(enemy.primaryColor.replaceFirst('#', '0xFF')),
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  _getEnemyIcon(enemy.type),
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),

              // 敵人名稱
              Text(
                enemy.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // 血量條
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('HP'),
                      Text('${enemy.currentHp}/${enemy.maxHp}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: enemy.hpPercentage,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getEnemyHpColor(enemy.hpPercentage),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 敵人屬性
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatChip('攻', enemy.attack.toString(), Colors.red),
                  _buildStatChip('防', enemy.defense.toString(), Colors.blue),
                  _buildStatChip('速', enemy.speed.toString(), Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 構建技能行動區域
  Widget _buildSkillActions(BattleState? battleState, Party party) {
    if (battleState == null || !battleState.isPlayerTurn) {
      return const Center(
        child: Text(
          '等待玩家回合...',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '可用技能',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // 快速技能按鈕
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildQuickSkillButton(
              '火球術',
              'fireball',
              3,
              party.currentTurnCost,
              battleState,
            ),
            _buildQuickSkillButton(
              '重擊',
              'heavy_strike',
              4,
              party.currentTurnCost,
              battleState,
            ),
            _buildQuickSkillButton(
              '治療',
              'heal',
              2,
              party.currentTurnCost,
              battleState,
            ),
          ],
        ),
      ],
    );
  }

  /// 構建快速技能按鈕
  Widget _buildQuickSkillButton(
    String skillName,
    String skillId,
    int cost,
    int currentCost,
    BattleState battleState,
  ) {
    final canUse = currentCost >= cost;

    return ElevatedButton(
      onPressed: canUse ? () => _useSkill(skillId, cost) : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: canUse ? Colors.blue[600] : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(skillName, style: const TextStyle(fontSize: 12)),
          Text('Cost: $cost', style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  /// 構建屬性標籤
  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: color)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// 使用技能
  Future<void> _useSkill(String skillId, int cost) async {
    try {
      final casterId =
          selectedCharacterId ?? ref.read(partyProvider).characters.first.id;

      // 使用技能
      await ref
          .read(battleProvider.notifier)
          .useSkill(
            skillId: skillId,
            casterId: casterId,
            targetIds: [], // 自動定位敵人
          );

      setState(() {
        _battleLog = '使用了技能: $skillId (Cost: $cost)';
      });
    } catch (e) {
      setState(() {
        _battleLog = '技能使用失敗: $e';
      });
    }
  }

  /// 結束玩家回合
  void _endPlayerTurn(BattleState battleState) {
    ref.read(battleProvider.notifier).endPlayerTurn();
    ref.read(partyProvider.notifier).startNewTurn(); // 恢復 Cost

    setState(() {
      _battleLog = '結束玩家回合，敵人開始行動...';
    });
  }

  // 輔助方法
  Color _getPhaseColor(BattlePhase phase) {
    switch (phase) {
      case BattlePhase.playerTurn:
        return Colors.blue[600]!;
      case BattlePhase.enemyTurn:
        return Colors.red[600]!;
      case BattlePhase.victory:
        return Colors.green[600]!;
      case BattlePhase.defeat:
        return Colors.grey[600]!;
      default:
        return Colors.orange[600]!;
    }
  }

  String _getPhaseText(BattlePhase phase) {
    switch (phase) {
      case BattlePhase.playerTurn:
        return '玩家回合';
      case BattlePhase.enemyTurn:
        return '敵人回合';
      case BattlePhase.victory:
        return '勝利';
      case BattlePhase.defeat:
        return '失敗';
      default:
        return '準備中';
    }
  }

  Color _getHpColor(double percentage) {
    if (percentage <= 0.25) return Colors.red;
    if (percentage <= 0.5) return Colors.orange;
    return Colors.green;
  }

  Color _getEnemyHpColor(double percentage) {
    if (percentage > 0.6) return Colors.green;
    if (percentage > 0.3) return Colors.orange;
    return Colors.red;
  }

  IconData _getEnemyIcon(EnemyType type) {
    switch (type) {
      case EnemyType.normal:
        return Icons.pest_control;
      case EnemyType.elite:
        return Icons.dangerous;
      case EnemyType.boss:
        return Icons.casino;
    }
  }
}
