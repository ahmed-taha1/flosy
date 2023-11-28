import 'package:intl/intl.dart';

class Date{
  late String date;

  Date({String? date}){
    if(date != null && date.isNotEmpty){
      this.date = date;
      return;
    }
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy/MM/dd');
    this.date = dateFormat.format(now);
  }


  @override
  String toString() {
    return date;
  }
}