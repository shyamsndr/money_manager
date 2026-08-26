import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String date;
  final String title;

  const TransactionCard({
    super.key,
    required this.amount,
    required this.date,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Text(
              amount,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(date, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 5),

            Text(title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
