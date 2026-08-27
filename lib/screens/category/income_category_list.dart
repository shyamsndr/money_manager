import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';
import 'widgets/category_card.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryDb = CategoryDbFunctionsImpl();

    final box = Hive.box<CategoryModel>('categories');

    return ValueListenableBuilder(
      valueListenable: box.listenable(),

      builder: (context, box, child) {
        final categories = categoryDb.getCategories(CategoryType.income);

        if (categories.isEmpty) {
          return const Center(
            child: Text(
              'No income categories',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),

          itemCount: categories.length,

          itemBuilder: (context, index) {
            final category = categories[index];

            return CategoryCard(category: category);
          },
        );
      },
    );
  }
}
