import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/data.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/methods.dart';
import 'package:untitled1/model.dart';

import 'dataBase.dart';

class addPage extends StatefulWidget {
  @override
  State<addPage> createState() => _addPageState();
}

class _addPageState extends State<addPage> {
  int RadioState = 1;
  late TextEditingController Desctiption = TextEditingController(),
      amount = TextEditingController();

  Widget DrawRadioBtn(bool isIncome) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
            value: isIncome ? 1 : 0,
            groupValue: RadioState,
            onChanged: (value) {
              setState(() {
                RadioState = isIncome ? 1 : 0;
              });
            },
            fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
          ),
          Text(
            isIncome ? "Income" : "Expense",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
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
        padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 50),
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
            DrawTextField(TextInputType.text, 'Description', Desctiption),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child:
                    DrawTextField(TextInputType.number, 'amount', amount)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawRadioBtn(true),
                    DrawRadioBtn(false),
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
                onPressed: () async {
                  //hide keyboard
                  FocusScope.of(context).requestFocus(FocusNode());

                  try {
                    RowData data = RowData(
                        isIncome: RadioState == 1 ? true : false,
                        amount: double.parse(amount.text),
                        description: Desctiption.text,
                        id: 0);
                    int id = await DataBase.insertData(data);
                    data.setId(id);
                    RowData.getData().insert(0, data);

                    // clear text fields
                    amount.clear();
                    Desctiption.clear();
                    showSnackBar(context, true);
                  } catch (e) {
                    showSnackBar(context, false);
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
