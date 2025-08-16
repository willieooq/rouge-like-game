import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // ProviderScope 是 Riverpod 的根容器 (類似 Spring ApplicationContext)
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
      home: const GameHomeScreen(),
    );
  }
}

class GameHomeScreen extends ConsumerWidget {
  const GameHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rouge-like Game'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '歡迎來到Rouge-like遊戲！',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Phase 1: 基礎架構建立中...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
