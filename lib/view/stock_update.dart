import 'package:atualiza_estoque/components/elevatedbutton.dart';
import 'package:atualiza_estoque/components/snackbar_alert.dart';
import 'package:atualiza_estoque/components/stock_form.dart';
import 'package:atualiza_estoque/persistence/gestaoclick_connection.dart';
import 'package:atualiza_estoque/view/stock_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/stock_controller.dart';
import '../model/stock.dart';
import '../persistence/firestore_connection.dart';

class StockUpdate extends StatefulWidget {
  final String mode;
  const StockUpdate({Key? key, required this.mode}) : super(key: key);

  @override
  State<StockUpdate> createState() => _StockUpdateState();
}

class _StockUpdateState extends State<StockUpdate> {
  StockController _stockController = StockController();
  FireStoreController _fireStoreController = FireStoreController();
  GestaoClickConnection _gestaoController = GestaoClickConnection();

  TextEditingController codeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  TextInputType codeInputType = TextInputType.number;
  TextInputType qntInputType = TextInputType.number;

  bool _validateQnt = false;
  bool _validateCode = false;

  _cleanTextField() {
    codeController.text = "";
    quantityController.text = "";
  }

  _insertItem() async {
    // Get user email
    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    if (userEmail == null) return;

    // Get date and time of the addition
    DateTime now = DateTime.now();
    String dateNow = DateFormat('yyyy/MM/dd kk:mm').format(now);

    // Create new stock
    Stock stock = Stock(
        "id_temporario",
        "nome_temporario",
        int.parse(codeController.text),
        int.parse(quantityController.text),
        widget.mode.toString(),
        userEmail,
        dateNow);

    if (await _verifyDuplicate(stock)) {
      snackBarAlert(context, "Produto duplicado não inserido");
      return;
    }
    String aux = await _gestaoController.getItemId(stock.code.toString());
    if (aux == "error") {
      snackBarAlert(context, "Produto não encontrado");
      return;
    }
    stock.id = aux;
    stock.name = await _gestaoController.getItemName(aux);
    setState(() {
      // adicionar snack bar aqui
      _stockController.save(stock);
      snackBarAlert(context, "Adicionado com sucesso");
    });
  }

  Future<bool> _verifyDuplicate(Stock stock) async {
    bool aux = await _stockController.verifyId(stock.code.toString());
    bool resFirebase = await _fireStoreController.getId(stock.code);
    return (aux || resFirebase);
  }

  bool _verifyItem() {
    setState(() {
      codeController.text.isEmpty
          ? _validateCode = true
          : _validateCode = false;
      quantityController.text.isEmpty
          ? _validateQnt = true
          : _validateQnt = false;

      try {
        int aux = int.parse(quantityController.text);
        if (aux <= 0) _validateQnt = true;
      } catch (e) {
        _validateQnt = true;
      }
      try {
        int.parse(codeController.text);
      } catch (e) {
        _validateCode = true;
      }
    });

    return (_validateCode || _validateQnt);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Abaixo, adicione as informações do produto para "
              "${widget.mode} estoque.",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          createStockForm("Código do produto", codeController, codeInputType,
              _validateCode),
          createStockForm("Quantidade do produto", quantityController,
              qntInputType, _validateQnt),
          CreateElevatedButton(
            functionToCall: () {
              setState(() {
                if (_verifyItem()) return;
                _insertItem();
                _cleanTextField();
              });
            },
            textButton: "Inserir",
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Lista do estoque a ${widget.mode}.",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          StockCards(
            mode: widget.mode,
          ),
        ],
      ),
    );
  }
}
