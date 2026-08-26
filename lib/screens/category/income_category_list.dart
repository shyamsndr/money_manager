import 'package:flutter/material.dart';

import 'widgets/category_card.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeCategories = [
      'SALARY',
      'BUSINESS',
      'FREELANCE',
      'INVESTMENT',
      'GIFT',
      'BONUS',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),

      itemCount: incomeCategories.length,

      itemBuilder: (context, index) {
        return CategoryCard(title: incomeCategories[index]);
      },
    );
  }
}
