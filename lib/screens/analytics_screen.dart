import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/expense_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  static const _categoryColors = [
    Colors.blue, Colors.orange, Colors.green, Colors.red,
    Colors.purple, Colors.teal, Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final totals = provider.categoryTotals;
    final grand = provider.grandTotal;

    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics', style: TextStyle(fontSize: 17.sp)),
      ),
      body: totals.isEmpty
          ? Center(
              child: Text('No expenses yet', style: TextStyle(fontSize: 15.sp)))
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Spending',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '₹${grand.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemCount: totals.length,
                    itemBuilder: (_, i) {
                      final entry = totals.entries.elementAt(i);
                      final percent = grand > 0 ? entry.value / grand : 0.0;
                      final color = _categoryColors[i % _categoryColors.length];
                      return Card(
                        margin: EdgeInsets.only(bottom: 1.h),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(entry.key,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600)),
                                  Text(
                                    '₹${entry.value.toStringAsFixed(2)} (${(percent * 100).toStringAsFixed(1)}%)',
                                    style: TextStyle(
                                        color: color, fontSize: 13.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(1.w),
                                child: LinearProgressIndicator(
                                  value: percent,
                                  minHeight: 1.h,
                                  backgroundColor:
                                      color.withValues(alpha: 0.2),
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(color),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
