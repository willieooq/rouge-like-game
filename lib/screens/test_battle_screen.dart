// lib/screens/test_battle_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dependency_injection.dart';
import '../data/test_characters.dart';
import '../models/enemy/enemy.dart';
import '../models/party/party.dart';
import '../shared/beans/skill/skill_execution_request.dart';

class TestBattleScreen extends ConsumerStatefulWidget {
  const TestBattleScreen({super.key});

  @override
  ConsumerState<TestBattleScreen> createState() => _TestBattleScreenState();
}

class _TestBattleScreenState extends ConsumerState<TestBattleScreen> {
  String _message = '準備中...';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('測試戰鬥')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '重構測試介面',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 狀態訊息
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_message, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),

            // 測試按鈕們
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _testSkillService,
                  child: const Text('測試技能服務'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testEnemyService,
                  child: const Text('測試敵人服務'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testBattleSystem,
                  child: const Text('測試戰鬥系統'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testSkillExecution,
                  child: const Text('測試技能執行'),
                ),
              ],
            ),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  void _testSkillService() async {
    setState(() {
      _isLoading = true;
      _message = '正在測試技能服務...';
    });

    try {
      final skillService = ref.read(skillServiceProvider);
      await skillService.loadSkills();

      // 測試獲取技能
      final skill = skillService.getSkill('fireball');
      if (skill != null) {
        setState(() {
          _message =
              '技能服務測試成功!\n找到技能: ${skill.name}\n消耗: ${skill.cost}\n傷害: ${skill.damage}';
        });
      } else {
        setState(() {
          _message = '技能服務測試失敗: 找不到 fireball 技能';
        });
      }
    } catch (e) {
      setState(() {
        _message = '技能服務測試失敗: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _testEnemyService() async {
    setState(() {
      _isLoading = true;
      _message = '正在測試敵人服務...';
    });

    try {
      final enemyService = ref.read(enemyServiceProvider);
      await enemyService.initialize();

      final stats = enemyService.getStatistics();
      setState(() {
        _message =
            '敵人服務測試成功!\n'
            '總敵人數: ${stats['total']}\n'
            '普通: ${stats['normal']}\n'
            '精英: ${stats['elite']}\n'
            'Boss: ${stats['boss']}';
      });
    } catch (e) {
      setState(() {
        _message = '敵人服務測試失敗: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _testBattleSystem() async {
    setState(() {
      _isLoading = true;
      _message = '正在測試戰鬥系統...';
    });

    try {
      final battleSystemServices = ref.read(battleSystemProvider);

      setState(() {
        _message =
            '戰鬥系統測試成功!\n'
            '所有服務已正確注入:\n'
            '- 戰鬥服務: ${battleSystemServices.battleService.runtimeType}\n'
            '- 技能服務: ${battleSystemServices.skillService.runtimeType}\n'
            '- 敵人服務: ${battleSystemServices.enemyService.runtimeType}\n'
            '- 狀態服務: ${battleSystemServices.statusService.runtimeType}';
      });
    } catch (e) {
      setState(() {
        _message = '戰鬥系統測試失敗: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _testSkillExecution() async {
    setState(() {
      _isLoading = true;
      _message = '正在測試技能執行...';
    });

    try {
      final skillService = ref.read(skillServiceProvider);
      await skillService.loadSkills();

      // 創建測試數據
      const testParty = Party(
        characters: TestCharacters.defaultParty,
        sharedHp: 100,
        maxHp: 100,
        currentTurnCost: 10,
        maxTurnCost: 10,
      );

      final testEnemy = Enemy(
        id: 'test_enemy',
        name: '測試敵人',
        type: EnemyType.normal,
        aiBehavior: AIBehavior.balanced,
        maxHp: 50,
        currentHp: 50,
        attack: 10,
        defense: 2,
        speed: 5,
        iconPath: '',
        description: '用於測試的敵人',
        skillIds: [],
        expReward: 10,
        goldReward: 20,
      );

      // 測試技能執行請求
      final request = SkillExecutionRequest(
        skillId: 'fireball',
        casterId: testParty.characters.first.id,
        allies: testParty.characters,
        enemies: [testEnemy],
        targetIds: [testEnemy.id],
      );

      final response = await skillService.executeSkill(request);

      setState(() {
        _message =
            '技能執行測試${response.success ? "成功" : "失敗"}!\n'
            '技能: ${response.skillId}\n'
            '施法者: ${response.casterId}\n'
            '效果鏈數量: ${response.effectChains.length}\n'
            '訊息: ${response.message}';
      });
    } catch (e) {
      setState(() {
        _message = '技能執行測試失敗: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
