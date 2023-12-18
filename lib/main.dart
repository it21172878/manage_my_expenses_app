import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:manage_my_expenses_app/models/expense.dart';
import 'package:manage_my_expenses_app/pages/expenses.dart';
import 'package:manage_my_expenses_app/server/categories_adapter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  runApp(const MainApp());

  await Hive.openBox("expenseDatabase");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Expences());
  }
}
