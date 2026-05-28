import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../models/expense.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpenseListItem({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onDelete,
  });

  static const _categoryIcons = {
    'Food': Icons.restaurant,
    'Transport': Icons.directions_car,
    'Shopping': Icons.shopping_bag,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.movie,
    'Bills': Icons.receipt_long,
    'Other': Icons.category,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
        leading: CircleAvatar(
          radius: 5.w,
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            _categoryIcons[expense.category] ?? Icons.category,
            color: colorScheme.primary,
            size: 5.w,
          ),
        ),
        title: Text(
          expense.title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        subtitle: Text(
          '${expense.category} • ${DateFormat('dd MMM yyyy').format(expense.date)}',
          style: TextStyle(fontSize: 12.sp),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '₹${expense.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 14.sp,
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (val) {
                if (val == 'edit') onEdit();
                if (val == 'delete') onDelete();
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit', style: TextStyle(fontSize: 14.sp))),
                PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete', style: TextStyle(fontSize: 14.sp))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
