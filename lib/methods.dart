import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/dataBase.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/model.dart';

Widget DrawPie(double height, int alpha, int width, bool backGround) {
  int income = RowData.getIncome() ?? 1;
  int expense = RowData.getExpense() ?? 1;
  return SizedBox(
      height: height,
      child: DChartPie(
        data: [
          {'domain': 'Expense', 'measure': expense},
          {'domain': 'Income', 'measure': income},
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

Widget DrawPieChart() {
  return Stack(
    children: [
      DrawPie(210, 120, 40, true),
      Padding(
          padding: const EdgeInsets.only(top: 5),
          child: DrawPie(200, 255, 30, false)),
    ],
  );
}

Widget DrawIncomeExpenseRec(bool IsIncome) {
  int income = RowData.getIncome() ?? 0;
  int expense = RowData.getExpense() ?? 0;

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

Widget DrawRowData() {
  return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: RowData.getData().length,
      itemBuilder: (ctx, i) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (ctx) async {
                  await DataBase.deleteRow(RowData.getData()[i].id);
                  log(RowData.getData()[i].id);
                  RowData.getData().removeAt(i);
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
                      RowData.getData()[i].isIncome
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: RowData.getData()[i].isIncome
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
                          RowData.getData()[i].description == ""
                              ? "${DateTime.now().month}/${DateTime.now().day}"
                              : RowData.getData()[i].description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          RowData.getData()[i].date,
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
                    '\$${RowData.getData()[i].amount}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget DrawTextField(TextInputType textInputType, String LabelText,
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

showSnackBar(BuildContext context, bool isSuccess) {
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
