import 'package:expense_tracker/models/expense.dart';

List<Expense> expenses = [
  Expense(
    category: Category.food,
    title: 'Panipuri',
    amount: 10,
    date: DateTime.now(),
  ),
  Expense(
    category: Category.food,
    title: 'Panipuri',
    amount: 500,
    date: DateTime.now(),
  ),
  Expense(
    category: Category.travel,
    title: 'Vijayawada',
    amount: 1000,
    date: DateTime.now(),
  ),
  Expense(
    category: Category.leisure,
    title: 'chai',
    amount: 20,
    date: DateTime.now(),
  ),
  Expense(
    category: Category.work,
    title: 'Notebooks',
    amount: 50,
    date: DateTime.now(),
  ),
];
