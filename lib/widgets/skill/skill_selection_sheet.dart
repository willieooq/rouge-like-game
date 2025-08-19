import 'package:flutter/material.dart';

class SkillSelectionSheet extends StatelessWidget {
  final Function(dynamic) onSkillSelected;

  const SkillSelectionSheet({super.key, required this.onSkillSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const Center(
        child: Text('技能選擇 (待實現)', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
