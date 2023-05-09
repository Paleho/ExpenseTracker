import 'package:hive_flutter/hive_flutter.dart';

import 'Expense.dart';

class HiveDatabase {
  final _expenseBox = Hive.box('expense_database');

  void writeData(List<Expense> expenses) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in expenses) {
      List<dynamic> expenseFromatted = [
        expense.amount.toString(),
        expense.name,
        expense.dateTime,
        expense.category,
        expense.details,
      ];

      allExpensesFormatted.add(expenseFromatted);
    }

    _expenseBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  List<Expense> readData() {
    List savedExpenses = _expenseBox.get("ALL_EXPENSES") ?? [];

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

      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
