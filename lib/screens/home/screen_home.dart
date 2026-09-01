import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../add_transaction/screen_add_transaction.dart';
import '../category/screen_category.dart';
import '../category/screen_add_category.dart';

import '../../db/transaction/transaction_db.dart';
import '../../models/transaction/transaction_model.dart';

import 'widgets/transaction_card.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  // 0 = Home
  // 1 = Category
  int currentIndex = 0;

  // Body screens
  final screens = const [ScreenTransactions(), ScreenCategory()];

  // Floating button action
  void floatingButtonPressed(BuildContext context) {
    if (currentIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ScreenAddTransaction();
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ScreenAddCategory();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SAME APP BAR
      appBar: AppBar(
        title: const Text(
          'Money Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      // Only the body changes
      body: screens[currentIndex],

      // Same floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          floatingButtonPressed(context);
        },
        backgroundColor: Colors.deepPurple.shade100,
        foregroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),

      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
        ],
      ),
    );
  }
}

// ==================================================
// HOME / TRANSACTIONS BODY
// ==================================================

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionDb = TransactionDbFunctionsImpl();

    return ValueListenableBuilder<Box<TransactionModel>>(
      valueListenable: transactionDb.box.listenable(),

      builder: (context, box, child) {
        final transactions = box.values.toList().reversed.toList();

        // No transactions
        if (transactions.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 60, color: Colors.grey),

                SizedBox(height: 15),

                Text(
                  'No transactions yet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Add your first transaction',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // Display all transactions
        return ListView.builder(
          padding: const EdgeInsets.only(
            top: 15,
            left: 16,
            right: 16,
            bottom: 16,
          ),

          itemCount: transactions.length,

          itemBuilder: (context, index) {
            final transaction = transactions[index];

            // Get the actual Hive key
            final key = box.keys.toList().reversed.toList()[index];

            return Dismissible(
              key: ValueKey(key),

              direction: DismissDirection.endToStart,

              background: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),

                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Icon(Icons.delete, color: Colors.white),
              ),

              onDismissed: (direction) async {
                await transactionDb.deleteTransaction(key);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaction deleted')),
                );
              },

              child: TransactionCard(transaction: transaction),
            );
          },
        );
      },
    );
  }
}
