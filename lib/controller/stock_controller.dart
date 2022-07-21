import 'package:atualiza_estoque/persistence/firestore_connection.dart';

import '../components/snackbar_alert.dart';
import '../model/stock.dart';
import '../persistence/stock_dao.dart';

class StockController {
  FireStoreController _fireStoreController = FireStoreController();
  Future<String> save(Stock stock) async {
    int res = 0;
    try {
      res = await StockDao.insert(stock);
    } catch (e) {
      res = 0;
    }
    if (res == 0) {
      return "Erro ao salvar/alterar registro";
    } else {
      return "Salvo com sucesso";
    }
  }

  Future<List<Stock>> findAll(String mode) async {
    List<Stock> items = await StockDao.findAll(mode);
    return items;
  }

  Future<bool> verifyId(String code) async {
    bool res = await StockDao.verifyId(code);
    return res;
  }

  Future<String> remove(String id) async {
    int res = 0;
    res = await StockDao.remove(id);
    if (res == 0) {
      return "Erro ao excluir registro";
    } else {
      return "Excluído com sucesso.";
    }
  }
}
