import 'package:bookhive/firebase_options.dart';
import 'package:bookhive/views/add_book_view.dart';
import 'package:bookhive/views/all_books_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized only once
await Firebase.initializeApp(
  name: 'BookHive',
  options: DefaultFirebaseOptions.currentPlatform,
);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookHive Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AllBooksView(),
    );
  }
}
