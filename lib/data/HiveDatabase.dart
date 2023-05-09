import 'package:hive_flutter/hive_flutter.dart';

import 'Expense.dart';

class HiveDatabase {
  final _expensesByIdBox = Hive.box('ExpensesById');

  void writeData(Expense expense) {
    List<dynamic> expenseFromatted = [
      expense.amount.toString(),
      expense.name,
      expense.dateTime,
      expense.category,
      expense.details,
    ];

    _expensesByIdBox.put(expense.dateTime.toString(), expenseFromatted);
  }

  List<Expense> readData() {
    List savedExpenses = _expensesByIdBox.values.toList();

    List<Expense> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      double amount = double.parse(savedExpenses[i][0]);
      String name = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      String category = savedExpenses[i][3];
      String details = savedExpenses[i][4];

      Expense expense = Expense(
        amount: amount,
        name: name,
        dateTime: dateTime,
        category: category,
        details: details,
      );

      allExpenses.insert(0, expense);
    }

    return allExpenses;
  }
}
