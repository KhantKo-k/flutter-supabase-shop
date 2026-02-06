import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> categoryColors = {
      'phone': Colors.red,
      'laptop': Colors.purple,
      'watch': Colors.orange,
      'Earphone': Colors.green,
    };

    return Chip(
      padding: EdgeInsets.all(0),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide.none,
      backgroundColor:
          categoryColors[category.toLowerCase()] ?? Colors.blueGrey,
      label: Text(category, style: TextStyle(color: Colors.white)),
    );
  }
}
