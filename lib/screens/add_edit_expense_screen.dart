import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';

class AddEditExpenseScreen extends StatefulWidget {
  final Expense? expense;
  const AddEditExpenseScreen({super.key, this.expense});

  @override
  State<AddEditExpenseScreen> createState() => _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _amountCtrl;
  late String _category;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    final e = widget.expense;
    _titleCtrl = TextEditingController(text: e?.title ?? '');
    _amountCtrl =
        TextEditingController(text: e != null ? e.amount.toString() : '');
    _category = e?.category ?? kCategories.first;
    _date = e?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<ExpenseProvider>();
    final expense = Expense(
      id: widget.expense?.id,
      title: _titleCtrl.text.trim(),
      amount: double.parse(_amountCtrl.text.trim()),
      category: _category,
      date: _date,
    );
    if (widget.expense == null) {
      provider.addExpense(expense);
    } else {
      provider.updateExpense(expense);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.expense != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Expense' : 'Add Expense',
            style: TextStyle(fontSize: 17.sp)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleCtrl,
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 14.sp),
                  border: const OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Title is required' : null,
              ),
              SizedBox(height: 2.h),
              TextFormField(
                controller: _amountCtrl,
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  labelText: 'Amount (₹)',
                  labelStyle: TextStyle(fontSize: 14.sp),
                  border: const OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Amount is required';
                  if (double.tryParse(v.trim()) == null) {
                    return 'Enter a valid amount';
                  }
                  if (double.parse(v.trim()) <= 0) {
                    return 'Amount must be greater than 0';
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(fontSize: 14.sp),
                  border: const OutlineInputBorder(),
                ),
                items: kCategories
                    .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(c, style: TextStyle(fontSize: 14.sp)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              SizedBox(height: 2.h),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: TextStyle(fontSize: 14.sp),
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat('dd MMM yyyy').format(_date),
                      style: TextStyle(fontSize: 14.sp)),
                ),
              ),
              SizedBox(height: 3.h),
              FilledButton(
                onPressed: _save,
                child: Text(isEdit ? 'Update' : 'Add Expense',
                    style: TextStyle(fontSize: 15.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
