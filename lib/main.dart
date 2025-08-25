// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/screens/battle_screen_update.dart';

import 'services/skill_service.dart';
import 'services/status_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('應用啟動: 開始載入遊戲數據...');

  try {
    // 載入技能數據
    print('載入技能數據...');
    await SkillService.loadSkills();
    print('技能數據載入完成');

    // 載入狀態效果模板
    print('載入狀態效果模板...');
    await StatusService.loadStatusTemplates();
    print('狀態效果模板載入完成');

    print('所有遊戲數據載入完成');
  } catch (e) {
    print('數據載入失敗: $e');
    // 可以選擇顯示錯誤對話框或使用預設數據
  }

  runApp(
    // ProviderScope是Riverpod的根容器
    const ProviderScope(child: RougelikeGameApp()),
  );
}

class RougelikeGameApp extends StatelessWidget {
  const RougelikeGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rouge-like Game',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const BattleScreen(), // 使用BattleScreen
    );
  }
}
