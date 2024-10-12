import 'package:expense_tracker/extensions/capitalize.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm(
      {super.key,
      required this.onExpenseAdd,
      required this.onExpenseEdit,
      this.expense});

  final void Function(Expense expense) onExpenseAdd;
  final void Function(Expense original, Expense edited) onExpenseEdit;
  final Expense? expense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  bool expenseToEditProvided = false;

  @override
  void initState() {
    if (widget.expense != null) {
      expenseToEditProvided = true;
      _titleController.text = widget.expense!.title;
      _amountController.text = widget.expense!.amount.toString();
      _selectedDate = widget.expense!.date;
      _selectedCategory = widget.expense!.category;
    }
    super.initState();
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please ensure valid title, amount, date and category was provided."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
      return;
    }

    expenseToEditProvided
        ? widget.onExpenseEdit(
            widget.expense!,
            Expense(
              title: _titleController.text,
              amount: enteredAmount,
              date: _selectedDate!,
              category: _selectedCategory,
            ),
          )
        : widget.onExpenseAdd(
            Expense(
              title: _titleController.text,
              amount: enteredAmount,
              date: _selectedDate!,
              category: _selectedCategory,
            ),
          );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          Text(
            expenseToEditProvided ? "Edit expense" : "Add new expense",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: "\$ ",
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate != null
                          ? DateFormat.yMd().format(_selectedDate!)
                          : "No selected date",
                    ),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.capitalize()),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() {
                  if (value != null) _selectedCategory = value;
                }),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text(expenseToEditProvided ? "Save" : "Add Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
