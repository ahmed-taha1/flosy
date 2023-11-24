import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/View/addPage.dart';
import 'package:untitled1/DataBase/data.dart';
import 'package:untitled1/View/home.dart';

enum PageName {
  Home("/"),
  AddPage("/add-page");

  final String path;

  const PageName(this.path);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // fill array data
  await YourDataHandler.getDataAndStoreInArray();
  runApp(expenseTracker());
}

class expenseTracker extends StatelessWidget {
  GoRouter route = GoRouter(routes: [
    GoRoute(path: PageName.Home.path, builder: (context, state) => home()),
    GoRoute(path: PageName.AddPage.path, builder: (context, state) => addPage())
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
