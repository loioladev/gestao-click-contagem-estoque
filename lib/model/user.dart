import 'dart:math';

class UserApp {
  String? _id;
  String _email;
  String _privilege;

  UserApp(this._id, this._email, this._privilege);

  String get id => _id!;
  String get email => _email;
  String get privilege => _privilege;

  Map<String, dynamic> toMap() => {
        "email": _email,
        "privilege": _privilege,
      };

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  @override
  String toString() {
    return "$_email" + " $_privilege";
  }

  Map getUser() {
    Map<String, dynamic> userValues = Map();
    if (_id == null || _id == "") {
      _id = String.fromCharCodes(Iterable.generate(
          8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    }
    userValues["_id"] = _id;
    userValues["email"] = _email;
    userValues["privilege"] = _privilege;
    return userValues;
  }

  UserApp.fromJson(Map<String, dynamic> json, String id_firebase)
      : _email = json["email"],
        _privilege = json["privilege"],
        _id = id_firebase;
}
