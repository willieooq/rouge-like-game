import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character/character.dart';
import '../providers/operation_mode_provider.dart';
import '../providers/party_provider.dart';
import '../widgets/cost_dots.dart';
import '../widgets/party_formation.dart';

/// 戰鬥畫面繪製
class BattleScreen extends ConsumerStatefulWidget {
  const BattleScreen({super.key});

  @override
  ConsumerState<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen> {
  String? selectedCharacterId;

  @override
  Widget build(BuildContext context) {
    final party = ref.watch(partyProvider);
    final partyNotifier = ref.read(partyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('未來的道具相關顯示'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // 上半部：隊伍狀態顯示
          Expanded(
            // 分配畫面的比例，EX 上3下2代表上半部佔畫面60%
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // 技能按鈕區域
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: partyNotifier.canUseSkill(2)
                              ? () => partyNotifier.useSkill(2)
                              : null,
                          child: const Text('輕技能 (2)'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: partyNotifier.canUseSkill(4)
                              ? () => partyNotifier.useSkill(4)
                              : null,
                          child: const Text('重技能 (4)'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => partyNotifier.startNewTurn(),
                          child: const Text('新回合'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 下半部：角色排列（前三後二）
          Expanded(
            // 分配畫面的比例，EX 上3下2代表下半部佔畫面40%
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max, // 讓Column填滿可用空間
                  children: [
                    // 隊伍生命值
                    Row(
                      children: [
                        /** 左邊：隊伍生命值文字和數值 */
                        Row(
                          children: [
                            Text(
                              '${party.sharedHp}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _getHpColor(partyNotifier.hpPercentage),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8), // 在文字和血條之間加入間隔
                        /** 右邊：血條，並使用 Expanded 填滿剩餘空間 */
                        Expanded(
                          child: LinearProgressIndicator(
                            value: partyNotifier.hpPercentage,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getHpColor(partyNotifier.hpPercentage),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /** 回合Cost顯示 */
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${party.currentTurnCost}/${party.maxTurnCost}'),
                          const SizedBox(width: 16),
                          Flexible(
                            child: CostDots(
                              currentCost: party.currentTurnCost,
                              maxCost: party.maxTurnCost,
                              dotSize: 12.0,
                              activeDotColor: Colors.blue[600]!,
                              inactiveDotColor: Colors.grey[300]!,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    /** party資訊 */
                    Expanded(
                      flex: 1, // 確保PartyFormation填滿剩餘空間
                      child: PartyFormation(
                        characters: party.characters,
                        selectedCharacterId: selectedCharacterId,
                        onCharacterSelected: (characterId) {
                          setState(() {
                            selectedCharacterId = characterId;
                          });
                        },
                        onModeSwitchPressed: () {
                          ref.read(operationModeProvider.notifier).switchMode();
                        },
                      ),
                    ),
                    // 選中角色的信息
                    // if (selectedCharacterId != null)
                    //   _buildSelectedCharacterInfo(party.characters),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 選中角色的詳細信息
  Widget _buildSelectedCharacterInfo(List<Character> characters) {
    final selectedCharacter = characters.firstWhere(
      (char) => char.id == selectedCharacterId,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedCharacter.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text('攻擊力: ${selectedCharacter.attackPower}'),
          Row(children: [Text('${selectedCharacter.mastery}')]),
        ],
      ),
    );
  }

  // 生命值顏色
  Color _getHpColor(double percentage) {
    if (percentage <= 0.25) return Colors.red;
    if (percentage <= 0.5) return Colors.orange;
    return Colors.green;
  }
}
