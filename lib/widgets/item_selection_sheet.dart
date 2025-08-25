
// lib/widgets/item_selection_sheet.dart
import 'package:flutter/material.dart';

class ItemSelectionSheet extends StatelessWidget {
  final Function(dynamic) onItemSelected;

  const ItemSelectionSheet({super.key, required this.onItemSelected});

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
        child: Text(
          '道具選擇 (待實現)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}