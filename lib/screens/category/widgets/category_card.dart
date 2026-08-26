import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;

  const CategoryCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),

        trailing: TextButton(
          onPressed: () {
            print('Delete $title');
          },

          child: const Text('DEL', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
