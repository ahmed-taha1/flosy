import 'dart:ffi';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Controller/ExpenseController.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/View/WidgetDrawer.dart';

import '../Model/ExpenseType.dart';
import '../Model/PageName.dart';

class AddExpenseView extends StatefulWidget {
  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  int radioBtnState = ExpenseType.INCOME.index;
  TextEditingController descriptionField = TextEditingController(),
      amountField = TextEditingController();

  void handleRadioBtnState(int state) {
    setState(() {
      radioBtnState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => context.go(PageName.Home.path),
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 149, 64, 253),
              Color.fromARGB(255, 94, 73, 248),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 230, horizontal: 50),
        child: Column(
          children: [
            const Text(
              "Please Fill The Data.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            WidgetDrawer.drawTextField(
                TextInputType.text, 'description', descriptionField, 30),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: WidgetDrawer.drawTextField(
                        TextInputType.number, 'amount', amountField, 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetDrawer.drawRadioBtn(ExpenseType.INCOME.index,
                        radioBtnState,ExpenseType.INCOME.text ,handleRadioBtnState),
                    WidgetDrawer.drawRadioBtn(ExpenseType.EXPENSE.index,
                        radioBtnState,ExpenseType.EXPENSE.text, handleRadioBtnState),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  FocusScope.of(context)
                      .requestFocus(FocusNode()); //hide keyboard
                  try {
                    await ExpenseController.addExpense(
                        ExpenseType.values[radioBtnState],
                        descriptionField.text,
                        double.parse(amountField.text));
                    // clear text fields
                    amountField.clear();
                    descriptionField.clear();
                    WidgetDrawer.showSnackBar(context, ContentType.success, "Success", "Data has been Added");
                  } catch (e) {
                    WidgetDrawer.showSnackBar(context, ContentType.failure, "Failed", "Invalid Data");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  "ADD",
                  style: TextStyle(
                      color: Color.fromARGB(255, 106, 140, 253),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}