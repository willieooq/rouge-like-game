// ============================================================================
// 檔案位置: lib/screens/game_screen.dart
// 遊戲主畫面

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rouge-like Game - Phase 1'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Phase 1: 基礎角色系統',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              '點擊技能按鈕來使用技能，觀察Cost的變化',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // 角色卡片
            // CharacterCard(),
            SizedBox(height: 24),
            Text(
              '功能說明:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• 斬擊：消耗2 Cost的基礎攻擊'),
            Text('• 重擊：消耗4 Cost的強力攻擊'),
            Text('• 恢復+2：恢復2點Cost'),
            Text('• 完全恢復：恢復到滿Cost'),
            Text('• Cost不足時按鈕會自動禁用'),
            SizedBox(height: 16),
            Text(
              '下一步：擴展到5個角色的隊伍系統',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
