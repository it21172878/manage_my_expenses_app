import 'package:flutter/material.dart';
import 'package:manage_my_expenses_app/models/expense.dart';
import 'package:manage_my_expenses_app/widgets/expense_tile.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenseList});
  final List<ExpenseModel> expenseList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ExpenseTile(expense: expenseList[index]),
            );
          }),
    );
  }
}
