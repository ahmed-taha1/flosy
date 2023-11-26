import 'package:untitled1/DataBase/DataBaseHelper.dart';
import 'package:untitled1/Model/Expense.dart';

class ExpenseController{
  static List<Expense> _buffer = [];

  static Future<void> fetchDataToBuffer() async {
    _buffer = await DataBaseHelper.read();
  }

  static addExpense(bool isIncome, String description, double amount) async{
    try {
      Expense e = Expense(
        isIncome: isIncome,
        amount: amount,
        description: description,
      );
      int id = await DataBaseHelper.insert(e);
      e.id = id;
      _buffer.insert(0, e);
    } catch(e){
      rethrow;
    }
  }

  static removeExpenseAt(int index){  // TODO i didn't use async or await check it's results later
    try {
      DataBaseHelper.delete(_buffer[index].id);
      _buffer.removeAt(index);
    } catch(e){
      rethrow;
    }
  }

  static getExpenseAmount() {
    double expense = 0;
    if (_buffer.isEmpty) {
      return null;
    }
    for (var e in _buffer) {
      if (!e.isIncome) {
        expense += e.amount;
      }
    }
    return expense.round();
  }

  static getIncomeAmount() {
    double income = 0;
    double expense = 0;
    if (_buffer.isEmpty) {
      return null;
    }
    for (var e in _buffer) {
      if (e.isIncome) {
        income += e.amount;
      } else {
        expense += e.amount;
      }
    }
    income -= expense;
    return income.round() < 0 ? 0 : income.round();
  }

  static List<Expense> getBuffer() {
    return _buffer;
  }
}
