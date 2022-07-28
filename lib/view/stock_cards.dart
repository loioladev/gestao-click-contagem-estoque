import 'package:atualiza_estoque/components/loading_items.dart';
import 'package:atualiza_estoque/components/snackbar_alert.dart';
import 'package:atualiza_estoque/controller/stock_controller.dart';
import 'package:flutter/material.dart';

import '../components/confirm_dialog.dart';
import '../model/stock.dart';

class StockCards extends StatefulWidget {
  final String mode;
  const StockCards({Key? key, required this.mode}) : super(key: key);

  @override
  State<StockCards> createState() => _StockCardsState();
}

class _StockCardsState extends State<StockCards> {
  StockController _stockController = StockController();

  _deleteItem(String id) async {
    String aux = await _stockController.remove(id);
    setState(() {
      snackBarAlert(context, aux);
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<List<Stock>>(
      initialData: [],
      future: _stockController.findAll(widget.mode),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return loadingScreen();

          case ConnectionState.active:
            break;
          case ConnectionState.done:
            final List<Stock> aux = snapshot.data!;
            final List<Stock> items = aux.reversed.toList();
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Stock stock = items[index];
                return Card(
                  elevation: 8.0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 10, 120, 167)),
                    child: ListTile(
                      title: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nome: " + stock.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Código: " + stock.code.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Quantidade: " + stock.quantity.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                      trailing: IconButton(
                        onPressed: () {
                          showConfirmDialog(
                              context,
                              "Deletar item",
                              "Você tem certeza em deletar o item de código ${stock.code}?",
                              "Deletar",
                              "Cancelar", () {
                            _deleteItem(stock.id);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: items.length,
            );
        }
        return const Text("Erro");
      },
    ));
  }
}
