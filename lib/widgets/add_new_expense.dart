import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:manage_my_expenses_app/models/expense.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _textController,
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
                    const Text("2023.12.25"),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.date_range_sharp))
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
                  onPressed: () {},
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
                  onPressed: () {},
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
