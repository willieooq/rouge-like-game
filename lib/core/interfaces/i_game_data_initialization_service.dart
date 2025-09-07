abstract class IGameDataInitializationService {
  /// 初始化所有游戏数据
  Future<void> initializeGameData();

  /// 载入技能数据
  Future<void> loadSkills();

  /// 载入状态效果模板
  Future<void> loadStatusTemplates();

  /// 载入敌人数据
  Future<void> loadEnemies();

  /// 检查是否所有数据都已载入
  bool get isDataLoaded;

  /// 获取载入进度 (0.0 - 1.0)
  double get loadingProgress;
}
