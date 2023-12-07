import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
// create a unique id using uuid

final uuid = const Uuid().v4();

// create enum category
// enum Category { keells, cargills, foodcity, fair, market, grocery, shop }
enum Category { food, travel, cloths, transporation, other }

//date formater
final formatDate = DateFormat.yMd();

//category icons
final categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.location_on,
  Category.cloths: Icons.woman,
  Category.transporation: Icons.add_road,
  Category.other: Icons.store,
};

class ExpenseModel {
  // constructor
  ExpenseModel(
      {required this.productName,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid;

  final String id;
  final String productName;
  final double amount;
  final DateTime date;
  final Category category;

  //getFrmated date
  String get formatDateValue {
    return formatDate.format(date);
  }
}
