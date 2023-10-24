import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});
  final void Function(Expense) addExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category cat = Category.leisure;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final datePicked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      selectedDate = datePicked;
    });
    print(datePicked);
  }

  //don't forget to use dispose as it kills controller
  //when it was not rendering on user interface anymore.
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void create() {
    final enteredAmount = double.tryParse(amountController.text);
    final bool amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountInvalid ||
        selectedDate == null) {
      //error msg
      //context in builder is context of show dialog but another parameter got remaingin
      //value.
      showDialog(
          builder: (context) => AlertDialog(
                title: const Text('Invalid values'),
                content: const Text(
                  'please make sure you filled correct values',
                ),
                //actions are simply some buttons which will be
                //shown in dialog inorder to close the dialog.
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('close it'))
                ],
              ),
          context: context);
      return;
    }
    widget.addExpense(Expense(
        amount: double.parse(amountController.text),
        category: cat,
        date: selectedDate!,
        title: titleController.text));
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: ((context, constraints) {
        final width = constraints.maxWidth;
        print("hdkd $constraints");

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width > 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            maxLength: 50,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(label: Text('Title')),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextField(
                              controller: amountController,
                              maxLength: 8,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text('Amount'),
                                prefixText: '\$ ',
                              )),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: titleController,
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(label: Text('Title')),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: amountController,
                            maxLength: 8,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$ ',
                            )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text((selectedDate == null)
                                ? 'select Date'
                                : formatter.format(selectedDate!)),
                            IconButton(
                                onPressed: presentDatePicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      DropdownButton(
                          value: cat,
                          items: Category.values
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              cat = value;
                            });
                          }),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('cancel'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: create,
                        child: const Text('create'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
