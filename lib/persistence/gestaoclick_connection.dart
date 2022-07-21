import 'dart:convert';
import 'package:atualiza_estoque/persistence/headers.dart';
import 'package:http/http.dart' as http;

import '../model/stock.dart';

Future<String> getId(String code) async {
  final response = await http.get(
      Uri.parse(
          "https://api.gestaoclick.com/produtos/?codigo=$code&loja_id=120915"),
      headers: getHeadersAPI());
  final responseJson = jsonDecode(response.body);
  if (responseJson['code'] != 200) return (responseJson['status']);
  if (responseJson['meta']['total_registros'] == null) {
    return "Produto não cadastrado";
  }
  return responseJson['data'][0]['id'];
}

Future<Map<String, dynamic>> getInfo(Stock stock) async {
  final response = await http.get(
      Uri.parse(
          "https://api.gestaoclick.com/produtos/${stock.id}?loja_id=120915"),
      headers: getHeadersAPI());
  final responseJson = jsonDecode(response.body);

  Map<String, dynamic> res = {};
  res['nome'] = responseJson['data']['nome'];
  res['codigo_interno'] = stock.code;
  res['valor_custo'] = responseJson['data']['valor_custo'];
  res['valor_venda'] = responseJson['data']['valor_venda'];
  if (stock.mode == "alterar") {
    res['estoque'] = stock.quantity;
  } else {
    res['estoque'] = responseJson['data']['estoque'] + stock.quantity;
  }
  return res;
}

class GestaoClickConnection {
  Future<String> getItemId(String code) async {
    String res = await getId(code);
    try {
      int.parse(res);
    } catch (e) {
      return "error";
    }
    return res;
  }

  Future<String> getItemName(String id) async {
    final response = await http.get(
        Uri.parse("https://api.gestaoclick.com/produtos/$id?loja_id=120915"),
        headers: getHeadersAPI());
    final responseJson = jsonDecode(response.body);
    return responseJson['data']['nome'];
  }

  Future<String> updateItem(Stock stock) async {
    Map<String, dynamic> information = await getInfo(stock);
    final response = await http.put(
        Uri.parse(
            "https://api.gestaoclick.com/produtos/${stock.id}?loja_id=120915"),
        headers: getHeadersAPI(),
        body: jsonEncode(information));
    return response.toString();
  }
}
