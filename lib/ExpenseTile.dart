import 'package:flutter/material.dart';

import 'data/Expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.name),
      subtitle: Text(
          '${expense.dateTime.day} - ${expense.dateTime.month} - ${expense.dateTime.year}'),
      trailing: Text(
        '€ ${expense.amount}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
