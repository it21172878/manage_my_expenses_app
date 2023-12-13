import 'package:flutter/material.dart';
import 'package:manage_my_expenses_app/models/expense.dart';
import 'package:manage_my_expenses_app/widgets/add_new_expense.dart';
import 'package:manage_my_expenses_app/widgets/expense_list.dart';
import 'package:pie_chart/pie_chart.dart';

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

  // PIE Chart
  Map<String, double> dataMap = {
    "food": 0,
    "travel": 0,
    "cloths": 0,
    "transporation": 0,
    "other": 0,
  };

  // add new expense
  void onAddNewExpense(ExpenseModel expense) {
    setState(() {
      _expenseList.add(expense);
      calCategoryValues();
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
      calCategoryValues();
    });
    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Expense deleted successful"),
        action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                _expenseList.insert(removingIndex, deletingExpense);
                calCategoryValues();
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

  // PIE Chart value
  double foodVal = 0;
  double travelVal = 0;
  double clothsVal = 0;
  double transporationVal = 0;
  double otherVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double travelValTotal = 0;
    double clothsValTotal = 0;
    double transporationValTotal = 0;
    double otherValTotal = 0;

    for (final expense in _expenseList) {
      if (expense.category == Category.food) {
        foodValTotal += expense.amount;
      }
      if (expense.category == Category.travel) {
        travelValTotal += expense.amount;
      }
      if (expense.category == Category.cloths) {
        clothsValTotal += expense.amount;
      }
      if (expense.category == Category.transporation) {
        transporationValTotal += expense.amount;
      }
      if (expense.category == Category.other) {
        otherValTotal += expense.amount;
      }
    }
    setState(() {
      foodVal = foodValTotal;
      travelVal = travelValTotal;
      clothsVal = clothsValTotal;
      transporationVal = transporationValTotal;
      otherVal = otherValTotal;
    });

    // update datamap
    dataMap = {
      "food": foodVal,
      "travel": travelVal,
      "cloths": clothsVal,
      "transporation": transporationVal,
      "other": otherVal,
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calCategoryValues();
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
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          PieChart(dataMap: dataMap),
          ExpenseList(
            expenseList: _expenseList,
            onDeleteExpense: onDeleteExpense,
          ),
        ],
      ),
    );
  }
}
