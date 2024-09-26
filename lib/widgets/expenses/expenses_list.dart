import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onExpenseRemove,
    required this.onExpenseEdit,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onExpenseRemove;
  final void Function(Expense expense) onExpenseEdit;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList>
    with TickerProviderStateMixin {
  final dismissalDuration = const Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.expenses.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(widget.expenses[index]),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            dismissible: DismissiblePane(
              dismissalDuration: dismissalDuration,
              onDismissed: () => widget.onExpenseRemove(widget.expenses[index]),
            ),
            children: [
              SlidableAction(
                icon: Icons.edit_rounded,
                label: "Edit",
                onPressed: (context) =>
                    widget.onExpenseEdit(widget.expenses[index]),
                backgroundColor: Colors.orange,
              ),
              SlidableAction(
                icon: Icons.delete_rounded,
                label: "Delete",
                autoClose: false,
                onPressed: (context) async {
                  Slidable.of(context)?.dismiss(
                    ResizeRequest(dismissalDuration, () {
                      widget.onExpenseRemove(widget.expenses[index]);
                    }),
                  );
                },
                backgroundColor: Colors.red[800]!,
              ),
            ],
          ),
          child: ExpenseItem(
            expense: widget.expenses[index],
          ),
        );
      },
    );
  }
}
