import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Model/ExpenseType.dart';
import 'package:untitled1/View/WidgetDrawer.dart';

import '../Model/PageName.dart';

class HomeView extends StatelessWidget {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          gradientFractionOnEnd: 0.2,
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Statement Details",
                  style: TextStyle(fontSize: 16),
                ),
                WidgetDrawer.drawPieCharts(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WidgetDrawer.drawIncomeOrExpenseRectangle(ExpenseType.INCOME),
                            WidgetDrawer.drawIncomeOrExpenseRectangle(ExpenseType.EXPENSE),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Recent Statements"),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1.5,
                            color: const Color.fromARGB(255, 238, 239, 245),
                          ),
                          WidgetDrawer.drawExpenseList(),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 140, 111, 228),
              onPressed: () => context.go(PageName.WishListPage.path),
              child: const Icon(Icons.list),
            ),
          ),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 140, 111, 228),
            onPressed: () => context.go(PageName.AddPage.path),
            child: const Icon(Icons.add),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
