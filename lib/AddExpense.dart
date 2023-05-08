import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/Expense.dart';
import 'main.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final createExpenseAmountController = TextEditingController();

  final createExpenseNameController = TextEditingController();

  void createExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: createExpenseAmountController,
            ),
            TextField(
              controller: createExpenseNameController,
            ),
          ],
        ),
        actions: [
          // Save
          ElevatedButton(
            onPressed: save,
            child: const Text('Save'),
          ),

          // Cancel
          ElevatedButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    Expense newExpense = Expense(
      amount: double.parse(createExpenseAmountController.text),
      name: createExpenseNameController.text,
      dateTime: DateTime.now(),
    );
    var appState = Provider.of<MyAppState>(context, listen: false);

    appState.addExpense(newExpense);
    clear();
    Navigator.pop(context);
  }

  void cancel() {
    clear();
    Navigator.pop(context);
  }

  void clear() {
    createExpenseAmountController.clear();
    createExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: createExpense,
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
    );
  }
}
