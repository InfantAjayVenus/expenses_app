import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { work, learn, liesure, savings }

const categoryIcons = {
  Category.learn: Icons.book_outlined,
  Category.liesure: Icons.sports_esports_outlined,
  Category.savings: Icons.wallet_outlined,
  Category.work: Icons.work_outline
};

class ExpenseRecord {
  ExpenseRecord(
      {required this.title,
      required this.amount,
      required this.category,
      DateTime? date})
      : id = uuid.v4(),
        date = date ?? DateTime.now();

  final String id;
  final String title;
  final double amount;
  final DateTime? date;
  final Category category;

  String get formattedDate {
    return dateFormatter.format(date!);
  }
}

class ExpenseCollection {
  ExpenseCollection(this.category, this.expensesList);
  ExpenseCollection.forCategory(this.category, List<ExpenseRecord> allExpense)
      : expensesList = allExpense
            .where(
              (expenseItem) => expenseItem.category == category,
            )
            .toList();

  final Category category;
  final List<ExpenseRecord> expensesList;

  get totalExpenses {
    double totalExpense = 0;

    for (final expenseItem in expensesList) {
      totalExpense += expenseItem.amount;
    }

    return totalExpense;
  }
}
