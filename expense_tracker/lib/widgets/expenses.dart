import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  Widget mainContent = const Center(
    child: Text('no expenses found,add some'),
  );
  final List<Expense> expenses = [];
  void addExpenses(Expense e) {
    setState(() {
      expenses.add(e);
    });
  }

  void removeExpense(Expense e) {
    final expensePos = expenses.indexOf(e);
    setState(() {
      expenses.remove(e);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('item has been removed'),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                expenses.insert(expensePos, e);
              });
            }),
      ),
    );
  }

  void openAddExpenseModel() {
    //..logic to open it.
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          //here we have to return our own widget which we wanna show.
          return NewExpense(addExpenses);
        });
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (expenses.isNotEmpty) {
      mainContent = ExpensesList(expense: expenses, onSlide: removeExpense);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('ExpenseTracker'),
          actions: [
            IconButton(
                onPressed: openAddExpenseModel, icon: const Icon(Icons.add))
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: expenses),

                  //column has list as it child
                  //so flutter won't know how to display just get it done
                  //using expanded
                  Expanded(
                    child: mainContent,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: expenses)),

                  //column has list as it child
                  //so flutter won't know how to display just get it done
                  //using expanded
                  Expanded(
                    child: mainContent,
                  )
                ],
              ));
  }
}
