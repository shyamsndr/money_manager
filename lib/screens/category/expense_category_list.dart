import 'package:flutter/material.dart';

import 'widgets/category_card.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseCategories = [
      'FOOD',
      'TRAVEL',
      'SHOPPING',
      'EDUCATION',
      'HEALTH',
      'ENTERTAINMENT',
      'BILLS',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),

      itemCount: expenseCategories.length,

      itemBuilder: (context, index) {
        return CategoryCard(title: expenseCategories[index]);
      },
    );
  }
}
