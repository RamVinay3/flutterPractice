import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

//this are not wrapped around single quotations
//whereas it is kinda treated like as strings by dart.
enum Category { food, work, leisure, travel }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff
};

class Expense {
  Expense({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get getFormattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
    for (var i in expenses) {
      sum += i.amount;
    }

    return sum;
  }
}
