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
      builder: (context) {
        bool moreVisible = false;
        IconData moreIcon = Icons.arrow_right;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('New'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Amount
                TextField(
                  decoration: const InputDecoration(
                    hintText: '13.2',
                    icon: SizedBox(
                      width: 30,
                      child: Icon(Icons.euro_symbol_rounded),
                    ),
                  ),
                  controller: createExpenseAmountController,
                ),
                // Tag
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Lunch',
                    icon: Text(
                      'Tag:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  controller: createExpenseNameController,
                ),
                const SizedBox(height: 5),
                // More button
                SizedBox(
                  height: 22,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        moreIcon = moreVisible
                            ? Icons.arrow_right
                            : Icons.arrow_drop_down;
                        moreVisible = !moreVisible;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(200, 130, 130, 130),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('More'),
                        SizedBox(
                          width: 12,
                          child: Icon(moreIcon),
                        )
                      ],
                    ),
                  ),
                ),
                if (moreVisible) Text('more details here'),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              // Save
              ElevatedButton(
                onPressed: save,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(74, 28),
                  backgroundColor: Color.fromARGB(200, 55, 55, 55),
                ),
                child: const Text('Save'),
              ),

              // Cancel
              ElevatedButton(
                onPressed: cancel,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(74, 28),
                  backgroundColor: Color.fromARGB(200, 173, 25, 23),
                ),
                child: const Text('Cancel'),
              ),
            ],
          );
        });
      },
    );
  }

  void save() {
    // Save only if Amount is a double and Tag is not empty
    if (double.tryParse(createExpenseAmountController.text) == null ||
        createExpenseNameController.text.isEmpty) return;

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
