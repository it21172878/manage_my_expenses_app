import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

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

@HiveType(typeId: 1)
class ExpenseModel {
  // constructor
  ExpenseModel(
      {required this.productName,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid;

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  //getFrmated date
  String get formatDateValue {
    return formatDate.format(date);
  }
}
