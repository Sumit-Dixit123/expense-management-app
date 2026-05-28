import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/expense_list_item.dart';
import 'add_edit_expense_screen.dart';
import 'analytics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().loadExpenses();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openAddEdit(BuildContext context, [Expense? expense]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditExpenseScreen(expense: expense),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Expense', style: TextStyle(fontSize: 16.sp)),
        content: Text('Are you sure you want to delete this expense?',
            style: TextStyle(fontSize: 13.sp)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontSize: 13.sp)),
          ),
          FilledButton(
            onPressed: () {
              context.read<ExpenseProvider>().deleteExpense(id);
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(fontSize: 13.sp)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final expenses = provider.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager', style: TextStyle(fontSize: 17.sp)),
        actions: [
          IconButton(
            icon: Icon(provider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: provider.toggleDarkMode,
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 1.5.h, 4.w, 1.h),
            child: TextField(
              controller: _searchCtrl,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search expenses...',
                hintStyle: TextStyle(fontSize: 14.sp),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w)),
                contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                suffixIcon: provider.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          provider.setSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: provider.setSearchQuery,
            ),
          ),
          CategoryFilterBar(
            selected: provider.selectedCategory,
            onSelected: provider.setCategory,
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: expenses.isEmpty
                ? Center(
                    child: Text('No expenses found',
                        style: TextStyle(fontSize: 15.sp)))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (_, i) => ExpenseListItem(
                      expense: expenses[i],
                      onEdit: () => _openAddEdit(context, expenses[i]),
                      onDelete: () =>
                          _confirmDelete(context, expenses[i].id!),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddEdit(context),
        icon: const Icon(Icons.add),
        label: Text('Add Expense', style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }
}
