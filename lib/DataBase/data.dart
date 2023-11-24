import 'package:untitled1/DataBase/DataBaseHelper.dart';
import 'package:untitled1/Model/Expense.dart';

class YourDataHandler {
  static Future<void> getDataAndStoreInArray() async {
    rowDataList = await DataBaseHelper.read();
  }
}

List<RowData> rowDataList = [];