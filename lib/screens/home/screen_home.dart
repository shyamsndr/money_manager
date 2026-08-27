import 'package:flutter/material.dart';

import '../category/screen_category.dart';
import 'widgets/transaction_card.dart';
import '../category/screen_add_category.dart';

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
      print('Floating button pressed from HOME');
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
      // SAME APP BAR for both screens
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
    return ListView(
      padding: const EdgeInsets.all(16),

      children: const [
        TransactionCard(amount: 'XXXXXX', date: '12 DEC', title: 'SALARY'),
      ],
    );
  }
}
