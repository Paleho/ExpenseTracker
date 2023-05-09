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

    _expensesByIdBox.put(_dateTimeToString(expense.dateTime), expenseFromatted);
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

  void deleteData(Expense expense) {
    _expensesByIdBox.delete(_dateTimeToString(expense.dateTime));
  }

  // Use this method instead of dateTime.toString() to avoid precision errors and mismatches
  // Behavior:
  //            dateTime.toString() = '2023-05-10 02:05:58.985728'
  //    _dateTimeToString(dateTime) = '2023-05-10 02:05:58.98'
  String _dateTimeToString(DateTime input) {
    String year = input.year.toString();
    String month = (input.month < 10) ? '0${input.month}' : '${input.month}';
    String day = (input.day < 10) ? '0${input.day}' : '${input.day}';
    String hour = (input.hour < 10) ? '0${input.hour}' : '${input.hour}';
    String minute =
        (input.minute < 10) ? '0${input.minute}' : '${input.minute}';
    String second =
        (input.second < 10) ? '0${input.second}' : '${input.second}';
    String millisecond = '${input.millisecond}'.substring(0, 2);

    return '$year-$month-$day $hour:$minute:$second.$millisecond';
  }
}
