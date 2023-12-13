import 'package:flutter/material.dart';
import 'package:manage_my_expenses_app/models/expense.dart';

class AddNewExpense extends StatefulWidget {
  final void Function(ExpenseModel expense) onAddExpense;
  const AddNewExpense({super.key, required this.onAddExpense});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;

  // date variables
  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 2, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDate = DateTime.now();
  // date picker
  Future<void> _openDateModel() async {
    try {
      final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate);

      setState(() {
        _selectedDate = pickedDate!;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  // form validation
  void _handleFormSubmit() {
    // form validation
    // convert the amount into a double
    final userAmount = double.parse(_amountController.text.trim());
    if (_titleController.text.trim().isEmpty || userAmount <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text(
                "Please enter the valid data for the title and the amount here the title can not be empty and amount can not be '0' or 'less than zero'."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("close"),
              )
            ],
          );
        },
      );
    } else {
      // create new expense
      ExpenseModel newExpense = ExpenseModel(
          productName: _titleController.text.trim(),
          amount: userAmount,
          date: _selectedDate,
          category: _selectedCategory);
      // save the data
      widget.onAddExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "add new expense title",
              label: Text("Title"),
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              // amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    hintText: "amount for service",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              // date picker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(formatDate.format(_selectedDate)),
                    IconButton(
                      color: Colors.amber,
                      onPressed: _openDateModel,
                      icon: const Icon(Icons.date_range_sharp),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              DropdownButton(
                menuMaxHeight: 150,
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // close the model button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                        side: BorderSide(color: Colors.amber),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 255, 253, 231)),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
                const SizedBox(width: 0),
                // save the date and close the model button
                ElevatedButton(
                  onPressed: _handleFormSubmit,
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 231)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
