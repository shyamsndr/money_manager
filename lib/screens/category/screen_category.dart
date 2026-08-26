import 'package:flutter/material.dart';

import 'widgets/category_card.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Column(
        children: [
          // Category TabBar
          const TabBar(
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,

            tabs: [
              Tab(text: 'INCOME'),

              Tab(text: 'EXPENSE'),
            ],
          ),

          // Content of selected tab
          Expanded(
            child: TabBarView(
              children: [IncomeCategories(), ExpenseCategories()],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================
// INCOME
// ==================================================

class IncomeCategories extends StatelessWidget {
  const IncomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),

      children: const [
        CategoryCard(title: 'SALARY'),

        CategoryCard(title: 'OTHER CATEGORY'),
      ],
    );
  }
}

// ==================================================
// EXPENSE
// ==================================================

class ExpenseCategories extends StatelessWidget {
  const ExpenseCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),

      children: const [
        CategoryCard(title: 'FOOD'),

        CategoryCard(title: 'TRAVEL'),
      ],
    );
  }
}
