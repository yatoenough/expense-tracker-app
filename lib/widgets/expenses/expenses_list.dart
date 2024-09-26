import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onExpenseRemove});

  final List<Expense> expenses;
  final void Function(Expense expense) onExpenseRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onExpenseRemove(expenses[index]),
        background: Container(
          color: Colors.red[800],
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
