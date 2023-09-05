import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense_record.dart';
import 'package:expenses_app/expense_form.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/chart/chart.dart';

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesAppState();
  }
}

class _ExpensesAppState extends State<ExpensesApp> {
  final List<ExpenseRecord> _trackedExpenses = [
    ExpenseRecord(title: 'Physics Book', amount: 250, category: Category.learn),
    ExpenseRecord(
        title: 'Fictional Book', amount: 300, category: Category.liesure),
    ExpenseRecord(
        title: 'Mobile Dev Course', amount: 1000, category: Category.work),
  ];

  _openExpenseFormModal() {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) {
        return ExpenseForm(
          onSave: (ExpenseRecord savedItem) {
            setState(() {
              _trackedExpenses.add(savedItem);
            });
          },
        );
      },
    );
  }

  _removeExpenses(ExpenseRecord removedExpense) {
    var removedExpenseIndex = _trackedExpenses.indexOf(removedExpense);
    setState(() {
      _trackedExpenses.remove(removedExpense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Removed'),
        duration: const Duration(milliseconds: 7500),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _trackedExpenses.insert(removedExpenseIndex, removedExpense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '📥',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            'No Expenses Found. Add new expenses using the plus button above.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    if (_trackedExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        trackedExpenses: _trackedExpenses,
        onDismiss: _removeExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openExpenseFormModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _trackedExpenses),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
