// lib/screens/battle_screen.dart - 基於現有結構的敵人系統整合

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/models/battle/battle_state.dart';

import '../models/enemy/enemy.dart';
import '../providers/battle_provider.dart';
import '../providers/operation_mode_provider.dart';
import '../providers/party_provider.dart';
import '../services/enemy_service.dart';
import '../widgets/battle/enemy_action_queue.dart';
import '../widgets/cost_dots.dart';
import '../widgets/enemy/enemy_renderer.dart';
import '../widgets/party_formation.dart';

/// 戰鬥畫面繪製
class BattleScreen extends ConsumerStatefulWidget {
  const BattleScreen({super.key});

  @override
  ConsumerState<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen> {
  String? selectedCharacterId;
  String? selectedEnemyId;

  @override
  void initState() {
    super.initState();
    _initializeBattle();
  }

  // Future<void> _initializeBattle() async {
  //   try {
  //     // 初始化敵人服務
  //     await EnemyService.instance.initialize();
  //
  //     // 生成測試敵人遭遇 - 只生成一個敵人
  //     final enemies = EnemyService.instance.generateRandomEncounter(
  //       playerLevel: 1,
  //       maxEnemies: 1, // 只生成一個敵人
  //       eliteChance: 0.3,
  //       bossChance: 0.0,
  //     );
  //
  //     // 啟動戰鬥
  //     ref.read(battleProvider.notifier).startBattle(enemies);
  //   } catch (e) {
  //     print('初始化戰鬥失敗: $e');
  //     // 創建默認敵人作為後備
  //     final defaultEnemies = [
  //       Enemy(
  //         id: 'test_enemy',
  //         name: '測試敵人',
  //         type: EnemyType.normal,
  //         aiBehavior: AIBehavior.aggressive,
  //         maxHp: 50,
  //         currentHp: 50,
  //         attack: 10,
  //         defense: 2,
  //         speed: 8,
  //         iconPath: '',
  //         description: '用於測試的敵人',
  //         skillIds: [],
  //         expReward: 15,
  //         goldReward: 8,
  //       ),
  //     ];
  //     ref.read(battleProvider.notifier).startBattle(defaultEnemies);
  //   }
  // }
  Future<void> _initializeBattle() async {
    try {
      // 初始化敵人服務
      await EnemyService.instance.initialize();

      // 生成測試敵人遭遇 - 只生成一個敵人
      final enemies = EnemyService.instance.generateRandomEncounter(
        playerLevel: 1,
        maxEnemies: 1, // 只生成一個敵人
        eliteChance: 0.3,
        bossChance: 0.0,
      );

      // 啟動戰鬥
      ref.read(battleProvider.notifier).startBattle(enemies);
    } catch (e) {
      print('初始化戰鬥失敗: $e');
      // 創建狀態測試木樁作為後備
      final testDummy = [
        Enemy(
          id: 'status_test_dummy',
          name: '狀態測試木樁',
          type: EnemyType.normal,
          aiBehavior: AIBehavior.balanced,
          maxHp: 800,
          currentHp: 800,
          attack: 3,
          defense: 1,
          speed: 5,
          iconPath: '',
          description: '專門用於測試狀態效果的高血量木樁',
          skillIds: ['weak_attack'],
          expReward: 5,
          goldReward: 3,
          primaryColor: '#8B4513',
          secondaryColor: '#DEB887',
        ),
      ];
      ref.read(battleProvider.notifier).startBattle(testDummy);
    }
  }

  @override
  Widget build(BuildContext context) {
    final party = ref.watch(partyProvider);
    final partyNotifier = ref.read(partyProvider.notifier);
    final battleState = ref.watch(battleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('戰鬥畫面'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // 上半部：敵人區域
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: battleState.enemies.isEmpty
                            ? const Center(
                                child: Text(
                                  '戰鬥勝利！',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildFullSizeEnemyCard(
                                  battleState.enemies.first,
                                ),
                              ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child:
                          // 敵人標題
                          Row(
                            children: [
                              // Text(
                              //   '敵人 (${battleState.enemies.where((e) => !e.isDead).length}/${battleState.enemies.length})',
                              //   style: const TextStyle(
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),

                              // 敵人顯示區域 - 填滿整個可用空間
                              // 敵人行動隊列顯示
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: EnemyActionQueue(
                                    actionQueue: battleState.enemyActionQueue,
                                    selectedAction:
                                        battleState.selectedEnemyAction,
                                    onActionSelected: (action) {
                                      ref
                                          .read(battleProvider.notifier)
                                          .selectEnemyActionToNullify(
                                            action.id,
                                          );
                                    },
                                    isPlayerTurn: battleState.isPlayerTurn,
                                  ),
                                ),
                              ),
                              // 戰鬥階段顯示
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPhaseColor(
                                    battleState.currentPhase,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
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
                    ),

                    // 戰鬥操作按鈕（簡化版）
                    // 戰鬥操作區域 - 修正版
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ElevatedButton(
                        onPressed:
                            battleState.isPlayerTurn &&
                                battleState.isBattleOngoing
                            ? () {
                                print('UI: 玩家點擊結束回合按鈕');
                                ref
                                    .read(battleProvider.notifier)
                                    .endPlayerTurn();
                              }
                            : null, // 非玩家回合時按鈕不可用
                        style: ElevatedButton.styleFrom(
                          backgroundColor: battleState.isPlayerTurn
                              ? Colors.red
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          battleState.isPlayerTurn ? '結束回合' : '等待回合',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 下半部：角色排列（保持原有結構）
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // 隊伍生命值（保持原有）
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${party.sharedHp}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _getHpColor(partyNotifier.hpPercentage),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
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

                    // 回合Cost顯示（保持原有）
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${party.currentTurnCost}/${party.maxTurnCost}'),
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
                    ),
                    const SizedBox(height: 8),

                    // party資訊（保持原有）
                    Expanded(
                      flex: 1,
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
          ),
        ],
      ),
    );
  }

  /// 構建填滿區域的敵人卡片
  Widget _buildFullSizeEnemyCard(Enemy enemy) {
    final isSelected = selectedEnemyId == enemy.id;

    return LayoutBuilder(
      builder: (context, constraints) {
        // 使用整個可用空間
        return GestureDetector(
          onTap: enemy.isDead
              ? null
              : () {
                  setState(() {
                    selectedEnemyId = isSelected ? null : enemy.id;
                  });
                },
          child: AnimatedContainer(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? Colors.yellow
                    : Colors.red.withValues(alpha: 0.6),
                width: isSelected ? 4 : 2,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: Colors.yellow.withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 3,
                  ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: enemy.isDead
                    ? [Colors.grey[800]!, Colors.grey[900]!]
                    : [
                        Color(
                          int.parse(
                            enemy.primaryColor.replaceFirst('#', '0xFF'),
                          ),
                        ).withValues(alpha: 0.8),
                        Color(
                          int.parse(
                            enemy.primaryColor.replaceFirst('#', '0xFF'),
                          ),
                        ).withValues(alpha: 0.6),
                      ],
              ),
            ),
            child: Stack(
              children: [
                // 背景圖案
                _buildCustomBackgroundPattern(
                  enemy,
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),

                // 主要內容
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32, // 減去 padding
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // 敵人圖標 - 調整大小
                            Container(
                              width: constraints.maxWidth * 0.25,
                              height: constraints.maxWidth * 0.25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(
                                  int.parse(
                                    enemy.primaryColor.replaceFirst(
                                      '#',
                                      '0xFF',
                                    ),
                                  ),
                                ),
                                border: Border.all(
                                  color: Color(
                                    int.parse(
                                      enemy.secondaryColor.replaceFirst(
                                        '#',
                                        '0xFF',
                                      ),
                                    ),
                                  ),
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                _getEnemyIcon(enemy.type),
                                color: Colors.white,
                                size: constraints.maxWidth * 0.12,
                              ),
                            ),

                            // 敵人名稱和類型
                            Column(
                              children: [
                                Text(
                                  enemy.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 8),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getTypeLabelColor(enemy.type),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    _getTypeDisplayName(enemy.type),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // 血量條
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'HP',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${enemy.currentHp}/${enemy.maxHp}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black26,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: LinearProgressIndicator(
                                      value: enemy.hpPercentage,
                                      backgroundColor: Colors.transparent,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _getHpBarColor(enemy.hpPercentage),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // 統計信息 - 更緊湊
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildLargeStatIcon(
                                  icon: Icons.shelves,
                                  label: '攻擊',
                                  value: enemy.attack.toString(),
                                  color: Colors.red[300]!,
                                ),
                                _buildLargeStatIcon(
                                  icon: Icons.shield,
                                  label: '防禦',
                                  value: enemy.defense.toString(),
                                  color: Colors.blue[300]!,
                                ),
                                _buildLargeStatIcon(
                                  icon: Icons.speed,
                                  label: '速度',
                                  value: enemy.speed.toString(),
                                  color: Colors.green[300]!,
                                ),
                              ],
                            ),

                            // 狀態效果
                            if (enemy.statusEffects.isNotEmpty)
                              Wrap(
                                spacing: 6,
                                children: enemy.statusEffects.map((effect) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusEffectColor(effect),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      effect,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // 死亡遮罩
                if (enemy.isDead)
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: constraints.maxWidth * 0.2,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 構建大尺寸統計圖標
  Widget _buildLargeStatIcon({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// 構建自定義背景圖案
  Widget _buildCustomBackgroundPattern(
    Enemy enemy,
    double width,
    double height,
  ) {
    return Positioned.fill(
      child: CustomPaint(
        painter: LargeEnemyPatternPainter(
          type: enemy.type,
          primaryColor: Color(
            int.parse(enemy.primaryColor.replaceFirst('#', '0xFF')),
          ),
          secondaryColor: Color(
            int.parse(enemy.secondaryColor.replaceFirst('#', '0xFF')),
          ),
        ),
      ),
    );
  }

  // 輔助方法
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

  Color _getTypeLabelColor(EnemyType type) {
    switch (type) {
      case EnemyType.elite:
        return Colors.purple;
      case EnemyType.boss:
        return Colors.red[800]!;
      case EnemyType.normal:
        return Colors.grey;
    }
  }

  String _getTypeDisplayName(EnemyType type) {
    switch (type) {
      case EnemyType.normal:
        return '普通敵人';
      case EnemyType.elite:
        return '精英敵人';
      case EnemyType.boss:
        return 'Boss';
    }
  }

  Color _getHpBarColor(double hpPercentage) {
    if (hpPercentage > 0.6) return Colors.green;
    if (hpPercentage > 0.3) return Colors.orange;
    return Colors.red;
  }

  Color _getStatusEffectColor(String effect) {
    switch (effect.toLowerCase()) {
      case 'poison':
        return Colors.purple;
      case 'burn':
        return Colors.orange;
      case 'freeze':
        return Colors.cyan;
      case 'stun':
        return Colors.yellow[700]!;
      default:
        return Colors.grey;
    }
  }

  /// 構建單個敵人卡片（保留原版本）
  Widget _buildSingleEnemyCard(Enemy enemy) {
    final isSelected = selectedEnemyId == enemy.id;

    return EnemyRenderer.renderEnemyCard(
      enemy: enemy,
      onTap: enemy.isDead
          ? null
          : () {
              setState(() {
                selectedEnemyId = isSelected ? null : enemy.id;
              });
            },
      cardWidth: 150,
      // 更大的卡片
      cardHeight: 200,
      showStats: true,
      showHpBar: true,
      isSelected: isSelected,
      isTargeted: false,
    );
  }

  /// 構建敵人網格（保留以防後續需要）
  Widget _buildEnemyGrid(List<Enemy> enemies) {
    // 根據敵人數量調整佈局
    if (enemies.length == 1) {
      return Center(child: _buildEnemyCard(enemies[0]));
    } else if (enemies.length == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: enemies.map((enemy) => _buildEnemyCard(enemy)).toList(),
      );
    } else {
      // 3個或以上使用網格
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: enemies.length,
        itemBuilder: (context, index) => _buildEnemyCard(enemies[index]),
      );
    }
  }

  /// 構建敵人卡片
  Widget _buildEnemyCard(Enemy enemy) {
    final isSelected = selectedEnemyId == enemy.id;

    return EnemyRenderer.renderEnemyCard(
      enemy: enemy,
      onTap: enemy.isDead
          ? null
          : () {
              setState(() {
                selectedEnemyId = isSelected ? null : enemy.id;
              });
            },
      cardWidth: 90,
      cardHeight: 110,
      showStats: true,
      showHpBar: true,
      isSelected: isSelected,
      isTargeted: false,
    );
  }

  /// 執行攻擊
  void _performAttack(int cost) {
    final battleState = ref.read(battleProvider);

    // 如果場上沒有敵人，直接返回
    if (battleState.enemies.isEmpty || battleState.enemies.first.isDead) {
      return;
    }

    // 自動選擇場上唯一的敵人
    final targetEnemy = battleState.enemies.first;

    final partyNotifier = ref.read(partyProvider.notifier);
    final battleNotifier = ref.read(battleProvider.notifier);

    // 檢查是否有足夠的cost
    if (!partyNotifier.canUseSkill(cost)) return;

    // 扣除cost
    partyNotifier.useSkill(cost);

    // 對敵人造成傷害（簡化邏輯）
    final damage = cost * 10; // 簡單的傷害計算
    battleNotifier.damageEnemy(targetEnemy.id, damage);

    // 顯示傷害訊息
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('對 ${targetEnemy.name} 造成 $damage 點傷害！'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // 輔助方法
  Color _getPhaseColor(BattlePhase phase) {
    switch (phase) {
      case BattlePhase.playerTurn:
        return Colors.blue;
      case BattlePhase.enemyTurn:
        return Colors.red;
      case BattlePhase.victory:
        return Colors.green;
      case BattlePhase.defeat:
        return Colors.grey;
      default:
        return Colors.grey;
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

  // 生命值顏色（保持原有）
  Color _getHpColor(double percentage) {
    if (percentage <= 0.25) return Colors.red;
    if (percentage <= 0.5) return Colors.orange;
    return Colors.green;
  }
}

/// 大尺寸敵人背景圖案繪製器
class LargeEnemyPatternPainter extends CustomPainter {
  final EnemyType type;
  final Color primaryColor;
  final Color secondaryColor;

  LargeEnemyPatternPainter({
    required this.type,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = secondaryColor.withValues(alpha: 0.1);

    switch (type) {
      case EnemyType.normal:
        _drawLargeDotPattern(canvas, size, paint);
        break;
      case EnemyType.elite:
        _drawLargeDiamondPattern(canvas, size, paint);
        break;
      case EnemyType.boss:
        _drawLargeSpikesPattern(canvas, size, paint);
        break;
    }
  }

  void _drawLargeDotPattern(Canvas canvas, Size size, Paint paint) {
    const spacing = 40.0;
    paint.style = PaintingStyle.fill;

    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  void _drawLargeDiamondPattern(Canvas canvas, Size size, Paint paint) {
    const spacing = 50.0;

    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        final path = Path()
          ..moveTo(x, y - 6)
          ..lineTo(x + 6, y)
          ..lineTo(x, y + 6)
          ..lineTo(x - 6, y)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }

  void _drawLargeSpikesPattern(Canvas canvas, Size size, Paint paint) {
    paint.strokeWidth = 3;

    for (double y = 30; y < size.height; y += 40) {
      final path = Path()..moveTo(0, y);

      for (double x = 0; x < size.width; x += 20) {
        path.lineTo(x + 10, y - 10);
        path.lineTo(x + 20, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
