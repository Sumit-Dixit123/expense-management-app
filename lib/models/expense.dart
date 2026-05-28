const List<String> kCategories = [
  'Food',
  'Transport',
  'Shopping',
  'Health',
  'Entertainment',
  'Bills',
  'Other',
];

class Expense {
  final int? id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'amount': amount,
        'category': category,
        'date': date.toIso8601String(),
      };

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
        id: map['id'],
        title: map['title'],
        amount: map['amount'],
        category: map['category'],
        date: DateTime.parse(map['date']),
      );

  Expense copyWith({
    int? id,
    String? title,
    double? amount,
    String? category,
    DateTime? date,
  }) =>
      Expense(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        date: date ?? this.date,
      );
}
