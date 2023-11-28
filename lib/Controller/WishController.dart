import '../DataBase/DataBaseHelper.dart';
import '../Model/Wish.dart';

class WishController {
  static List<Wish> _buffer = [];

  static Future<void> fetchDataToBuffer() async {
    try {
      List<Map> response = await DataBaseHelper.read('''
        SELECT * FROM "Wish" ORDER BY id DESC;
      ''');

      _buffer = [];
      for (var element in response) {
        _buffer.add(Wish(name: element['name'], id: element['id']));
      }
    } catch (e) {
      rethrow;
    }
  }

  static addWish(String name) async {
    try {

      if (name.isEmpty || name == null) {
        throw 0;
      }
      Wish wish = Wish(
        name: name,
      );

      int id = await DataBaseHelper.insert('''
          INSERT INTO "Wish" ("name") VALUES("${wish.name}")
        ''');

      wish.id = id;
      _buffer.insert(0, wish);
    } catch (e) {
      rethrow;
    }
  }

  static removeExpenseAt(int index) {
    try {
      DataBaseHelper.delete('''
          DELETE FROM "Wish" WHERE id = ${_buffer[index].id}
        ''');
      _buffer.removeAt(index);
    } catch (e) {
      rethrow;
    }
  }

  static List<Wish> getBuffer() {
    return _buffer;
  }
}
