import 'package:untitled1/Model/ExpenseType.dart';

import 'Date.dart';

class Expense {
  late ExpenseType _type;
  late double _amount;
  late String _description;
  late int _id;
  late Date _date;

  Expense(
      {required type,
      required amount,
      required description,
      id,
      Date? date}) {
    this._date = date ?? Date();
    if (id != null) {
      this._id = id;
    }

    this._type = type;
    this._amount = amount;
    this._description = description;
  }

  set id(int value) {
    _id = value;
  }

  ExpenseType get type => _type;

  double get amount => _amount;

  String get description => _description;

  Date get date => _date;

  int get id => _id;
}
