// lib/screens/battle_screen_redesigned.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dependency_injection.dart';
import '../models/battle/battle_state.dart';
import '../models/enemy/enemy.dart';
import '../models/party/party.dart';
import '../providers/battle_log_provider.dart';
import '../providers/battle_provider.dart';
import '../providers/operation_mode_provider.dart';
import '../providers/party_provider.dart';
import '../widgets/battle/battle_log.dart';
import '../widgets/battle/enemy_action_queue.dart';
import '../widgets/cost_dots.dart';
import '../widgets/party_formation.dart';

/// 重新設計的戰鬥場景 - 新佈局
class BattleScreen extends ConsumerStatefulWidget {
  const BattleScreen({super.key});

  @override
  ConsumerState<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen> {
  String? selectedCharacterId;
  int battleSpeed = 1; // 戰鬥倍速
  bool showDetailedInfo = true; // 戰鬥顯示切換

  @override
  void initState() {
    super.initState();
    // 設定系統UI樣式，確保status bar處理
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    Future.microtask(() => _initializeBattle());
  }

  Future<void> _initializeBattle() async {
    try {
      // 清空之前的戰鬥日誌
      ref.read(battleLogProvider.notifier).clearLog();
      ref.read(battleLogProvider.notifier).addSystemMessage('戰鬥初始化中...');

      // 等待遊戲數據初始化完成
      final gameInitialized = await ref.read(gameInitializationProvider.future);

      if (!gameInitialized) {
        ref.read(battleLogProvider.notifier).addSystemMessage('遊戲初始化失敗');
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

      // 添加戰鬥開始日誌
      ref
          .read(battleLogProvider.notifier)
          .addBattleEvent('戰鬥開始！面對 ${testEnemy.name}');
    } catch (e) {
      ref.read(battleLogProvider.notifier).addSystemMessage('戰鬥初始化失敗: $e');
      debugPrint('戰鬥初始化錯誤: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final battleState = ref.watch(battleProvider);
    final party = ref.watch(partyProvider);

    // 獲取安全區域資訊
    final mediaQuery = MediaQuery.of(context);
    final statusBarHeight = mediaQuery.viewPadding.top;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      // 重要：設定 resizeToAvoidBottomInset 避免鍵盤彈起問題
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: screenHeight,
        child: Stack(
          children: [
            // 主要戰鬥區域 - 背景層
            Positioned(
              top: statusBarHeight + 60,
              // status bar高度 + 日誌區域高度
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  // 敵人區域 - 比例 2
                  Expanded(flex: 3, child: _buildEnemySection(battleState)),

                  // 戰鬥區域 - 比例 1
                  Expanded(
                    flex: 1,
                    child: _buildBattleSection(battleState, party),
                  ),

                  // 玩家區域 - 比例 2
                  Expanded(flex: 3, child: _buildPlayerSection(party)),

                  // 系統區域 - 比例 1
                  Expanded(flex: 1, child: _buildSystemSection(battleState)),
                ],
              ),
            ),

            // LOG區塊 - 覆蓋層（從status bar下方開始）
            Positioned(
              top: statusBarHeight, // 確保在status bar下方
              left: 0,
              right: 0,
              child: _buildLogSection(),
            ),
          ],
        ),
      ),
    );
  }

  /// 構建LOG區塊 - 固定3行文字高
  Widget _buildLogSection() {
    return const BattleLog();
  }

  // 構建敵人區域
  Widget _buildEnemySection(BattleState? battleState) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: battleState?.enemy != null
          ? Row(
              children: [
                // 敵人信息 - 左側
                Expanded(flex: 2, child: _buildEnemyInfo(battleState!.enemy)),

                // 敵人行動列表 - 右側
                Expanded(flex: 1, child: _buildEnemyActionSection(battleState)),
              ],
            )
          : const Center(
              child: Text(
                '沒有敵人',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
    );
  }

  /// 構建敵人信息
  Widget _buildEnemyInfo(Enemy enemy) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
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
              const SizedBox(height: 8),

              // 敵人名稱
              Text(
                enemy.name,
                style: const TextStyle(
                  fontSize: 18,
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
              const SizedBox(height: 8),

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

  /// 構建敵人行動區域
  Widget _buildEnemyActionSection(BattleState battleState) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '敵人行動列表',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // 敵人行動隊列
          Expanded(
            child: EnemyActionQueue(
              actionQueue: battleState.enemyActionQueue,
              selectedAction: battleState.selectedEnemyAction,
              onActionSelected: (action) {
                ref
                    .read(battleProvider.notifier)
                    .selectEnemyActionToNullify(action.id);
              },
              isPlayerTurn: battleState.isPlayerTurn,
            ),
          ),
        ],
      ),
    );
  }

  /// 構建戰鬥區域
  Widget _buildBattleSection(BattleState? battleState, Party party) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber[50],
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          // 敵人血量和狀態 - 左側
          Expanded(
            flex: 1,
            child: _buildEnemyStatusSection(battleState?.enemy),
          ),

          // 回合數顯示 - 中央
          Expanded(flex: 1, child: _buildTurnCounter(battleState)),

          // 玩家血量和狀態 - 右側
          Expanded(flex: 1, child: _buildPlayerStatusSection(party)),
        ],
      ),
    );
  }

  /// 構建敵人狀態區域
  Widget _buildEnemyStatusSection(Enemy? enemy) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 敵人名稱
          Text(
            enemy?.name ?? '無敵人',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),

          // 敵人BUFF/DEBUFF圖標區域
          const SizedBox(height: 4),
          _buildStatusEffectIcons(enemy?.statusEffects ?? [], isEnemy: true),

          // 敵人血量條
          const SizedBox(height: 4),
          if (enemy != null)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('HP', style: TextStyle(fontSize: 10)),
                    Text(
                      '${enemy.currentHp}/${enemy.maxHp}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                LinearProgressIndicator(
                  value: enemy.hpPercentage,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getEnemyHpColor(enemy.hpPercentage),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// 構建回合計數器
  Widget _buildTurnCounter(BattleState? battleState) {
    final currentTurn = battleState?.turnNumber ?? 1;
    const maxTurn = 10; // 先固定為10

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '回合',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '$currentTurn/$maxTurn',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          // 回合進度條
          LinearProgressIndicator(
            value: currentTurn / maxTurn,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }

  /// 構建玩家狀態區域
  Widget _buildPlayerStatusSection(Party party) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 玩家隊伍標示
          const Text(
            '玩家隊伍',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),

          // 玩家BUFF/DEBUFF圖標區域
          const SizedBox(height: 4),
          _buildStatusEffectIcons([], isEnemy: false), // 暫時空的，之後補上玩家狀態
          // 玩家血量條
          const SizedBox(height: 4),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('HP', style: TextStyle(fontSize: 10)),
                  Text(
                    '${party.sharedHp}/${party.maxHp}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              LinearProgressIndicator(
                value: party.sharedHp / party.maxHp,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getHpColor(party.sharedHp / party.maxHp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 構建狀態效果圖標
  Widget _buildStatusEffectIcons(
    List<String> statusEffects, {
    required bool isEnemy,
  }) {
    if (statusEffects.isEmpty) {
      return const SizedBox(height: 20); // 保持空間
    }

    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statusEffects.length,
        itemBuilder: (context, index) {
          final effect = statusEffects[index];
          return _buildStatusEffectIcon(effect, isEnemy);
        },
      ),
    );
  }

  /// 構建單個狀態效果圖標
  Widget _buildStatusEffectIcon(String effect, bool isEnemy) {
    return GestureDetector(
      onTap: () => _showStatusEffectDetails(effect),
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: _getStatusEffectColor(effect),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                _getStatusEffectIcon(effect),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 如果是無法解除的效果，顯示鎖圖標
            if (_isStatusEffectLocked(effect))
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.lock, size: 8, color: Colors.yellow),
              ),
          ],
        ),
      ),
    );
  }

  /// 構建玩家區域
  Widget _buildPlayerSection(Party party) {
    final partyNotifier = ref.read(partyProvider.notifier);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
            const SizedBox(height: 8),

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
                  ref.read(operationModeProvider.notifier).switchGlobalMode();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 構建系統區域
  Widget _buildSystemSection(BattleState? battleState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 設定按鈕
          _buildSettingsButton(),

          // 倍速調整
          _buildSpeedControl(),

          // 結束回合按鈕
          _buildEndTurnButton(battleState),

          // 戰鬥顯示切換
          _buildDisplayToggle(),
        ],
      ),
    );
  }

  /// 構建倍速控制
  Widget _buildSpeedControl() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (battleSpeed == 1) {
                    battleSpeed = 2;
                  } else if (battleSpeed == 2) {
                    battleSpeed = 1;
                  }
                });
              },
              child: Text(
                '${battleSpeed}X',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 構建結束回合按鈕
  Widget _buildEndTurnButton(BattleState? battleState) {
    return ElevatedButton(
      onPressed: battleState?.isPlayerTurn == true
          ? () => _endPlayerTurn(battleState!)
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: battleState?.isPlayerTurn == true
            ? Colors.orange
            : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        battleState?.isPlayerTurn == true ? '結束回合' : '等待回合',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  /// 構建設定按鈕
  Widget _buildSettingsButton() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.settings, size: 20),
      onSelected: (String result) {
        switch (result) {
          case 'restart_battle':
            _showRestartBattleDialog();
            break;
          case 'game_settings':
            _showGameSettings();
            break;
          case 'exit_battle':
            _showExitBattleDialog();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'restart_battle',
          child: ListTile(
            leading: Icon(Icons.refresh, size: 20),
            title: Text('重新開始戰鬥', style: TextStyle(fontSize: 12)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'battle_speed',
          child: ListTile(
            leading: Icon(Icons.speed, size: 20),
            title: Text('戰鬥倍速', style: TextStyle(fontSize: 12)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'game_settings',
          child: ListTile(
            leading: Icon(Icons.tune, size: 20),
            title: Text('遊戲設定', style: TextStyle(fontSize: 12)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'exit_battle',
          child: ListTile(
            leading: Icon(Icons.exit_to_app, size: 20, color: Colors.red),
            title: Text(
              '離開戰鬥',
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  /// 顯示重新開始戰鬥確認對話框
  void _showRestartBattleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('重新開始戰鬥'),
          content: const Text('確定要重新開始當前戰鬥嗎？所有進度將會遺失。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.microtask(() => _initializeBattle());
              },
              child: const Text('確定', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /// 顯示遊戲設定對話框
  void _showGameSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('遊戲設定'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('詳細顯示'),
                    subtitle: const Text('顯示更多戰鬥資訊'),
                    value: showDetailedInfo,
                    onChanged: (bool value) {
                      setState(() {
                        showDetailedInfo = value;
                      });
                      // 同步更新外層狀態
                      this.setState(() {
                        showDetailedInfo = value;
                      });
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.volume_up),
                    title: const Text('音效設定'),
                    subtitle: const Text('調整遊戲音效'),
                    onTap: () {
                      // TODO: 開啟音效設定
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('音效設定功能開發中...')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.palette),
                    title: const Text('主題設定'),
                    subtitle: const Text('更改介面主題'),
                    onTap: () {
                      // TODO: 開啟主題設定
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('主題設定功能開發中...')),
                      );
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('關閉'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// 顯示離開戰鬥確認對話框
  void _showExitBattleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('離開戰鬥'),
          content: const Text('確定要離開當前戰鬥嗎？戰鬥進度將會遺失。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: 實現離開戰鬥邏輯
                Navigator.of(context).pop(); // 返回上一個畫面
              },
              child: const Text('離開', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /// 構建顯示切換按鈕
  Widget _buildDisplayToggle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('詳細顯示', style: TextStyle(fontSize: 10)),
        Switch(
          value: showDetailedInfo,
          onChanged: (value) {
            setState(() {
              showDetailedInfo = value;
            });
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  // ================================
  // 輔助方法
  // ================================

  /// 顯示狀態效果詳細信息
  void _showStatusEffectDetails(String effect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('狀態效果：$effect'),
        content: Text(_getStatusEffectDescription(effect)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('確定'),
          ),
        ],
      ),
    );
  }

  /// 結束玩家回合
  void _endPlayerTurn(BattleState battleState) {
    ref.read(battleProvider.notifier).endPlayerTurn();
    ref.read(partyProvider.notifier).startNewTurn();

    ref.read(battleLogProvider.notifier).addBattleEvent('玩家回合結束');
    ref.read(battleLogProvider.notifier).addBattleEvent('敵人回合開始...');
  }

  /// 構建屬性標籤
  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 8, color: color)),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ================================
  // 顏色和圖標輔助方法
  // ================================

  Color _getEnemyHpColor(double percentage) {
    if (percentage > 0.6) return Colors.green;
    if (percentage > 0.3) return Colors.orange;
    return Colors.red;
  }

  Color _getHpColor(double percentage) {
    if (percentage <= 0.25) return Colors.red;
    if (percentage <= 0.5) return Colors.orange;
    return Colors.green;
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

  Color _getStatusEffectColor(String effect) {
    switch (effect.toLowerCase()) {
      case 'poison':
      case 'burn':
      case 'weak':
        return Colors.red; // 負面效果
      case 'heal':
      case 'shield':
      case 'strength':
        return Colors.green; // 正面效果
      default:
        return Colors.blue; // 中性效果
    }
  }

  String _getStatusEffectIcon(String effect) {
    switch (effect.toLowerCase()) {
      case 'poison':
        return '毒';
      case 'burn':
        return '燒';
      case 'heal':
        return '治';
      case 'shield':
        return '盾';
      case 'weak':
        return '弱';
      case 'strength':
        return '力';
      default:
        return '?';
    }
  }

  bool _isStatusEffectLocked(String effect) {
    // 某些效果無法解除
    return ['curse', 'permanent_debuff'].contains(effect.toLowerCase());
  }

  String _getStatusEffectDescription(String effect) {
    switch (effect.toLowerCase()) {
      case 'poison':
        return '每回合受到持續毒素傷害';
      case 'burn':
        return '每回合受到燃燒傷害';
      case 'heal':
        return '每回合恢復生命值';
      case 'shield':
        return '減少受到的傷害';
      case 'weak':
        return '攻擊力降低';
      case 'strength':
        return '攻擊力提升';
      default:
        return '未知效果';
    }
  }
}
