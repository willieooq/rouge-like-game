// lib/main.dart 更新版本
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/dependency_injection.dart';
import 'screens/error_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/main_menu_screen.dart';

void main() {
  runApp(const ProviderScope(child: RougelikeGameApp()));
}

class RougelikeGameApp extends ConsumerWidget {
  const RougelikeGameApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 監聽遊戲初始化狀態
    final gameInitAsync = ref.watch(gameInitializationProvider);

    return MaterialApp(
      title: 'Rouge-like Game',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: gameInitAsync.when(
        data: (isInitialized) => isInitialized
            ? const MainMenuScreen() // 初始化成功顯示主選單
            : const ErrorScreen(error: '遊戲初始化失敗'), // 初始化失敗
        loading: () => const LoadingScreen(), // 載入中
        error: (error, stack) => ErrorScreen(error: error), // 發生錯誤
      ),
    );
  }
}
