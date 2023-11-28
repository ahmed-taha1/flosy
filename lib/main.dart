import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Controller/ExpenseController.dart';
import 'package:untitled1/Controller/WishController.dart';
import 'package:untitled1/View/AddExpenseView.dart';
import 'package:untitled1/View/HomeView.dart';

import 'Model/PageName.dart';
import 'View/WishListView.Dart.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await ExpenseController.fetchDataToBuffer(); // fill the buffer from the data base
  await WishController.fetchDataToBuffer();
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  final GoRouter route = GoRouter(routes: [
    GoRoute(path: PageName.Home.path, builder: (context, state) => HomeView()),
    GoRoute(path: PageName.AddPage.path, builder: (context, state) => AddExpenseView()),
    GoRoute(path: PageName.WishListPage.path, builder: (context, state) => WishListView())
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
