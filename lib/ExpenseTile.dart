import 'package:flutter/material.dart';

import 'data/Expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(expense.amount.toString()),
      title: Text(expense.name),
    );
  }
}
