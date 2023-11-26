import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Controller/ExpenseController.dart';
import 'package:untitled1/View/AddExpenseView.dart';
import 'package:untitled1/View/HomeView.dart';

enum PageName {
  Home("/"),
  AddPage("/add-page");

  final String path;

  const PageName(this.path);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // fill array data
  await ExpenseController.fetchDataToBuffer();
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  final GoRouter route = GoRouter(routes: [
    GoRoute(path: PageName.Home.path, builder: (context, state) => HomeView()),
    GoRoute(path: PageName.AddPage.path, builder: (context, state) => AddExpenseView())
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: route,
      theme: ThemeData(
        fontFamily: 'jost',
        primaryColor: const Color.fromARGB(255, 140, 111, 228),
      ),
    );
  }
}
