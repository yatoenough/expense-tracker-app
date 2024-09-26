import 'package:expense_tracker/screens/expenses_screen.dart';
import 'package:expense_tracker/themes/dark_theme.dart';
import 'package:expense_tracker/themes/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expense Tracker',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const ExpensesScreen(),
    );
  }
}
