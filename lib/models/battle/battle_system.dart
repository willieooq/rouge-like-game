// // lib/models/battle/battle_system.dart
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// import '../character/character.dart';
// import '../enemy/enemy.dart';
// import '../status/status_effect.dart';
//
// part 'battle_system.freezed.dart';
// part 'battle_system.g.dart';
//
// /// 戰鬥階段
// enum BattlePhase {
//   @JsonValue('preparation')
//   preparation, // 準備階段
//   @JsonValue('player_turn')
//   playerTurn, // 玩家回合
//   @JsonValue('enemy_turn')
//   enemyTurn, // 敵人回合
//   @JsonValue('battle_end')
//   battleEnd, // 戰鬥結束
// }
//
// /// 戰鬥結果
// enum BattleResult {
//   @JsonValue('ongoing')
//   ongoing, // 戰鬥進行中
//   @JsonValue('victory')
//   victory, // 玩家勝利
//   @JsonValue('defeat')
//   defeat, // 玩家失敗
//   @JsonValue('escaped')
//   escaped, // 玩家逃跑
// }
//
// /// 敵人行動類型
// enum EnemyActionType {
//   @JsonValue('attack')
//   attack, // 攻擊
//   @JsonValue('skill')
//   skill, // 技能
//   @JsonValue('defend')
//   defend, // 防禦
//   @JsonValue('buff')
//   buff, // 增益
//   @JsonValue('debuff')
//   debuff, // 減益
//   @JsonValue('special')
//   special, // 特殊行動
// }
//
// /// 敵人行動
// @freezed
// abstract class EnemyAction with _$EnemyAction {
//   const factory EnemyAction({
//     required String id, // 行動ID
//     required String name, // 行動名稱
//     required String description, // 行動描述
//     required EnemyActionType type, // 行動類型
//     required String skillId, // 對應的技能ID
//     @Default(1) int priority, // 優先級（數字越小越優先）
//     @Default(false) bool isInterruptible, // 是否可被打斷
//     @Default(false) bool isTargetable, // 是否可被選中無效化
//     @Default('#FF6B6B') String color, // 顯示顏色
//     @Default('') String iconPath, // 圖標路徑
//   }) = _EnemyAction;
//
//   factory EnemyAction.fromJson(Map<String, dynamic> json) =>
//       _$EnemyActionFromJson(json);
// }
//
// /// 戰鬥狀態
// @freezed
// abstract class BattleState with _$BattleState {
//   const factory BattleState({
//     // 基本狀態
//     required BattlePhase currentPhase,
//     required BattleResult result,
//     required int turnNumber,
//     @Default(false) bool playerHasFirstTurn, // 玩家是否擁有先手
//     // 參戰單位
//     required List<Character> playerParty,
//     required Enemy enemy,
//
//     // 狀態效果管理
//     required StatusEffectManager playerStatusManager,
//     required StatusEffectManager enemyStatusManager,
//
//     // 敵人行動隊列
//     required List<EnemyAction> enemyActionQueue,
//     @Default(-1) int currentEnemyActionIndex, // 當前執行的行動索引
//     // 戰鬥統計
//     @Default(0) int totalDamageDealt,
//     @Default(0) int totalDamageReceived,
//     @Default(0) int turnCount,
//
//     // 選擇狀態
//     @Default(null) EnemyAction? selectedEnemyAction, // 玩家選中要無效的敵人行動
//     // 戰鬥設定
//     @Default(false) bool canEscape, // 是否可以逃跑
//     @Default(0.7) double baseEscapeChance, // 基礎逃跑成功率
//   }) = _BattleState;
// }
//
// /// 戰鬥管理器
// class BattleManager {
//   BattleState _state;
//
//   BattleManager(this._state);
//
//   BattleState get state => _state;
//
//   /// 初始化戰鬥
//   void initializeBattle({
//     required List<Character> playerParty,
//     required Enemy enemy,
//     required bool canEscape,
//   }) {
//     // 檢查敵人是否有先手技能
//     final hasFirstStrike = _checkEnemyFirstStrike(enemy);
//
//     // 生成敵人行動隊列
//     final actionQueue = _generateEnemyActionQueue(enemy);
//
//     _state = _state.copyWith(
//       currentPhase: BattlePhase.preparation,
//       result: BattleResult.ongoing,
//       turnNumber: 1,
//       playerHasFirstTurn: !hasFirstStrike,
//       playerParty: playerParty,
//       enemy: enemy,
//       playerStatusManager: StatusEffectManager(),
//       enemyStatusManager: StatusEffectManager(),
//       enemyActionQueue: actionQueue,
//       canEscape: canEscape,
//     );
//
//     // 如果敵人有先手，立即執行先手行動
//     if (hasFirstStrike) {
//       _executeEnemyFirstStrike();
//     }
//
//     // 開始第一個回合
//     _startNextTurn();
//   }
//
//   /// 開始下一個回合
//   void _startNextTurn() {
//     if (_state.result != BattleResult.ongoing) return;
//
//     if (_state.playerHasFirstTurn) {
//       _startPlayerTurn();
//     } else {
//       _startEnemyTurn();
//     }
//   }
//
//   /// 開始玩家回合
//   void _startPlayerTurn() {
//     _state = _state.copyWith(currentPhase: BattlePhase.playerTurn);
//
//     // 處理玩家回合開始時的狀態效果
//     final statusResult = _state.playerStatusManager.processTurnStart();
//     _applyStatusEffects(isPlayer: true, statusResult: statusResult);
//
//     // 檢查玩家是否因狀態效果死亡
//     if (_checkPlayerDefeat()) {
//       _endBattle(BattleResult.defeat);
//       return;
//     }
//   }
//
//   /// 結束玩家回合
//   void endPlayerTurn() {
//     if (_state.currentPhase != BattlePhase.playerTurn) return;
//
//     // 處理玩家回合結束時的狀態效果
//     final statusResult = _state.playerStatusManager.processTurnEnd();
//     _applyStatusEffects(isPlayer: true, statusResult: statusResult);
//
//     // 檢查玩家是否因狀態效果死亡
//     if (_checkPlayerDefeat()) {
//       _endBattle(BattleResult.defeat);
//       return;
//     }
//
//     // 切換到敵人回合
//     _startEnemyTurn();
//   }
//
//   /// 開始敵人回合
//   void _startEnemyTurn() {
//     _state = _state.copyWith(
//       currentPhase: BattlePhase.enemyTurn,
//       currentEnemyActionIndex: 0,
//     );
//
//     // 處理敵人回合開始時的狀態效果
//     final statusResult = _state.enemyStatusManager.processTurnStart();
//     _applyStatusEffects(isPlayer: false, statusResult: statusResult);
//
//     // 檢查敵人是否因狀態效果死亡
//     if (_checkEnemyDefeat()) {
//       _endBattle(BattleResult.victory);
//       return;
//     }
//
//     // 開始執行敵人行動隊列
//     _executeNextEnemyAction();
//   }
//
//   /// 執行敵人的下一個行動
//   void _executeNextEnemyAction() {
//     if (_state.currentEnemyActionIndex >= _state.enemyActionQueue.length) {
//       // 所有行動執行完畢，結束敵人回合
//       _endEnemyTurn();
//       return;
//     }
//
//     final action = _state.enemyActionQueue[_state.currentEnemyActionIndex];
//
//     // 檢查行動是否被無效化
//     if (_state.selectedEnemyAction?.id == action.id) {
//       // 行動被無效化，跳過
//       _state = _state.copyWith(
//         currentEnemyActionIndex: _state.currentEnemyActionIndex + 1,
//         selectedEnemyAction: null,
//       );
//       _executeNextEnemyAction();
//       return;
//     }
//
//     // 執行行動
//     _performEnemyAction(action);
//
//     // 移動到下一個行動
//     _state = _state.copyWith(
//       currentEnemyActionIndex: _state.currentEnemyActionIndex + 1,
//     );
//
//     // 檢查玩家是否死亡
//     if (_checkPlayerDefeat()) {
//       _endBattle(BattleResult.defeat);
//       return;
//     }
//
//     // 繼續執行下一個行動
//     _executeNextEnemyAction();
//   }
//
//   /// 結束敵人回合
//   void _endEnemyTurn() {
//     // 處理敵人回合結束時的狀態效果
//     final statusResult = _state.enemyStatusManager.processTurnEnd();
//     _applyStatusEffects(isPlayer: false, statusResult: statusResult);
//
//     // 檢查敵人是否因狀態效果死亡
//     if (_checkEnemyDefeat()) {
//       _endBattle(BattleResult.victory);
//       return;
//     }
//
//     // 增加回合數，重新生成敵人行動隊列
//     _state = _state.copyWith(
//       turnNumber: _state.turnNumber + 1,
//       enemyActionQueue: _generateEnemyActionQueue(_state.enemy),
//     );
//
//     // 開始新的玩家回合
//     _startPlayerTurn();
//   }
//
//   /// 玩家攻擊敵人
//   void playerAttackEnemy(int damage) {
//     final newEnemy = _state.enemy.takeDamage(damage);
//     _state = _state.copyWith(
//       enemy: newEnemy,
//       totalDamageDealt: _state.totalDamageDealt + damage,
//     );
//
//     if (_checkEnemyDefeat()) {
//       _endBattle(BattleResult.victory);
//     }
//   }
//
//   /// 敵人攻擊玩家
//   void enemyAttackPlayer(int damage) {
//     // 這裡需要與現有的隊伍系統整合
//     // 暫時簡化處理
//     _state = _state.copyWith(
//       totalDamageReceived: _state.totalDamageReceived + damage,
//     );
//   }
//
//   /// 玩家嘗試逃跑
//   bool attemptEscape() {
//     if (!_state.canEscape) return false;
//
//     // 計算逃跑成功率（可以根據玩家狀態、敵人類型等調整）
//     final escapeChance = _calculateEscapeChance();
//     final success = _rollSuccess(escapeChance);
//
//     if (success) {
//       _endBattle(BattleResult.escaped);
//     }
//
//     return success;
//   }
//
//   /// 玩家選擇無效化敵人的某個行動
//   void selectEnemyActionToNullify(String actionId) {
//     final action = _state.enemyActionQueue.firstWhere(
//       (a) => a.id == actionId && a.isTargetable,
//     );
//
//     _state = _state.copyWith(selectedEnemyAction: action);
//   }
//
//   /// 結束戰鬥
//   void _endBattle(BattleResult result) {
//     _state = _state.copyWith(
//       currentPhase: BattlePhase.battleEnd,
//       result: result,
//     );
//
//     // 清除戰鬥結束時應該移除的狀態
//     _state.playerStatusManager.clearBattleEndEffects();
//     _state.enemyStatusManager.clearBattleEndEffects();
//   }
//
//   // 私有輔助方法
//   bool _checkEnemyFirstStrike(Enemy enemy) {
//     // 檢查敵人技能中是否包含先手技能
//     return enemy.skillIds.contains('first_strike') ||
//         enemy.skillIds.contains('ambush');
//   }
//
//   void _executeEnemyFirstStrike() {
//     // 執行敵人的先手技能
//     // 這裡會是特殊的先手技能邏輯
//   }
//
//   List<EnemyAction> _generateEnemyActionQueue(Enemy enemy) {
//     // 根據敵人的AI行為模式和技能生成行動隊列
//     // 這是一個簡化版本，實際會更複雜
//     return [
//       EnemyAction(
//         id: 'action_1',
//         name: '攻擊',
//         description: '對玩家造成1倍攻擊力傷害',
//         type: EnemyActionType.attack,
//         skillId: 'basic_attack',
//         isTargetable: true,
//       ),
//       EnemyAction(
//         id: 'action_2',
//         name: '防禦提升',
//         description: '提升自身防禦力',
//         type: EnemyActionType.buff,
//         skillId: 'defense_up',
//         isTargetable: true,
//       ),
//       EnemyAction(
//         id: 'action_3',
//         name: '重擊',
//         description: '對玩家造成3倍攻擊力傷害',
//         type: EnemyActionType.attack,
//         skillId: 'heavy_attack',
//         isTargetable: true,
//       ),
//     ];
//   }
//
//   void _performEnemyAction(EnemyAction action) {
//     // 根據行動類型執行對應的邏輯
//     switch (action.type) {
//       case EnemyActionType.attack:
//         _performEnemyAttack(action);
//         break;
//       case EnemyActionType.skill:
//         _performEnemySkill(action);
//         break;
//       case EnemyActionType.buff:
//         _performEnemyBuff(action);
//         break;
//       case EnemyActionType.debuff:
//         _performEnemyDebuff(action);
//         break;
//       default:
//         break;
//     }
//   }
//
//   void _performEnemyAttack(EnemyAction action) {
//     // 執行敵人攻擊邏輯
//     int damage = _calculateEnemyDamage(action);
//     enemyAttackPlayer(damage);
//   }
//
//   void _performEnemySkill(EnemyAction action) {
//     // 執行敵人技能邏輯
//   }
//
//   void _performEnemyBuff(EnemyAction action) {
//     // 執行敵人自我增益邏輯
//   }
//
//   void _performEnemyDebuff(EnemyAction action) {
//     // 執行敵人對玩家施加減益邏輯
//   }
//
//   int _calculateEnemyDamage(EnemyAction action) {
//     // 計算敵人傷害（基礎實現）
//     return _state.enemy.attack;
//   }
//
//   void _applyStatusEffects({
//     required bool isPlayer,
//     required Map<String, dynamic> statusResult,
//   }) {
//     final dotDamage = statusResult['dotDamage'] as int;
//     final hotHealing = statusResult['hotHealing'] as int;
//
//     if (isPlayer) {
//       // 應用到玩家身上
//       if (dotDamage > 0) {
//         // 玩家受到DOT傷害
//       }
//       if (hotHealing > 0) {
//         // 玩家受到HOT治療
//       }
//     } else {
//       // 應用到敵人身上
//       if (dotDamage > 0) {
//         final newEnemy = _state.enemy.takeDamage(dotDamage);
//         _state = _state.copyWith(enemy: newEnemy);
//       }
//       if (hotHealing > 0) {
//         final newEnemy = _state.enemy.heal(hotHealing);
//         _state = _state.copyWith(enemy: newEnemy);
//       }
//     }
//   }
//
//   bool _checkPlayerDefeat() {
//     // 檢查玩家是否失敗（需要與隊伍系統整合）
//     return false; // 暫時實現
//   }
//
//   bool _checkEnemyDefeat() {
//     return _state.enemy.isDead;
//   }
//
//   double _calculateEscapeChance() {
//     // 計算逃跑成功率
//     double chance = _state.baseEscapeChance;
//
//     // 根據敵人類型調整
//     switch (_state.enemy.type) {
//       case EnemyType.boss:
//         chance *= 0.3; // Boss很難逃脫
//         break;
//       case EnemyType.elite:
//         chance *= 0.6;
//         break;
//       case EnemyType.normal:
//         // 保持基礎機率
//         break;
//     }
//
//     return chance.clamp(0.0, 1.0);
//   }
//
//   bool _rollSuccess(double chance) {
//     // 簡單的機率判定
//     return (chance * 100).round() >
//         (DateTime.now().millisecondsSinceEpoch % 100);
//   }
// }
