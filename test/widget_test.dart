import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/main.dart';
import 'package:expense_manager/providers/expense_provider.dart';

void main() {
  testWidgets('App loads HomeScreen with Expense Manager title', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ExpenseProvider(),
        child: const ExpenseManagerApp(),
      ),
    );
    await tester.pump();
    expect(find.text('Expense Manager'), findsOneWidget);
  });
}
