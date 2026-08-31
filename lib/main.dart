import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/transaction/transaction_model.dart';
import 'models/category/category_model.dart';
import 'screens/home/screen_home.dart';

Future<void> main() async {
  // Required before using platform plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register CategoryType adapter
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  // Register CategoryModel adapter
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  // Open category box
  await Hive.openBox<CategoryModel>('categories');

  //Register TranscationModel adapter
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  //open transaction model
  await Hive.openBox<TransactionModel>('transactions');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Money Manager',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),

      home: const ScreenHome(),
    );
  }
}
