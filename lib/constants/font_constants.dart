import 'normal_constants.dart';

///基於角色卡片大小的字體比例
class PortraitFontSizes {
  // 字體大小比例（相對於 portraitHeight）
  static const double skillNameFontRatio = 0.18; // 8.0 (80 * 0.10)
  static const double skillDescriptionFontRatio = 0.20; // 7.0 (80 * 0.0875)
  static const double skillCostFontRatio = 0.15; // 10.0 (80 * 0.125)
  static const double characterNameFontRatio = 0.175; // 14.0 (80 * 0.175)
  static const double attackPowerFontRatio = 0.35; // 12.0 (80 * 0.15)

  // 其他UI元素比例
  static const double masteryDotRatio = 0.15; // 12.0 (80 * 0.15)
  static const double skillButtonPaddingRatio = 0.05; // 4.0 (80 * 0.05)

  /// ==========實際引用==========
  static double get skillNameFontSize => portraitHeight * skillNameFontRatio;

  static double get skillDescriptionFontSize =>
      portraitHeight * skillDescriptionFontRatio;

  static double get skillCostFontSize => portraitHeight * skillCostFontRatio;

  static double get characterNameFontSize =>
      portraitHeight * characterNameFontRatio;

  static double get attackPowerFontSize =>
      portraitHeight * attackPowerFontRatio;

  /// 根據頭像大小計算角色名稱字體大小
  static double getCharacterNameFontSize(double avatarHeight) {
    return avatarHeight * PortraitFontSizes.characterNameFontRatio;
  }

  static double get masteryDotSize => portraitHeight * masteryDotRatio;

  static double get skillButtonPadding =>
      portraitHeight * skillButtonPaddingRatio;
}
