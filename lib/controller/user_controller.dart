import 'package:atualiza_estoque/model/stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserController {
  final databaseReference = FirebaseFirestore.instance;
  final String LOGCOLLECTION = "log";
  final String COLLECTION = "users";

  Future<List<UserApp>> findAll(String privilege) async {
    List<UserApp> users = [];
    QuerySnapshot info = await databaseReference
        .collection(COLLECTION)
        .where("privilege", isEqualTo: privilege)
        .get();
    for (var element in info.docs) {
      users.add(
          UserApp.fromJson(element.data() as Map<String, dynamic>, element.id));
    }
    return users;
  }

  Future<List<String>> getDates(String email) async {
    List<Stock> stocks = [];
    QuerySnapshot info = await databaseReference
        .collection(LOGCOLLECTION)
        .where("email", isEqualTo: email)
        .get();
    for (var element in info.docs) {
      stocks.add(
          Stock.fromJson(element.data() as Map<String, dynamic>, element.id));
    }
    List<String> dates = [];
    for (Stock stock in stocks) {
      dates.add(stock.datetime.substring(0, 10));
    }
    var seen = Set<String>();
    List<String> uniquelist =
        dates.where((country) => seen.add(country)).toList();
    return uniquelist;
  }

  Future<List<Stock>> getStocksByDate(String email, String date) async {
    List<Stock> listStock = [];
    QuerySnapshot info = await databaseReference
        .collection(LOGCOLLECTION)
        .where("email", isEqualTo: email)
        .where("datetime", isGreaterThan: date + " 00:00:00")
        .where("datetime", isLessThan: date + " 23:59:59")
        .get();
    for (var element in info.docs) {
      listStock.add(
          Stock.fromJson(element.data() as Map<String, dynamic>, element.id));
    }
    return listStock;
  }
}
