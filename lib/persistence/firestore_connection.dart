import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/stock.dart';

class FireStoreController {
  // Initialize firebase connection
  final databaseReference = FirebaseFirestore.instance;
  final String COLLECTION = "stock";
  final String LOGCOLLECTION = "log";

  // Insert stock in the database
  Future<String> insert(Stock stock) async {
    try {
      await databaseReference.collection(COLLECTION).doc(stock.id).set({
        'code': stock.code,
        'name': stock.name,
        'quantity': stock.quantity,
        'mode': stock.mode,
        'email': stock.email,
        'datetime': stock.datetime
      });

      return insertLog(stock);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> insertLog(Stock stock) async {
    try {
      await databaseReference.collection(LOGCOLLECTION).add(stock.toMap());
      return "Done";
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> getId(int code) async {
    List<Stock> listStock = [];
    QuerySnapshot stocks = await databaseReference
        .collection(COLLECTION)
        .where("code", isEqualTo: code)
        .get();
    for (var element in stocks.docs) {
      listStock.add(
          Stock.fromJson(element.data() as Map<String, dynamic>, element.id));
    }
    return listStock.isNotEmpty;
  }

  // Get all stocks from database
  Future<List<Stock>> getStock() async {
    List<Stock> listStock = [];
    QuerySnapshot stocks = await databaseReference.collection(COLLECTION).get();
    for (var element in stocks.docs) {
      listStock.add(
          Stock.fromJson(element.data() as Map<String, dynamic>, element.id));
    }
    return listStock;
  }

  // Remove stock from database by ther id
  Future<String> removeStock(String id) async {
    try {
      await databaseReference.collection(COLLECTION).doc(id).delete();
      return "Produto excluído com sucesso";
    } catch (e) {
      return e.toString();
    }
  }
}
