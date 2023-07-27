import 'package:expenses_app/models/expense_record.dart';
import 'package:expenses_app/widgets/expenses_list/expense_list_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.trackedExpenses,
    required this.onDismiss,
  });

  final List<ExpenseRecord> trackedExpenses;
  final void Function(ExpenseRecord) onDismiss;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trackedExpenses.length,
      itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) {
            onDismiss(trackedExpenses[index]);
          },
          key: ValueKey(trackedExpenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.delete_forever_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                Icon(
                  Icons.delete_forever_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ),
          child: ExpenseListItem(trackedExpenses[index])),
    );
  }
}
