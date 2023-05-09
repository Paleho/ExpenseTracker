import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/Expense.dart';
import 'main.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListTile(
      leading: IconButton(
        onPressed: () {
          appState.deleteExpense(expense);
        },
        icon: Icon(Icons.delete),
      ),
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
