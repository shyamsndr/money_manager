import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

class ScreenAddCategory extends StatefulWidget {
  const ScreenAddCategory({super.key});

  @override
  State<ScreenAddCategory> createState() => _ScreenAddCategoryState();
}

class _ScreenAddCategoryState extends State<ScreenAddCategory> {
  final nameController = TextEditingController();

  CategoryType selectedType = CategoryType.income;

  final categoryDb = CategoryDbFunctionsImpl();

  Future<void> addCategory() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return;
    }

    final category = CategoryModel(
      id: categoryDb.getNextId(),
      name: name,
      type: selectedType,
    );

    await categoryDb.insertCategory(category);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Category',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            RadioGroup<CategoryType>(
              groupValue: selectedType,

              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },

              child: const Column(
                children: [
                  RadioListTile<CategoryType>(
                    title: Text('Income'),
                    value: CategoryType.income,
                  ),

                  RadioListTile<CategoryType>(
                    title: Text('Expense'),
                    value: CategoryType.expense,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: addCategory,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),

                child: const Text('Submit', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
