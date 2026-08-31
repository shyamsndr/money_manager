import 'package:flutter/material.dart';

import '../../../models/transaction/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type.name == 'income';

    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),

        title: Text(
          transaction.purpose,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        subtitle: Text(
          '${transaction.date.day}/'
          '${transaction.date.month}/'
          '${transaction.date.year}',
        ),

        trailing: Text(
          isIncome ? '+ ₹${transaction.amount}' : '- ₹${transaction.amount}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
