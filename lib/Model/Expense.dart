import 'Date.dart';

class Expense {
  late bool _isIncome;
  late double _amount;
  late String _description;
  late int _id;
  late Date _date;


  Expense({required isIncome,
    required amount,
    required description,
    id,
    Date? date}) {
    this._date = date ?? new Date();
    this._id = id;  // TODO id my be null check what will happen
    this._isIncome = isIncome;
    this._amount = amount;
    this._description = description;
  }

  set id(int value) {
    _id = value;
  }

  bool get isIncome => _isIncome;

  double get amount => _amount;

  String get description => _description;

  Date get date => _date;

  int get id => _id;
}