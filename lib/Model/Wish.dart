class Wish{
  late String _name;
  late int _id;

  Wish({name, id}){
    this._name = name;
    if(id != null) {
      this._id = id;
    }
  }

  set id(int value) {
    _id = value;
  }

  int get id => _id;

  String get name => _name;
}