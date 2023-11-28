import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Controller/ExpenseController.dart';
import 'package:untitled1/Controller/WishController.dart';
import 'package:untitled1/Model/Expense.dart';
import 'package:untitled1/Model/ExpenseType.dart';
import 'package:untitled1/Model/Wish.dart';
import '../Model/PageName.dart';

class WidgetDrawer {
  static Widget _drawPieChart(
      double height, int alpha, int width, bool backGround) {
    int incomeAmount = ExpenseController.getAmount(ExpenseType.INCOME) ?? 1;
    int expenseAmount = ExpenseController.getAmount(ExpenseType.EXPENSE) ?? 1;

    return SizedBox(
        height: height,
        child: DChartPie(
          data: [
            {'domain': 'Expense', 'measure': expenseAmount},
            {'domain': 'Income', 'measure': incomeAmount},
          ],
          fillColor: (Map<String, dynamic> pieData, int? index) {
            switch (pieData['domain']) {
              case 'Expense':
                return Color.fromARGB(alpha, 140, 111, 228);
              case 'Income':
                return Color.fromARGB(alpha, 247, 191, 20);
            }
          },
          labelPosition:
              backGround ? PieLabelPosition.inside : PieLabelPosition.outside,
          pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
            return backGround ? ' ' : pieData['domain'];
          },
          donutWidth: width,
        ));
  }

  static Widget drawPieCharts() {
    return Stack(
      children: [
        _drawPieChart(210, 120, 40, true),
        Padding(
            padding: const EdgeInsets.only(top: 5),
            child: _drawPieChart(200, 255, 30, false)),
      ],
    );
  }

  static Widget drawIncomeOrExpenseRectangle(ExpenseType expenseType) {
    int amount = ExpenseController.getAmount(expenseType) ?? 0;
    // int expenseAmount = ExpenseController.getAmount(ExpenseType.EXPENSE) ?? 0;

    return Container(
      height: 70,
      width: 140,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 238, 239, 245),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Icon(
                expenseType == ExpenseType.INCOME
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: expenseType == ExpenseType.INCOME
                    ? Colors.greenAccent
                    : Colors.redAccent,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$amount',
                    style: TextStyle(
                      color: expenseType == ExpenseType.INCOME
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    expenseType.text,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget drawExpenseList() {
    List<Expense> expenseBuffer = ExpenseController.getBuffer();
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: expenseBuffer.length,
        itemBuilder: (ctx, i) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (ctx) {
                    try {
                      ExpenseController.removeExpenseAt(i);
                    } catch (e) {
                      rethrow;
                    }
                    ctx.go(PageName.Home.path);
                  },
                  backgroundColor: Colors.red,
                  label: 'Delete',
                  icon: Icons.delete,
                ),
              ],
            ),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Icon(
                    expenseBuffer[i].type == ExpenseType.INCOME
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: expenseBuffer[i].type == ExpenseType.INCOME
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          expenseBuffer[i].description,
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        expenseBuffer[i].date.toString(),
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${expenseBuffer[i].amount}\$',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Widget drawWishList() {
    List<Wish> wishBuffer = WishController.getBuffer();
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: wishBuffer.length,
        itemBuilder: (ctx, i) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (ctx) {
                    try {
                      WishController.removeExpenseAt(i);
                    } catch (e) {
                      rethrow;
                    }
                    ctx.go(PageName.WishListPage.path);
                  },
                  backgroundColor: Colors.red,
                  label: 'Delete',
                  icon: Icons.delete,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 60,
                  child: Text(
                    wishBuffer[i].name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Widget drawTextField(TextInputType textInputType, String LabelText,
      TextEditingController Controller, int maxLength) {
    return SizedBox(
      height: 74,
      child: TextField(
        controller: Controller,
        decoration: InputDecoration(
          labelText: LabelText,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          counterStyle: const TextStyle(
            color: Colors.white, // Replace with your desired color
          ),
        ),
        style: const TextStyle(color: Colors.white),
        keyboardType: textInputType,
        maxLength: maxLength,
      ),
    );
  }

  static showSnackBar(BuildContext context, ContentType contentType,
      String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    ));
  }

  static Widget drawRadioBtn(int state, int stateController, String text,
      Function(int) onRadioBtnChanged) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
            value: state,
            groupValue: stateController,
            onChanged: (value) {
              onRadioBtnChanged(value!);
            },
            fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
