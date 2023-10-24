import 'package:expense_tracker/widgets/expenses_card.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expense, required this.onSlide});
  final void Function(Expense e) onSlide;
  final List<Expense> expense;
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: ((context, index) {
        return Dismissible(
            background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75)),
            onDismissed: (direction) {
              onSlide(expense[index]);
            },
            key: ValueKey(expense[index]),
            child: ExpenseCard(expense: expense[index]));
      }),
    );
  }
}
