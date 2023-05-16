import 'package:hive_flutter/hive_flutter.dart';

import 'Expense.dart';

class HiveDatabase {
  final _expensesByIdBox = Hive.box('ExpensesById');
  final _expensesByDayBox = Hive.box('ExpensesByDay');

  void writeData(Expense expense) {
    List<dynamic> expenseFromatted = [
      expense.amount.toString(),
      expense.name,
      expense.dateTime,
      expense.category,
      expense.details,
    ];

    // data recorded as <dateTime: [amount, name, dateTime, category, details]>
    _expensesByIdBox.put(_dateTimeToString(expense.dateTime), expenseFromatted);

    String dayBoxKey = _dateTimeToString(expense.dateTime, onlyDay: true);
    if (!_expensesByDayBox.keys.contains(dayBoxKey)) {
      _expensesByDayBox.put(dayBoxKey, expense.amount.toString());
    } else {
      double currentAmmount = double.parse(_expensesByDayBox.get(dayBoxKey));
      double newAmount = currentAmmount + expense.amount;
      _expensesByDayBox.put(dayBoxKey, newAmount.toString());
    }
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

  Map<DateTime, double> getDataPerDay() {
    Map<DateTime, double> dataPerDay = {};
    List daysRecorded = _expensesByDayBox.keys.toList();

    for (String day in daysRecorded) {
      double dayTotal = double.parse(_expensesByDayBox.get(day));
      dataPerDay.addAll({_stringToDate(day): dayTotal});
    }

    return dataPerDay;
  }

  void deleteData(Expense expense) {
    _expensesByIdBox.delete(_dateTimeToString(expense.dateTime));

    String dayBoxKey = _dateTimeToString(expense.dateTime, onlyDay: true);
    double loggedAmount = double.parse(_expensesByDayBox.get(dayBoxKey));
    double newAmount = loggedAmount - expense.amount;
    _expensesByDayBox.put(_dateTimeToString(expense.dateTime, onlyDay: true),
        newAmount.toString());
  }

  // Use this method instead of dateTime.toString() to avoid precision errors and mismatches
  // Behavior:
  //            dateTime.toString() = '2023-05-10 02:05:58.985728'
  //    _dateTimeToString(dateTime) = '2023-05-10 02:05:58.98'
  String _dateTimeToString(DateTime input, {bool onlyDay = false}) {
    String year = input.year.toString();
    String month = (input.month < 10) ? '0${input.month}' : '${input.month}';
    String day = (input.day < 10) ? '0${input.day}' : '${input.day}';
    String hour = (input.hour < 10) ? '0${input.hour}' : '${input.hour}';
    String minute =
        (input.minute < 10) ? '0${input.minute}' : '${input.minute}';
    String second =
        (input.second < 10) ? '0${input.second}' : '${input.second}';
    String millisecond = '${input.millisecond}'.substring(0, 2);

    if (onlyDay) return '$year-$month-$day';
    return '$year-$month-$day $hour:$minute:$second.$millisecond';
  }

  DateTime _stringToDate(String input) {
    List splitted = input.split('-');
    int year = int.parse(splitted[0]);
    int month = int.parse(splitted[1]);
    int day = int.parse(splitted[2]);

    return DateTime(year, month, day);
  }
}
