// lib/widgets/battle/enemy_action_queue.dart
import 'package:flutter/material.dart';

import '../../models/enemy/enemy_action.dart';

/// 敵人行動隊列顯示組件
///
/// 遵循 Single Responsibility Principle：
/// 專門負責顯示敵人的行動隊列和處理玩家的選擇
class EnemyActionQueue extends StatelessWidget {
  final List<EnemyAction> actionQueue;
  final EnemyAction? selectedAction;
  final Function(EnemyAction)? onActionSelected;
  final bool isPlayerTurn;

  const EnemyActionQueue({
    super.key,
    required this.actionQueue,
    this.selectedAction,
    this.onActionSelected,
    this.isPlayerTurn = true,
  });

  @override
  Widget build(BuildContext context) {
    if (actionQueue.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 標題
          Row(
            children: [
              // Icon(Icons.schedule, color: Colors.red[600], size: 18),
              // const SizedBox(width: 6),
              // Text(
              //   '敵人本回合行動',
              //   style: TextStyle(
              //     color: Colors.red[700],
              //     fontSize: 14,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              if (!isPlayerTurn) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 8),

          // 行動列表 - 使用 SingleChildScrollView 避免溢出
          SizedBox(
            height: 50, // 限制高度
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: actionQueue.asMap().entries.map((entry) {
                  final index = entry.key;
                  final action = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: _buildActionCard(action, index),
                  );
                }).toList(),
              ),
            ),
          ),

          // 提示文字
          if (isPlayerTurn && actionQueue.any((a) => a.isTargetable)) ...[
            const SizedBox(height: 4),
            Text(
              '點擊可無效化的行動',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 構建行動卡片
  Widget _buildActionCard(EnemyAction action, int index) {
    final isSelected = selectedAction?.id == action.id;
    final canInteract =
        isPlayerTurn && action.isTargetable && onActionSelected != null;

    return GestureDetector(
      onTap: canInteract ? () => onActionSelected!(action) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minWidth: 80, maxWidth: 120),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: _getActionBackgroundColor(action, isSelected),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: _getActionBorderColor(action, isSelected),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _getActionColor(action).withValues(alpha: 0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 第一行：順序號碼和圖標
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 順序號碼
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _getActionColor(action),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 4),

                // 行動圖標
                Icon(
                  _getActionIcon(action.type),
                  size: 14,
                  color: _getActionColor(action),
                ),

                // 狀態指示器
                if (!action.isTargetable) ...[
                  const SizedBox(width: 2),
                  Icon(Icons.lock, size: 10, color: Colors.grey[600]),
                ],

                if (isSelected) ...[
                  const SizedBox(width: 2),
                  Icon(Icons.close, size: 12, color: Colors.red[600]),
                ],
              ],
            ),

            const SizedBox(height: 2),

            // 第二行：行動名稱
            Text(
              action.name,
              style: TextStyle(
                color: canInteract ? Colors.black87 : Colors.grey[600],
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// 獲取行動圖標
  IconData _getActionIcon(EnemyActionType type) {
    switch (type) {
      case EnemyActionType.attack:
        return Icons.shelves;
      case EnemyActionType.skill:
        return Icons.auto_fix_high;
      case EnemyActionType.defend:
        return Icons.shield;
      case EnemyActionType.buff:
        return Icons.trending_up;
      case EnemyActionType.debuff:
        return Icons.trending_down;
      case EnemyActionType.special:
        return Icons.star;
    }
  }

  /// 獲取行動顏色
  Color _getActionColor(EnemyAction action) {
    try {
      return Color(int.parse(action.color.replaceFirst('#', '0xFF')));
    } catch (e) {
      return _getDefaultActionColor(action.type);
    }
  }

  /// 獲取預設行動顏色
  Color _getDefaultActionColor(EnemyActionType type) {
    switch (type) {
      case EnemyActionType.attack:
        return Colors.red[600]!;
      case EnemyActionType.skill:
        return Colors.purple[600]!;
      case EnemyActionType.defend:
        return Colors.blue[600]!;
      case EnemyActionType.buff:
        return Colors.orange[600]!;
      case EnemyActionType.debuff:
        return Colors.purple[800]!;
      case EnemyActionType.special:
        return Colors.amber[700]!;
    }
  }

  /// 獲取行動背景顏色
  Color _getActionBackgroundColor(EnemyAction action, bool isSelected) {
    if (isSelected) {
      return Colors.red[50]!;
    }
    if (!action.isTargetable) {
      return Colors.grey[200]!;
    }
    return Colors.white;
  }

  /// 獲取行動邊框顏色
  Color _getActionBorderColor(EnemyAction action, bool isSelected) {
    if (isSelected) {
      return Colors.red[400]!;
    }
    if (!action.isTargetable) {
      return Colors.grey[400]!;
    }
    return _getActionColor(action);
  }
}

/// 行動詳細信息對話框
class ActionDetailDialog extends StatelessWidget {
  final EnemyAction action;

  const ActionDetailDialog({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 標題
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: _getActionColor(action.type),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    action.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 行動類型
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getActionColor(action.type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                action.getTypeDisplayName(),
                style: TextStyle(
                  color: _getActionColor(action.type),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 描述
            Text(
              action.description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 12),

            // 屬性信息
            if (action.parameters.isNotEmpty) ...[
              Text(
                '效果詳情:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              ...action.parameters.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    children: [
                      Text(
                        '• ${_formatParameterName(entry.key)}: ',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      Text(
                        '${entry.value}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],

            // 特殊屬性
            Row(
              children: [
                if (!action.isTargetable)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('無法阻止', style: TextStyle(fontSize: 10)),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('關閉'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getActionColor(EnemyActionType type) {
    switch (type) {
      case EnemyActionType.attack:
        return Colors.red[600]!;
      case EnemyActionType.skill:
        return Colors.purple[600]!;
      case EnemyActionType.defend:
        return Colors.blue[600]!;
      case EnemyActionType.buff:
        return Colors.orange[600]!;
      case EnemyActionType.debuff:
        return Colors.purple[800]!;
      case EnemyActionType.special:
        return Colors.amber[700]!;
    }
  }

  String _formatParameterName(String key) {
    switch (key) {
      case 'damage':
        return '傷害';
      case 'healAmount':
        return '治療量';
      case 'defenseBoost':
        return '防禦提升';
      case 'duration':
        return '持續回合';
      case 'buffType':
        return '增益類型';
      case 'debuffType':
        return '減益類型';
      default:
        return key;
    }
  }
}
