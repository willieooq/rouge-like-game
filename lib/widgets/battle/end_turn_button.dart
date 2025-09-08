// lib/widgets/battle/end_turn_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/models/battle/battle_state.dart';

import '../../providers/battle_provider.dart';
import '../../providers/party_provider.dart';

/// 結束回合按鈕組件
class EndTurnButton extends ConsumerWidget {
  const EndTurnButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final battleState = ref.watch(battleProvider);
    final party = ref.watch(partyProvider);

    // 只在玩家回合時顯示
    if (!battleState!.isPlayerTurn || !battleState.isBattleOngoing) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cost 顯示
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(
              'Cost: ${party.currentTurnCost}/${party.maxTurnCost}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // 結束回合按鈕
          ElevatedButton(
            onPressed: () {
              print('UI: 玩家點擊結束回合按鈕');
              ref.read(battleProvider.notifier).endPlayerTurn();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '結束回合',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
