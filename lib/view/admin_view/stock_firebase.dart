import 'package:flutter/material.dart';

import '../../components/loading_items.dart';
import '../../components/snackbar_alert.dart';
import '../../model/stock.dart';
import '../../persistence/firestore_connection.dart';
import 'stock_card.dart';

class StockFirebase extends StatefulWidget {
  const StockFirebase({Key? key}) : super(key: key);

  @override
  State<StockFirebase> createState() => _StockFirebaseState();
}

class _StockFirebaseState extends State<StockFirebase> {
  // Delete item from FireStore
  _deleteItem(String id) async {
    String ans = await FireStoreController().removeStock(id);
    setState(() {
      snackBarAlert(context, ans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<List<Stock>>(
      initialData: [],
      future: FireStoreController().getStock(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return loadingScreen();

          case ConnectionState.active:
            break;
          case ConnectionState.done:
            final List<Stock> items = snapshot.data!;
            items.sort(((a, b) => a.mode.compareTo(b.mode)));
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Stock newStock = items[index];
                return StockCardsFirebase(
                    stock: newStock,
                    functionToCall: () {
                      _deleteItem(newStock.id);
                    });
              },
              itemCount: items.length,
            );
        }
        return const Text("Erro");
      },
    ));
  }
}
