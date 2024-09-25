import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded))
        ],
        title: const Text("Flutter Expense Tracker"),
      ),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(
              child: ExpensesList(
            expenses: _expenses,
          )),
        ],
      ),
    );
  }
}
