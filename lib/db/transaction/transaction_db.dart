import 'package:hive_flutter/hive_flutter.dart';

import '../../models/transaction/transaction_model.dart';

abstract class TransactionDbFunctions {
  Future<void> insertTransaction(TransactionModel transaction);

  List<TransactionModel> getTransactions();

  Future<void> deleteTransaction(dynamic key);
}

class TransactionDbFunctionsImpl implements TransactionDbFunctions {
  final Box<TransactionModel> box = Hive.box<TransactionModel>('transactions');

  @override
  Future<void> insertTransaction(TransactionModel transaction) async {
    await box.add(transaction);
  }

  @override
  List<TransactionModel> getTransactions() {
    return box.values.toList();
  }

  @override
  Future<void> deleteTransaction(dynamic key) async {
    await box.delete(key);
  }
}
