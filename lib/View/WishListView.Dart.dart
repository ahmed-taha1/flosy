import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/Controller/WishController.dart';
import 'package:untitled1/View/WidgetDrawer.dart';

import '../Model/PageName.dart';

class WishListView extends StatelessWidget {
  TextEditingController nameField = new TextEditingController();

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
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            const Text(
              "Wish List",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 200,
                    child: WidgetDrawer.drawTextField(
                        TextInputType.text, "Name", nameField, 30)),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    try {
                      await WishController.addWish(nameField.text);
                      context.go(PageName.WishListPage.path);
                      WidgetDrawer.showSnackBar(context, ContentType.success,
                          "Success", "Data has been added");
                    } catch (e) {
                      WidgetDrawer.showSnackBar(context, ContentType.failure,
                          "Failed", "Invalid operation");
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Color.fromARGB(255, 106, 140, 253)),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                )
              ],
            ),
            WidgetDrawer.drawWishList(),
          ]),
        ),
      ),
    );
  }
}
