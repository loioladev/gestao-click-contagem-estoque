import 'dart:math';

class Stock {
  String? _id;
  String _name;
  int _quantity;
  int _code;
  String _mode;
  String _email;
  String _datetime;

  Stock(this._id, this._name, this._code, this._quantity, this._mode,
      this._email, this._datetime);

  String get id => _id!;

  String get name => _name;

  int get code => _code;

  int get quantity => _quantity;

  String get mode => _mode;

  String get datetime => _datetime;

  String get email => _email;

  set id(String newId) {
    _id = newId;
  }

  set name(String newName) {
    _name = newName;
  }

  Map<String, dynamic> toMap() => {
        "code": _code,
        "name": _name,
        "quantity": _quantity,
        "mode": _mode,
        "email": _email,
        "datetime": _datetime,
      };

  Map getStock() {
    Map<String, dynamic> stockValues = Map();
    stockValues["_id"] = _id;
    stockValues["name"] = _name;
    stockValues["code"] = _code;
    stockValues["quantity"] = _quantity;
    stockValues["mode"] = _mode;
    stockValues["email"] = _email;
    stockValues["datetime"] = _datetime;
    return stockValues;
  }

  @override
  String toString() {
    return "Nome: $_name\nCódigo: $_code\nQuantidade: $_quantity\nHoras: $_datetime";
  }

  Stock.fromJson(Map<String, dynamic> json, String id_firebase)
      : _code = json["code"],
        _name = json["name"],
        _quantity = json["quantity"],
        _mode = json["mode"],
        _email = json["email"],
        _datetime = json["datetime"],
        _id = id_firebase;
}
