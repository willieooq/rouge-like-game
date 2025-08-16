import 'package:freezed_annotation/freezed_annotation.dart';

// 這些import是Freezed自動生成檔案的引用
// 類似Java的 import static 或 Lombok生成的方法
part 'character.freezed.dart'; // Freezed會自動生成這個檔案
part 'character.g.dart'; // JSON序列化會生成這個檔案（未來用）

// @freezed註解 = Java的 @Data + @Builder + @Value + @ToString + @EqualsAndHashCode
@freezed
abstract class Character with _$Character {
  // const factory構造函數 = Java Builder pattern的簡化版
  // Freezed會自動生成copyWith, toString, ==, hashCode等方法
  const factory Character({
    required String id, // required = @NonNull
    required String name,
    required int maxCost,
    required int currentCost,
    required int attackPower,
    required List<String> skillIds,
  }) = _Character; // = _Character是Freezed的命名慣例

  // 你仍然可以添加自定義方法
  // 類似Java中在@Data class裡添加business methods
  const Character._(); // 私有構造函數，允許添加自定義方法

  // 便利方法：檢查是否可以使用技能
  bool canUseSkill(int skillCost) => currentCost >= skillCost;

  // 便利方法：使用技能後的狀態
  // 注意：copyWith方法是Freezed自動生成的！
  Character afterUsingSkill(int skillCost) {
    if (!canUseSkill(skillCost)) {
      throw Exception('Not enough cost to use skill');
    }
    return copyWith(currentCost: currentCost - skillCost);
  }

  // 便利方法：回復Cost
  Character restoreCost(int amount) {
    final newCost = (currentCost + amount).clamp(0, maxCost);
    return copyWith(currentCost: newCost);
  }

  // Getter methods
  bool get isExhausted => currentCost <= 0;
  bool get isFullCost => currentCost >= maxCost;
  double get costPercentage => currentCost / maxCost;

  // JSON序列化支持（未來可能需要，用於存檔）
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
