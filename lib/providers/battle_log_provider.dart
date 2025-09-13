// lib/providers/battle_log_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 戰鬥日誌條目類型
enum BattleLogType {
  playerAction, // 玩家行動 - 藍色
  enemyAction, // 敵人行動 - 紅色
  statusEffect, // 狀態效果 - 橙色
  battleEvent, // 戰鬥事件 - 白色
  systemMessage, // 系統訊息 - 灰色
}

/// 戰鬥日誌條目
class BattleLogEntry {
  final String id;
  final DateTime timestamp;
  final BattleLogType type;
  final String actorName; // 角色名稱
  final String actionName; // 技能/效果名稱
  final String result; // 處理結果
  final String fullMessage; // 完整訊息
  final Color textColor; // 文字顏色

  const BattleLogEntry({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.actorName,
    required this.actionName,
    required this.result,
    required this.fullMessage,
    required this.textColor,
  });

  /// 創建玩家行動日誌
  factory BattleLogEntry.playerAction({
    required String characterName,
    required String skillName,
    required String result,
  }) {
    final message = '[$characterName] 使用了 [$skillName] $result';
    return BattleLogEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      type: BattleLogType.playerAction,
      actorName: characterName,
      actionName: skillName,
      result: result,
      fullMessage: message,
      textColor: const Color(0xFF2196F3), // 藍色
    );
  }

  /// 創建敵人行動日誌
  factory BattleLogEntry.enemyAction({
    required String enemyName,
    required String actionName,
    required String result,
  }) {
    final message = '[$enemyName] 使用了 [$actionName] $result';
    return BattleLogEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      type: BattleLogType.enemyAction,
      actorName: enemyName,
      actionName: actionName,
      result: result,
      fullMessage: message,
      textColor: const Color(0xFFF44336), // 紅色
    );
  }

  /// 創建狀態效果日誌
  factory BattleLogEntry.statusEffect({
    required String effectName,
    required String result,
    required bool isPositive,
  }) {
    final message = '[$effectName] $result';
    return BattleLogEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      type: BattleLogType.statusEffect,
      actorName: '',
      actionName: effectName,
      result: result,
      fullMessage: message,
      textColor: isPositive
          ? const Color(0xFF4CAF50) // 綠色 (HOT/BUFF)
          : const Color(0xFFFF9800), // 橙色 (DOT/DEBUFF)
    );
  }

  /// 創建戰鬥事件日誌
  factory BattleLogEntry.battleEvent({required String message}) {
    return BattleLogEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      type: BattleLogType.battleEvent,
      actorName: '',
      actionName: '',
      result: '',
      fullMessage: message,
      textColor: const Color(0xFFFFFFFF), // 白色
    );
  }

  /// 創建系統訊息日誌
  factory BattleLogEntry.systemMessage({required String message}) {
    return BattleLogEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      type: BattleLogType.systemMessage,
      actorName: '',
      actionName: '',
      result: '',
      fullMessage: message,
      textColor: const Color(0xFF9E9E9E), // 灰色
    );
  }
}

/// 戰鬥日誌管理器
class BattleLogNotifier extends StateNotifier<List<BattleLogEntry>> {
  BattleLogNotifier() : super([]);

  /// 添加日誌條目
  void addEntry(BattleLogEntry entry) {
    state = [...state, entry];

    // 限制日誌數量，保留最新的100條
    if (state.length > 100) {
      state = state.sublist(state.length - 100);
    }
  }

  /// 添加玩家行動日誌
  void addPlayerAction({
    required String characterName,
    required String skillName,
    required String result,
  }) {
    addEntry(
      BattleLogEntry.playerAction(
        characterName: characterName,
        skillName: skillName,
        result: result,
      ),
    );
  }

  /// 添加敵人行動日誌
  void addEnemyAction({
    required String enemyName,
    required String actionName,
    required String result,
  }) {
    addEntry(
      BattleLogEntry.enemyAction(
        enemyName: enemyName,
        actionName: actionName,
        result: result,
      ),
    );
  }

  /// 添加狀態效果日誌
  void addStatusEffect({
    required String effectName,
    required String result,
    required bool isPositive,
  }) {
    addEntry(
      BattleLogEntry.statusEffect(
        effectName: effectName,
        result: result,
        isPositive: isPositive,
      ),
    );
  }

  /// 添加戰鬥事件日誌
  void addBattleEvent(String message) {
    addEntry(BattleLogEntry.battleEvent(message: message));
  }

  /// 添加系統訊息日誌
  void addSystemMessage(String message) {
    addEntry(BattleLogEntry.systemMessage(message: message));
  }

  /// 清空日誌
  void clearLog() {
    state = [];
  }

  /// 獲取最新的N條日誌
  List<BattleLogEntry> getRecentEntries(int count) {
    if (state.length <= count) return state;
    return state.sublist(state.length - count);
  }
}

/// 戰鬥日誌 Provider
final battleLogProvider =
    StateNotifierProvider<BattleLogNotifier, List<BattleLogEntry>>((ref) {
      return BattleLogNotifier();
    });

/// 日誌展開狀態 Provider
final logExpandedProvider = StateProvider<bool>((ref) => false);

// ================================
// 戰鬥日誌 UI 組件
// ================================

/// 戰鬥日誌顯示組件
class BattleLogWidget extends ConsumerWidget {
  const BattleLogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logEntries = ref.watch(battleLogProvider);
    final isExpanded = ref.watch(logExpandedProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border.all(color: Colors.grey[600]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 日誌標題欄
          _buildLogHeader(context, ref, isExpanded, logEntries.length),

          // 日誌內容區域
          if (isExpanded) _buildLogContent(logEntries),
        ],
      ),
    );
  }

  /// 構建日誌標題欄
  Widget _buildLogHeader(
    BuildContext context,
    WidgetRef ref,
    bool isExpanded,
    int entryCount,
  ) {
    return InkWell(
      onTap: () => ref.read(logExpandedProvider.notifier).state = !isExpanded,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(8),
            bottom: isExpanded ? Radius.zero : const Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '戰鬥日誌 ($entryCount)',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// 構建日誌內容區域
  Widget _buildLogContent(List<BattleLogEntry> entries) {
    if (entries.isEmpty) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        child: const Text(
          '暫無戰鬥記錄',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      );
    }

    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        reverse: true, // 最新的在最上面
        itemBuilder: (context, index) {
          final entry = entries[entries.length - 1 - index];
          return _buildLogEntry(entry);
        },
      ),
    );
  }

  /// 構建單個日誌條目
  Widget _buildLogEntry(BattleLogEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 時間戳
          Text(
            _formatTime(entry.timestamp),
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 8),

          // 日誌內容
          Expanded(
            child: Text(
              entry.fullMessage,
              style: TextStyle(
                color: entry.textColor,
                fontSize: 11,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化時間
  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${time.second.toString().padLeft(2, '0')}';
  }
}

// ================================
// 戰鬥日誌輔助方法
// ================================

/// 戰鬥日誌輔助工具類
class BattleLogHelper {
  /// 格式化傷害結果
  static String formatDamageResult(int damage, String targetName) {
    return '對 $targetName 造成 $damage 點傷害';
  }

  /// 格式化治療結果
  static String formatHealResult(int healing, String targetName) {
    return '為 $targetName 恢復 $healing 點生命值';
  }

  /// 格式化DOT傷害結果
  static String formatDotResult(int damage, String targetName) {
    return '對 $targetName 造成 $damage 點持續傷害';
  }

  /// 格式化HOT治療結果
  static String formatHotResult(int healing, String targetName) {
    return '為 $targetName 恢復 $healing 點持續治療';
  }

  /// 格式化BUFF效果結果
  static String formatBuffResult(String effectName, String targetName) {
    return '為 $targetName 施加了 $effectName 效果';
  }

  /// 格式化DEBUFF效果結果
  static String formatDebuffResult(String effectName, String targetName) {
    return '對 $targetName 施加了 $effectName 效果';
  }

  /// 格式化技能使用失敗結果
  static String formatSkillFailResult(String reason) {
    return '技能使用失敗：$reason';
  }

  /// 格式化防禦結果
  static String formatDefenseResult(String targetName) {
    return '$targetName 進入防禦狀態';
  }

  /// 格式化逃跑結果
  static String formatEscapeResult(bool success) {
    return success ? '成功逃離戰鬥' : '逃跑失敗';
  }

  /// 格式化戰鬥結束結果
  static String formatBattleEndResult(String result) {
    switch (result) {
      case 'victory':
        return '戰鬥勝利！';
      case 'defeat':
        return '戰鬥失敗...';
      case 'escaped':
        return '成功逃離戰鬥';
      default:
        return '戰鬥結束';
    }
  }
}
