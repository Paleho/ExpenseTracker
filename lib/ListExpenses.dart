import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ExpenseTile.dart';
import 'main.dart';

class ListExpenses extends StatelessWidget {
  const ListExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      width: 400,
      height: 400,
      child: ListView(
        children: [
          for (var expense in appState.expenses)
            ExpenseTile(
              expense: expense,
            ),
        ],
      ),
    );
  }
}
