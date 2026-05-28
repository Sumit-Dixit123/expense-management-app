import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isDarkMode = false;

  List<Expense> get expenses {
    return _expenses.where((e) {
      final matchCategory =
          _selectedCategory == 'All' || e.category == _selectedCategory;
      final matchSearch =
          e.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isDarkMode => _isDarkMode;

  Map<String, double> get categoryTotals {
    final Map<String, double> totals = {};
    for (final e in _expenses) {
      totals[e.category] = (totals[e.category] ?? 0) + e.amount;
    }
    return totals;
  }

  double get grandTotal =>
      _expenses.fold(0, (sum, e) => sum + e.amount);

  Future<void> loadExpenses() async {
    _expenses = await DatabaseHelper.instance.getAll();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    final id = await DatabaseHelper.instance.insert(expense);
    _expenses.insert(0, expense.copyWith(id: id));
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    await DatabaseHelper.instance.update(expense);
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) _expenses[index] = expense;
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    await DatabaseHelper.instance.delete(id);
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
