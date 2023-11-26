import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Controller/ExpenseController.dart';
import 'package:untitled1/Model/Expense.dart';
import 'package:untitled1/main.dart';

import 'AddExpenseView.dart';

class WidgetDrawer{
  static Widget _drawPieChart(double height, int alpha, int width, bool backGround) {
    int incomeAmount = ExpenseController.getIncomeAmount() ?? 1;
    int expenseAmount = ExpenseController.getExpenseAmount() ?? 1;

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

  static Widget drawIncomeExpenseRec(bool IsIncome) {
    int income = ExpenseController.getIncomeAmount() ?? 1;
    int expense = ExpenseController.getExpenseAmount() ?? 1;

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
                IsIncome ? Icons.arrow_upward : Icons.arrow_downward,
                color: IsIncome ? Colors.greenAccent : Colors.redAccent,
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
                    IsIncome ? '+$income' : '-$expense',
                    style: TextStyle(
                      color: IsIncome ? Colors.greenAccent : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    IsIncome ? "income" : "Expense",
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
                    } catch(e){
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        expenseBuffer[i].isIncome
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: expenseBuffer[i].isIncome
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
                          Text(
                            expenseBuffer[i].description == ""
                                ? "${DateTime.now().month}/${DateTime.now().day}"
                                : expenseBuffer[i].description,
                            style: const TextStyle(fontSize: 16),
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '\$${expenseBuffer[i].amount}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Widget drawTextField(TextInputType textInputType, String LabelText,
      TextEditingController Controller) {
    return SizedBox(
      height: 70,
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
        maxLength: LabelText == "amount" ? 10 : 30,
      ),
    );
  }

  static showSnackBar(BuildContext context, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: isSuccess ? 'Success' : 'Failed!',
        message:
        isSuccess ? 'data has been added.' : 'invalid data please try again!',
        contentType: isSuccess ? ContentType.success : ContentType.failure,
      ),
    ));
  }

  static Widget drawRadioBtn(int state, int stateController, Function(int) onRadioBtnChanged) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
            value: state == AddExpenseView.INCOME_STATE ? 1 : 0,
            groupValue: stateController,
            onChanged: (value) {
              onRadioBtnChanged(value!);
            },
            fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
          ),
          Text(
            state == AddExpenseView.INCOME_STATE ? "Income" : "Expense",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}