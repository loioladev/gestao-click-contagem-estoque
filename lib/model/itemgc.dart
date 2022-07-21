import 'dart:ffi';

class ItemGC {
  String _name;
  String _code;
  Float _costValue;
  Float _sellValue;

  ItemGC(this._name, this._code, this._costValue, this._sellValue);

  String get name => _name;
  String get code => _code;

  Float get costValue => _costValue;

  Float get sellValue => _sellValue;

  Map<String, dynamic> toMap() => {
        "name": _name,
        "code": _code,
        "costValue": _costValue,
        "sellValue": _sellValue,
      };

  Map getItem() {
    Map<String, dynamic> itemValues = Map();
    itemValues["name"] = _name;
    itemValues["code"] = _code;
    itemValues["costValue"] = _costValue;
    itemValues["sellValue"] = _sellValue;
    return itemValues;
  }

  ItemGC.fromJson(Map<String, dynamic> json)
      : _code = json["codigo_interno"],
        _name = json["nome"],
        _sellValue = json["valor_venda"],
        _costValue = json["valor_custo"];
}
