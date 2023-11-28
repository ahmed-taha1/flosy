import 'dart:math';

import 'package:untitled1/DataBase/DataBaseHelper.dart';
import 'package:untitled1/Model/Expense.dart';
import 'package:untitled1/Model/ExpenseType.dart';

import '../Model/Date.dart';

class ExpenseController {
  static List<Expense> _buffer = [];

  static Future<void> fetchDataToBuffer() async {
    List<Map> response = await DataBaseHelper.read('''
        SELECT * FROM "Expense"
        ORDER BY id DESC;
      ''');

    _buffer = [];
    for (var element in response) {
      _buffer.add(Expense(
          date: element['date'] == null ? Date() : Date(date: element['date']),
          type: ExpenseType.values[element['type']],
          amount: element['amount'],
          description: element['description'],
          id: element['id']));
    }
  }

  static addExpense(
      ExpenseType expenseType, String description, double amount) async {
    try {
      Expense expense = Expense(
        type: expenseType,
        amount: amount,
        description: description,
      );

      if (expense.amount < 0) {
        throw 0;
      } //TODO change RowData Table to Expense
      int id = await DataBaseHelper.insert('''
          INSERT INTO "Expense" (
            "amount", "description", "type", "date") 
          VALUES(
            ${expense.amount},
            "${expense.description}",
            ${expense.type.index},
            "${expense.date.toString()}")
        ''');

      expense.id = id;
      _buffer.insert(0, expense);
    } catch (e) {
      rethrow;
    }
  }

  static removeExpenseAt(int index) {
    // TODO i didn't use async or await check it's results later
    try {
      DataBaseHelper.delete('''
          DELETE FROM "Expense" WHERE id = ${_buffer[index].id}
        ''');
      _buffer.removeAt(index);
    } catch (e) {
      rethrow;
    }
  }

  static _getExpenseAmount() {
    double expense = 0;
    if (_buffer.isEmpty) {
      return null;
    }
    for (var e in _buffer) {
      if (e.type == ExpenseType.EXPENSE) {
        expense += e.amount;
      }
    }
    return expense.round();
  }

  static _getIncomeAmount() {
    double income = 0;
    double expense = 0;
    if (_buffer.isEmpty) {
      return null;
    }
    for (var e in _buffer) {
      if (e.type == ExpenseType.INCOME) {
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

  static getAmount(ExpenseType expenseType){
    switch(expenseType){
      case ExpenseType.EXPENSE:
        return ExpenseController._getExpenseAmount();
      case ExpenseType.INCOME:
        return ExpenseController._getIncomeAmount();
    }
  }
}