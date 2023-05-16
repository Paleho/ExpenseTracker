import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'MyHomePage.dart';
import 'data/Expense.dart';
import 'data/HiveDatabase.dart';

void main() async {
  await Hive.initFlutter();

  var box1 = await Hive.openBox('ExpensesById');
  var box2 = await Hive.openBox('ExpensesByDay');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Expense> expenses = [];
  Map<DateTime, double> dataPerDay = {};

  final db = HiveDatabase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      expenses = db.readData();
      dataPerDay = db.getDataPerDay();
    }
  }

  void addExpense(Expense item) {
    expenses.insert(0, item);
    db.writeData(item);
    notifyListeners();
  }

  void deleteExpense(Expense item) {
    expenses.remove(item);
    db.deleteData(item);
    notifyListeners();
  }
}
