import 'package:hive/hive.dart';

import '../category/category_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String purpose;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String amount;

  @HiveField(4)
  final CategoryType type;

  @HiveField(5)
  final int categoryId;

  TransactionModel({
    required this.id,
    required this.purpose,
    required this.date,
    required this.amount,
    required this.type,
    required this.categoryId,
  });
}
