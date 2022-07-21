import 'package:flutter/material.dart';

import '../../components/confirm_dialog.dart';
import '../../model/stock.dart';

class StockCardsFirebase extends StatefulWidget {
  final Stock stock;
  final Function functionToCall;
  const StockCardsFirebase(
      {Key? key, required this.stock, required this.functionToCall})
      : super(key: key);

  @override
  State<StockCardsFirebase> createState() => _StockCardsFirebaseState();
}

class _StockCardsFirebaseState extends State<StockCardsFirebase> {
  // Change icon of the stock
  IconData whichIcon(String type) {
    if (type == "alterar") {
      return Icons.edit;
    }
    return Icons.add;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 10, 120, 167)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(whichIcon(widget.stock.mode), color: Colors.white),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Código: " + widget.stock.code.toString()),
              Text("Nome: " + widget.stock.name),
              Text("Quantidade: " + widget.stock.quantity.toString()),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              showConfirmDialog(
                  context,
                  "Deletar item",
                  "Você tem certeza em deletar o item de código ${widget.stock.code}?",
                  "Deletar",
                  "Cancelar", () {
                widget.functionToCall.call();
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
  }
}
