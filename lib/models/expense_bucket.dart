import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpensesAmount {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
