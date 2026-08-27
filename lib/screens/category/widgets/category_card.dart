import 'package:flutter/material.dart';

import '../../../db/category/category_db.dart';
import '../../../models/category/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryDb = CategoryDbFunctionsImpl();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

        title: Text(
          category.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),

        trailing: TextButton(
          onPressed: () async {
            await categoryDb.deleteCategory(category.id);
          },

          child: const Text('DEL', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
