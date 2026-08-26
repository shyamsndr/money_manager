import 'package:flutter/material.dart';

import 'income_category_list.dart';
import 'expense_category_list.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Column(
        children: [

          // Income / Expense tabs
          const TabBar(
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,

            tabs: [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENSE',
              ),
            ],
          ),

          // Changes according to selected tab
          Expanded(
            child: TabBarView(
              children: [
                IncomeCategoryList(),
                ExpenseCategoryList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}