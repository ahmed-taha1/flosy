import 'package:untitled1/dataBase.dart';
import 'package:untitled1/model.dart';

class YourDataHandler {
  static Future<void> getDataAndStoreInArray() async {
    rowDataList = await DataBase.readData();
  }
}

List<RowData> rowDataList = [];