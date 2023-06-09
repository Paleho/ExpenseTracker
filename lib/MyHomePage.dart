import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddExpense.dart';
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
    appState.prepareData();
    return Scaffold(
      body: Column(
        children: [
          Center(child: HeatMapCard()),
          ListExpenses(),
        ],
      ),
      floatingActionButton: AddExpense(),
      // body: HeatMapExample(),
    );
  }
}
