import 'package:hive_flutter/hive_flutter.dart';

import '../../models/transaction/transaction_model.dart';

abstract class TransactionDbFunctions {
  Future<void> insertTransaction(TransactionModel transaction);

  List<TransactionModel> getTransactions();
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
}
