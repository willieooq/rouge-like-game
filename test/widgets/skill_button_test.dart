import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rouge_project/models/skill/skill_data.dart';
import 'package:rouge_project/widgets/skill/skill_button.dart';

void main() {
  // Test group for SkillButton widget
  group('SkillButton', () {
    // Test case for default constructor
    testWidgets('renders correctly with default constructor', (
      WidgetTester tester,
    ) async {
      // Create a mock SkillData object
      const skillData = SkillData(
        id: 'fireball',
        name: '火球術',
        cost: 3,
        damage: 150,
        description: '火屬性魔法攻擊',
        element: 'fire',
        type: 'attack',
      );

      // Build the SkillButton widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SkillButton(skillData: skillData)),
        ),
      );

      // Verify that the SkillButton displays the skill name
      expect(find.text('火球術'), findsOneWidget);
      // Verify that the SkillButton displays the skill cost
      expect(find.text('3'), findsOneWidget);
    });

    // Test case for empty constructor
    testWidgets('renders correctly with empty constructor', (
      WidgetTester tester,
    ) async {
      // Build the SkillButton widget using the empty constructor
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SkillButton.empty())),
      );

      // Verify that the SkillButton displays "無技能" (No skill)
      expect(find.text('無技能'), findsOneWidget);
    });

    // Test case for onTap callback
    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      // Create a mock SkillData object
      const skillData = SkillData(
        id: '1',
        name: 'Fireball',
        cost: 10,
        damage: 20,
        description: 'Launches a fireball',
        element: 'Fire',
        type: 'Attack',
      );
      // Create a mock onTap callback
      var tapped = false;
      // Build the SkillButton widget with the onTap callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkillButton(
              skillData: skillData,
              isInteractive: true,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Tap the SkillButton
      await tester.tap(find.byType(SkillButton));
      // Verify that the onTap callback was called
      expect(tapped, isTrue);
    });

    // Test case for canUse = false
    testWidgets('does not call onTap when canUse is false', (
      WidgetTester tester,
    ) async {
      // Create a mock SkillData object
      const skillData = SkillData(
        id: '1',
        name: 'Fireball',
        cost: 10,
        damage: 20,
        description: 'Launches a fireball',
        element: 'Fire',
        type: 'Attack',
      );
      // Create a mock onTap callback
      var tapped = false;
      // Build the SkillButton widget with canUse = false
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkillButton(
              skillData: skillData,
              canUse: false,
              isInteractive: true,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Tap the SkillButton
      await tester.tap(find.byType(SkillButton));
      // Verify that the onTap callback was not called
      expect(tapped, isFalse);
    });
  });
}
