import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../db/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  final purposeController = TextEditingController();
  final amountController = TextEditingController();

  final categoryDb = CategoryDbFunctionsImpl();
  final transactionDb = TransactionDbFunctionsImpl();

  // Initially Income
  CategoryType selectedType = CategoryType.income;

  // No date selected initially
  DateTime? selectedDate;

  // No category selected initially
  int? selectedCategoryId;

  // --------------------------------------------------
  // DATE PICKER
  // --------------------------------------------------

  Future<void> selectDate() async {
    final today = DateTime.now();

    final date = await showDatePicker(
      context: context,

      initialDate: today,

      firstDate: today.subtract(const Duration(days: 30)),

      lastDate: today,
    );

    if (date == null) {
      return;
    }

    setState(() {
      selectedDate = date;
    });
  }

  // --------------------------------------------------
  // ADD TRANSACTION
  // --------------------------------------------------

  Future<void> addTransaction() async {
    final purpose = purposeController.text.trim();
    final amount = amountController.text.trim();

    // Check purpose
    if (purpose.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter purpose')));
      return;
    }

    // Check amount
    if (amount.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter amount')));
      return;
    }

    // Check date
    if (selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Select date')));
      return;
    }

    // Check category
    if (selectedCategoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Select category')));
      return;
    }

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch,

      purpose: purpose,

      date: selectedDate!,

      amount: amount,

      type: selectedType,

      categoryId: selectedCategoryId!,
    );

    await transactionDb.insertTransaction(transaction);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get categories according to Income / Expense
    final categories = categoryDb.getCategories(selectedType);

    // Convert category list into Map
    final categoryMap = {
      for (final category in categories) category.id: category.name,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Transaction',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      // Keyboard-safe
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // ==================================================
            // PURPOSE
            // ==================================================
            TextField(
              controller: purposeController,

              decoration: InputDecoration(
                labelText: 'Purpose',
                hintText: 'Why is this transaction?',
                prefixIcon: const Icon(Icons.description),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // AMOUNT
            // ==================================================
            TextField(
              controller: amountController,

              // As you requested
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: const Icon(Icons.currency_rupee),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // INCOME / EXPENSE
            // ==================================================
            RadioGroup<CategoryType>(
              groupValue: selectedType,

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  selectedType = value;

                  // Reset category because
                  // Income and Expense have different categories
                  selectedCategoryId = null;
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

            const SizedBox(height: 10),

            // ==================================================
            // CATEGORY DROPDOWN
            // ==================================================
            DropdownButtonFormField<int>(
              initialValue: categoryMap.containsKey(selectedCategoryId)
                  ? selectedCategoryId
                  : null,

              decoration: InputDecoration(
                labelText: 'Category',
                prefixIcon: const Icon(Icons.category),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              hint: const Text('Select category'),

              items: categoryMap.entries.map((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCategoryId = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // ==================================================
            // DATE
            // ==================================================
            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: selectDate,

                icon: const Icon(Icons.calendar_month),

                label: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : '${selectedDate!.day}/'
                            '${selectedDate!.month}/'
                            '${selectedDate!.year}',
                ),

                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.purple,

                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // SUBMIT
            // ==================================================
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: addTransaction,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),

                child: const Text('Submit', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    purposeController.dispose();
    amountController.dispose();

    super.dispose();
  }
}
