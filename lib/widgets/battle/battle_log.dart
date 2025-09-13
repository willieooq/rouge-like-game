// lib/widgets/battle/expandable_battle_log.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/battle_log_provider.dart';

class BattleLog extends ConsumerStatefulWidget {
  const BattleLog({super.key});

  @override
  ConsumerState<BattleLog> createState() => _BattleLogState();
}

class _BattleLogState extends ConsumerState<BattleLog>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  // 常量定义
  static const double _collapsedHeight = 60.0; // 3行文字的高度
  static const int _collapsedLines = 3; // 收缩时显示的行数

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    final isExpanded = ref.read(logExpandedProvider);
    ref.read(logExpandedProvider.notifier).state = !isExpanded;

    if (!isExpanded) {
      // 展开后滚动到底部显示最新日志
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _collapse() {
    ref.read(logExpandedProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.5; // 半个屏幕高度
    final isExpanded = ref.watch(logExpandedProvider);
    final logEntries = ref.watch(battleLogProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      // 添加緩動曲線讓動畫更流暢
      height: isExpanded ? expandedHeight : _collapsedHeight,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border.all(color: Colors.grey[600]!),
      ),
      child: Stack(
        children: [
          // 主要內容 - 使用 AnimatedSwitcher 讓內容切換也有動畫
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: isExpanded
                ? _buildExpandedLogContent(logEntries)
                : _buildCollapsedLogContent(logEntries),
          ),

          // 展開狀態的背景點擊區域
          if (isExpanded)
            Positioned.fill(
              child: GestureDetector(
                onTap: _collapse,
                child: Container(color: Colors.transparent),
              ),
            ),
        ],
      ),
    );
  }

  /// 構建收縮狀態的日誌內容（顯示最新3行）
  Widget _buildCollapsedLogContent(List<BattleLogEntry> entries) {
    final recentEntries = entries.length > _collapsedLines
        ? entries.sublist(entries.length - _collapsedLines)
        : entries;

    return GestureDetector(
      onTap: _toggleExpansion, // 整個區域可點擊展開
      child: Container(
        height: _collapsedHeight,
        padding: const EdgeInsets.all(4),
        child: entries.isEmpty
            ? const Center(
                child: Text(
                  '暫無戰鬥日誌 - 點擊展開',
                  style: TextStyle(color: Colors.white54, fontSize: 10),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 第一筆日誌（帶箭頭）
                  if (recentEntries.isNotEmpty)
                    _buildFirstLogEntry(recentEntries.first, isCollapsed: true),

                  // 其餘日誌條目
                  ...recentEntries
                      .skip(1)
                      .map((entry) => _buildLogEntry(entry, isCollapsed: true)),
                ],
              ),
      ),
    );
  }

  Widget _buildExpandedLogContent(List<BattleLogEntry> entries) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: const [
              Spacer(),
              Icon(Icons.keyboard_arrow_up, color: Colors.white70, size: 16),
            ],
          ),
          // 日誌列表
          Expanded(
            child: entries.isEmpty
                ? const Center(
                    child: Text(
                      '暫無戰鬥日誌',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: entries.length,
                    reverse: true, // 最新的在最上面
                    itemBuilder: (context, index) {
                      final entry = entries[entries.length - 1 - index];
                      return _buildLogEntry(entry, isCollapsed: false);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// 構建第一條日誌條目（收縮狀態下帶箭頭）
  Widget _buildFirstLogEntry(
    BattleLogEntry entry, {
    required bool isCollapsed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 日誌類型圖示
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 1, right: 4),
            decoration: BoxDecoration(
              color: _getLogTypeColor(entry.type),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getLogTypeIcon(entry.type),
              size: 8,
              color: Colors.white,
            ),
          ),

          // 日誌內容
          Expanded(
            child: Text(
              entry.fullMessage,
              style: TextStyle(
                color: entry.textColor,
                fontSize: 10,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // 箭頭圖示（最右邊）
          Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 12),
        ],
      ),
    );
  }

  /// 构建单条日志条目
  Widget _buildLogEntry(BattleLogEntry entry, {required bool isCollapsed}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 时间戳（展开时显示）
          if (!isCollapsed) ...[
            Text(
              _formatTime(entry.timestamp),
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(width: 8),
          ],

          // 日志类型图标
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 1, right: 4),
            decoration: BoxDecoration(
              color: _getLogTypeColor(entry.type),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getLogTypeIcon(entry.type),
              size: 8,
              color: Colors.white,
            ),
          ),

          // 日志内容
          Expanded(
            child: Text(
              entry.fullMessage,
              style: TextStyle(
                color: entry.textColor,
                fontSize: isCollapsed ? 10 : 11,
                height: 1.2,
              ),
              maxLines: isCollapsed ? 1 : null,
              overflow: isCollapsed ? TextOverflow.ellipsis : null,
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化时间显示
  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}';
  }

  /// 获取日志类型对应的颜色
  Color _getLogTypeColor(BattleLogType type) {
    switch (type) {
      case BattleLogType.playerAction:
        return Colors.blue;
      case BattleLogType.enemyAction:
        return Colors.red;
      case BattleLogType.statusEffect:
        return Colors.purple;
      case BattleLogType.battleEvent:
        return Colors.yellow;
      case BattleLogType.systemMessage:
        return Colors.grey;
    }
  }

  /// 获取日志类型对应的图标
  IconData _getLogTypeIcon(BattleLogType type) {
    switch (type) {
      case BattleLogType.playerAction:
        return Icons.play_arrow;
      case BattleLogType.enemyAction:
        return Icons.warning;
      case BattleLogType.statusEffect:
        return Icons.auto_fix_high;
      case BattleLogType.battleEvent:
        return Icons.event;
      case BattleLogType.systemMessage:
        return Icons.settings;
    }
  }
}
