import 'package:atualiza_estoque/components/confirm_dialog.dart';
import 'package:flutter/material.dart';

import '../../components/snackbar_alert.dart';
import '../../model/stock.dart';
import '../../persistence/firestore_connection.dart';
import '../../persistence/gestaoclick_connection.dart';
import 'stock_firebase.dart';

class AdminStock extends StatefulWidget {
  const AdminStock({Key? key}) : super(key: key);

  @override
  State<AdminStock> createState() => _AdminStockState();
}

class _AdminStockState extends State<AdminStock> {
  // Create controllers to make the connection with Firebase
  // and the API
  FireStoreController _fireStoreController = FireStoreController();
  GestaoClickConnection _gestaoController = GestaoClickConnection();
  // Save all itens which are waiting for approval
  _saveAll() async {
    // Get all registered updates
    List<Stock> getStocks = await _fireStoreController.getStock();
    // For each stock, save it in the API and remove it from the
    // Firestore
    for (Stock stock in getStocks) {
      _gestaoController.updateItem(stock);
      setState(() {
        _fireStoreController.removeStock(stock.id);
      });
    }
    snackBarAlert(context, "Produtos atualizados com sucesso");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Estoques a serem aprovados",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        showConfirmDialog(
                            context,
                            "Aprovar Estoque",
                            "Você tem certeza de que deseja aprovar o estoque atual?",
                            "Aprovar",
                            "Cancelar", () {
                          _saveAll();
                        });
                      },
                      icon: const Icon(Icons.browser_updated_rounded)),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            StockFirebase(),
          ],
        ),
      ),
    );
  }
}
