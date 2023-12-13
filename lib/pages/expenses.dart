import 'package:flutter/material.dart';
import 'package:manage_my_expenses_app/models/expense.dart';
import 'package:manage_my_expenses_app/widgets/add_new_expense.dart';
import 'package:manage_my_expenses_app/widgets/expense_list.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
// expense list
  final List<ExpenseModel> _expenseList = [
    ExpenseModel(
        productName: "London",
        amount: 100000,
        date: DateTime.now(),
        category: Category.travel),
    ExpenseModel(
        productName: "Pizza",
        amount: 1950,
        date: DateTime.now(),
        category: Category.food),
    ExpenseModel(
        productName: "Moose T-shirt",
        amount: 999.99,
        date: DateTime.now(),
        category: Category.cloths),
  ];

  // add new expense
  void onAddNewExpense(ExpenseModel expense) {
    setState(() {
      _expenseList.add(expense);
    });
  }

  // remove a expense
  void onDeleteExpense(ExpenseModel expense) {
    // store the deletinf expense
    ExpenseModel deletingExpense = expense;

    // get the index of the removing expense
    final int removingIndex = _expenseList.indexOf(expense);

    setState(() {
      _expenseList.remove(expense);
    });
    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Expense deleted successful"),
        action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                _expenseList.insert(removingIndex, deletingExpense);
              });
            })));
  }

  // function to open a model overlay
  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 253, 231),
      context: context,
      builder: (context) {
        return AddNewExpense(
          onAddExpense: onAddNewExpense,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          title: const Text(
            "mYExpenses",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Container(
                color: Colors.white,
                height: 60,
                width: 60,
                child: IconButton(
                    onPressed: _openAddExpensesOverlay,
                    icon: const Icon(Icons.add)))
          ],
        ),
        body: Column(
          children: [
            ExpenseList(
              expenseList: _expenseList,
              onDeleteExpense: onDeleteExpense,
            ),
          ],
        ));
  }
}
