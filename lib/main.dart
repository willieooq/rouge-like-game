// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rouge_project/screens/battle_screen_update.dart';

import 'services/game_data_initialization_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 創建初始化服務
  final initializationService = GameDataInitializationServiceImpl();

  try {
    // 初始化所有遊戲數據
    await initializationService.initializeGameData();

    // 所有數據載入成功，啟動應用
    runApp(const ProviderScope(child: RougelikeGameApp()));
  } catch (e) {
    print('應用啟動失敗: $e');

    // 可以選擇顯示錯誤畫面或使用預設數據
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text('遊戲數據載入失敗'),
                const SizedBox(height: 8),
                Text('錯誤: $e'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // 重新啟動應用
                    main();
                  },
                  child: const Text('重試'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 如果你想要顯示載入進度，可以使用這個版本：
void mainWithLoadingProgress() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initializationService = GameDataInitializationServiceImpl();

  // 顯示載入畫面
  runApp(
    MaterialApp(
      home: GameLoadingScreen(initializationService: initializationService),
    ),
  );
}

/// 遊戲載入畫面（可選）
class GameLoadingScreen extends StatefulWidget {
  final GameDataInitializationServiceImpl initializationService;

  const GameLoadingScreen({Key? key, required this.initializationService})
    : super(key: key);

  @override
  State<GameLoadingScreen> createState() => _GameLoadingScreenState();
}

class _GameLoadingScreenState extends State<GameLoadingScreen> {
  String _loadingText = '初始化中...';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    try {
      // 監控載入進度
      await widget.initializationService.initializeGameData();

      // 載入完成，切換到主應用
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                const ProviderScope(child: RougelikeGameApp()),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingText = '載入失敗: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Rouge-like Game',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            CircularProgressIndicator(
              value: widget.initializationService.loadingProgress,
              color: Colors.amber,
            ),
            const SizedBox(height: 16),
            Text(_loadingText, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(
              '${(widget.initializationService.loadingProgress * 100).toInt()}%',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
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
