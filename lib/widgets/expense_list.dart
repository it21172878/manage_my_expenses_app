import 'package:flutter/material.dart';
import 'package:manage_my_expenses_app/models/expense.dart';
import 'package:manage_my_expenses_app/widgets/expense_tile.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> expenseList;
  final void Function(ExpenseModel expense) onDeleteExpense;
  const ExpenseList(
      {super.key, required this.expenseList, required this.onDeleteExpense});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Dismissible(
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    onDeleteExpense(expenseList[index]);
                  },
                  key: ValueKey(expenseList[index]),
                  child: ExpenseTile(expense: expenseList[index])),
            );
          }),
    );
  }
}
