import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses/expense_form.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _expenses = [];

  void _showExpenseForm({Expense? expense}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ExpenseForm(
        onExpenseAdd: _addExpense,
        onExpenseEdit: _editExpense,
        expense: expense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() => _expenses.add(expense));
  }

  void _editExpense(Expense originalExpense, Expense editedExpense) {
    final index = _expenses.indexOf(originalExpense);
    setState(() => _expenses[index] = editedExpense);
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);

    setState(() => _expenses.remove(expense));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Expense removed"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () => _expenses.insert(expenseIndex, expense),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _showExpenseForm(),
              icon: const Icon(Icons.add_rounded))
        ],
        title: const Text("Flutter Expense Tracker"),
      ),
      body: Column(
        children: [
          Chart(expenses: _expenses),
          Expanded(
            child: _expenses.isNotEmpty
                ? ExpensesList(
                    expenses: _expenses,
                    onExpenseRemove: _removeExpense,
                    onExpenseEdit: _showExpenseForm,
                  )
                : const Center(
                    child: Text("No expenses"),
                  ),
          ),
        ],
      ),
    );
  }
}
