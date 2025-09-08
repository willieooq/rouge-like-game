// lib/screens/main_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/screens/test_battle_screen.dart';

import '../core/dependency_injection.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rouge-like Game'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Rouge-like Game',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // 開始遊戲按鈕
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TestBattleScreen(),
                    ),
                  );
                },
                child: const Text('開始遊戲', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),

            // 測試服務按鈕
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _testServices(context, ref),
                child: const Text('測試服務', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),

            // 設定按鈕
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('設定功能開發中...')));
                },
                child: const Text('設定', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _testServices(BuildContext context, WidgetRef ref) async {
    try {
      // 測試技能服務
      final skillService = ref.read(skillServiceProvider);
      await skillService.loadSkills();

      // 測試敵人服務
      final enemyService = ref.read(enemyServiceProvider);
      await enemyService.initialize();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('所有服務測試通過!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('服務測試失敗: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
