import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyHomePage.dart';
import 'data/Expense.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
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

  void addExpense(Expense item) {
    expenses.insert(0, item);
    notifyListeners();
  }
}
