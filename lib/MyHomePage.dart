import 'package:expense_tracker/data/Expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HeatMapCard.dart';
import 'ListExpenses.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Center(child: HeatMapCard()),
          ListExpenses(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appState.addExpense(
              Expense(amount: 5.2, name: 'TestName', dateTime: DateTime.now()));
        },
        shape: const RoundedRectangleBorder(
          // borderRadius: BorderRadius.all(Radius.circular(10))),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(10),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 199, 164, 136),
        child: const Icon(Icons.add_rounded),
      ),
      // body: HeatMapExample(),
    );
  }
}
