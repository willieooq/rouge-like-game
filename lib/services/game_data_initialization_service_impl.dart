// lib/services/game_data_initialization_service_impl.dart
import 'dart:convert';

import 'package:flutter/services.dart';

import '../core/interfaces/i_game_data_initialization_service.dart';
import '../services/skill_service.dart';
import '../services/status_service_impl.dart';

/// 游戏数据初始化服务实现
class GameDataInitializationServiceImpl
    implements IGameDataInitializationService {
  bool _skillsLoaded = false;
  bool _statusTemplatesLoaded = false;
  bool _enemiesLoaded = false;

  @override
  bool get isDataLoaded =>
      _skillsLoaded && _statusTemplatesLoaded && _enemiesLoaded;

  @override
  double get loadingProgress {
    int loadedCount = 0;
    if (_skillsLoaded) loadedCount++;
    if (_statusTemplatesLoaded) loadedCount++;
    if (_enemiesLoaded) loadedCount++;
    return loadedCount / 3.0;
  }

  @override
  Future<void> initializeGameData() async {
    print('应用启动: 开始载入游戏数据...');

    try {
      // 并行载入所有数据
      await Future.wait([loadSkills(), loadStatusTemplates(), loadEnemies()]);

      print('所有游戏数据载入完成');
    } catch (e) {
      print('数据载入失败: $e');
      rethrow; // 重新抛出异常让调用者处理
    }
  }

  @override
  Future<void> loadSkills() async {
    if (_skillsLoaded) return; // 已载入过

    print('载入技能数据...');
    try {
      await SkillService.loadSkills();
      _skillsLoaded = true;
      print('技能数据载入完成');
    } catch (e) {
      print('载入技能数据失败: $e');
      rethrow;
    }
  }

  @override
  Future<void> loadStatusTemplates() async {
    if (_statusTemplatesLoaded) return; // 已载入过

    print('载入状态效果模板...');
    try {
      await _loadStatusTemplatesFromAssets();
      _statusTemplatesLoaded = true;
      print('状态效果模板载入完成');
    } catch (e) {
      print('载入状态效果模板失败: $e');
      rethrow;
    }
  }

  @override
  Future<void> loadEnemies() async {
    if (_enemiesLoaded) return; // 已载入过

    print('载入敌人数据...');
    try {
      // TODO: 实现敌人数据载入
      // await EnemyService.loadEnemies();
      _enemiesLoaded = true;
      print('敌人数据载入完成');
    } catch (e) {
      print('载入敌人数据失败: $e');
      rethrow;
    }
  }

  // ===== 私有方法 =====

  /// 从资源文件载入状态模板
  Future<void> _loadStatusTemplatesFromAssets() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/status_templates.json',
    );
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // 通过StatusServiceImpl的静态方法设置缓存
    StatusServiceImpl.setStatusTemplateCache(jsonData);
  }
}
