import 'dart:math';

import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _expenses = [
    Expense(
      title: "Meal",
      amount: 9.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Cinema",
      amount: 18.49,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Plane ticket",
      amount: 129.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _showAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewExpense(
        onExpenseAdd: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() => _expenses.add(expense));
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
              onPressed: _showAddExpenseOverlay,
              icon: const Icon(Icons.add_rounded))
        ],
        title: const Text("Flutter Expense Tracker"),
      ),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(
            child: _expenses.isNotEmpty
                ? ExpensesList(
                    expenses: _expenses,
                    onExpenseRemove: _removeExpense,
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
