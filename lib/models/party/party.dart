import 'package:freezed_annotation/freezed_annotation.dart';

import '../character/character.dart';

part 'party.freezed.dart';

/// 關卡內的隊伍Bean，此為戰鬥中的主體
/// 一個隊伍為5個character組成 @see [Character]
@freezed
abstract class Party with _$Party {
  const factory Party({
    required List<Character> characters, // 5個角色
    required int sharedHp, // 共享生命值
    required int maxHp, // 最大生命值
    required int currentTurnCost, // 當前回合Cost
    required int maxTurnCost, // 每回合最大Cost
  }) = _Party;
}
