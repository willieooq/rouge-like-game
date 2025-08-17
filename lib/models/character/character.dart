import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastery.dart';

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
    /// 角色ID Unique identifier for the character
    required String id, // required = @NonNull
    /// 角色名稱 可供玩家任意命名
    required String name,
    required Mastery mastery,
    required int attackPower,
    required List<String> skillIds,
  }) = _Character; // = _Character是Freezed的命名慣例

  // JSON序列化支持（未來可能需要，用於存檔）
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
