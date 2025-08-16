// ============================================================================
// 檔案位置: lib/main.dart
// 更新主程式以使用新的遊戲畫面

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/screens/battle_screen.dart';

void main() {
  runApp(
    // ProviderScope是Riverpod的根容器
    const ProviderScope(child: RougelikeGameApp()),
  );
}

class RougelikeGameApp extends StatelessWidget {
  const RougelikeGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Rouge-like Game',
    //   theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    //   home: const GameScreen(), // 主要遊戲畫面
    // );
    return MaterialApp(
      title: 'Rouge-like Game',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const BattleScreen(), // 使用BattleScreen
    );
  }
}
