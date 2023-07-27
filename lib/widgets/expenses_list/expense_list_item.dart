import 'package:expenses_app/models/expense_record.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem(this.expenseItem, {super.key});

  final ExpenseRecord expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                expenseItem.title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ ${expenseItem.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(expenseItem.formattedDate),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(categoryIcons[expenseItem.category]),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
