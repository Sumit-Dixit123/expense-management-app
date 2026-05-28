import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../models/expense.dart';

class CategoryFilterBar extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...kCategories];
    return SizedBox(
      height: 5.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 2.w),
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = cat == selected;
          return ChoiceChip(
            label: Text(cat, style: TextStyle(fontSize: 12.sp)),
            selected: isSelected,
            onSelected: (_) => onSelected(cat),
          );
        },
      ),
    );
  }
}
