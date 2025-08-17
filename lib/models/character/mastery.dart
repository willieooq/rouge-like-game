import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

/// 角色專精屬性ENUM
enum Mastery {
  @JsonValue('fire')
  fire('fire'),

  @JsonValue('ice')
  ice('ice'),

  @JsonValue('thunder')
  thunder('thunder'),

  @JsonValue('none')
  none('none'),

  @JsonValue('light')
  light('light'),

  @JsonValue('dark')
  dark('dark'),

  @JsonValue('earth')
  earth('earth'),

  @JsonValue('wind')
  wind('wind');

  const Mastery(this.key);
  final String key;

  // 取得顯示名稱（支援i18n）
  String getName(Function(String) t) {
    return t('element.$key');
  }

  // 取得屬性顏色
  // 可以用於UI顯示時的視覺效果
  int get colorValue {
    switch (this) {
      case Mastery.fire:
        return 0xFFFF4444; // 紅色
      case Mastery.ice:
        return 0xFF4488FF; // 藍色
      case Mastery.thunder:
        return 0xFFFFDD44; // 黃色
      case Mastery.light:
        return 0xFFFFFFAA; // 淺黃色
      case Mastery.dark:
        return 0xFF444444; // 深灰色
      case Mastery.earth:
        return 0xFF8B4513; // 棕色
      case Mastery.wind:
        return 0xFF90EE90; // 淺綠色
      case Mastery.none:
        return 0xFF888888; // 灰色
    }
  }
}
