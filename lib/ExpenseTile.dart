import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'data/Expense.dart';
import 'main.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              appState.deleteExpense(expense);
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
            autoClose: true,
          ),
        ],
      ),
      child: ListTile(
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
      ),
    );
  }
}
