import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Controller/ExpenseController.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/View/WidgetDrawer.dart';

class AddExpenseView extends StatefulWidget {
  static int EXPENSE_STATE = 0, INCOME_STATE = 1;

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  int radioBtnState = AddExpenseView.INCOME_STATE;
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
                TextInputType.text, 'description', descriptionField),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: WidgetDrawer.drawTextField(
                        TextInputType.number, 'amount', amountField)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetDrawer.drawRadioBtn(AddExpenseView.INCOME_STATE,
                        radioBtnState, handleRadioBtnState),
                    WidgetDrawer.drawRadioBtn(AddExpenseView.EXPENSE_STATE,
                        radioBtnState, handleRadioBtnState),
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
                onPressed: () {
                  FocusScope.of(context)
                      .requestFocus(FocusNode()); //hide keyboard
                  try {
                    ExpenseController.addExpense(
                        radioBtnState == 1 ? true : false,
                        amountField.text,
                        double.parse(amountField.text));
                    // clear text fields
                    amountField.clear();
                    descriptionField.clear();
                    WidgetDrawer.showSnackBar(context, true);
                  } catch (e) {
                    WidgetDrawer.showSnackBar(context, false);
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
