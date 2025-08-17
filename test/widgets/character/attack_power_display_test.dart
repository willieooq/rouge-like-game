import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rouge_project/constants/font_constants.dart';
import 'package:rouge_project/widgets/character/attack_power_display.dart';

void main() {
  group('AttackPowerDisplay', () {
    testWidgets('renders correctly with default values', (
      WidgetTester tester,
    ) async {
      const attackPower = 100;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AttackPowerDisplay(attackPower: attackPower)),
        ),
      );

      // 驗證文字是否正確顯示
      final textFinder = find.text('$attackPower');
      expect(textFinder, findsOneWidget);

      // 驗證預設文字顏色和字體大小
      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.color, Colors.white);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.fontSize, PortraitFontSizes.attackPowerFontSize);
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('renders correctly with custom text color and font size', (
      WidgetTester tester,
    ) async {
      const attackPower = 150;
      const customColor = Colors.red;
      const customFontSize = 24.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AttackPowerDisplay(
              attackPower: attackPower,
              textColor: customColor,
              fontSize: customFontSize,
            ),
          ),
        ),
      );

      // 驗證文字是否正確顯示
      final textFinder = find.text('$attackPower');
      expect(textFinder, findsOneWidget);

      // 驗證自訂的文字顏色和字體大小
      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.color, customColor);
      expect(textWidget.style?.fontWeight, FontWeight.bold); // 預設應為 bold
      expect(textWidget.style?.fontSize, customFontSize);
      expect(textWidget.textAlign, TextAlign.center); // 預設應為 center
    });

    test('getAttackPowerFontSize calculates font size correctly', () {
      const avatarHeight1 = 100.0;
      final expectedFontSize1 =
          avatarHeight1 * PortraitFontSizes.attackPowerFontRatio;
      expect(
        AttackPowerDisplay.getAttackPowerFontSize(avatarHeight1),
        expectedFontSize1,
      );

      const avatarHeight2 = 50.0;
      final expectedFontSize2 =
          avatarHeight2 * PortraitFontSizes.attackPowerFontRatio;
      expect(
        AttackPowerDisplay.getAttackPowerFontSize(avatarHeight2),
        expectedFontSize2,
      );

      const avatarHeight3 = 0.0;
      final expectedFontSize3 =
          avatarHeight3 * PortraitFontSizes.attackPowerFontRatio;
      expect(
        AttackPowerDisplay.getAttackPowerFontSize(avatarHeight3),
        expectedFontSize3,
      );
    });
  });
}
