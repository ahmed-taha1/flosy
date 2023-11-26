import 'package:intl/intl.dart';

class Date{
  late String date;
  Date(){
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy/MM/dd');
    date = dateFormat.format(now);
  }

  @override
  String toString() {
    return date;
  }
}