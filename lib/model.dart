import 'package:untitled1/data.dart';

class RowData {
  bool isIncome;
  double amount;
  String description;
  int id;
  String date;

  RowData(
      {required this.isIncome,
      required this.amount,
      required this.description,
      required this.id,
      String? date}) : date = date ?? Date.getDate();

  setId(int id) {
    this.id = id;
  }

  static getExpense() {
    double expense = 0;
    if (rowDataList.isEmpty) {
      return null;
    }
    for (var e in rowDataList) {
      if (!e.isIncome) {
        expense += e.amount;
      }
    }
    return expense.round();
  }

  static getIncome() {
    double income = 0;
    double expense = 0;
    if (rowDataList.isEmpty) {
      return null;
    }
    for (var e in rowDataList) {
      if (e.isIncome) {
        income += e.amount;
      } else {
        expense += e.amount;
      }
    }
    income -= expense;
    return income.round() < 0 ? 0 : income.round();
  }

  static List<RowData> getData() {
    return rowDataList;
  }
}

Map<int, String> dayConverter = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri",
  6: "Sat",
  7: "Sun",
};

Map<int, String> monthConverter = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "June",
  7: "July",
  8: "Aug",
  9: "Sept",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

class Date {
  static String getDate() {
    String s;
    DateTime t = DateTime.now();
    // day set
    s = "${dayConverter[t.weekday]!}, ";
    // day set
    s += "${t.day} ";
    // month and year set
    s += "${monthConverter[t.month]} ${t.year}";
    return s;
  }
}
