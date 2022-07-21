import 'package:atualiza_estoque/components/alert_dialog.dart';
import 'package:atualiza_estoque/components/snackbar_alert.dart';
import 'package:atualiza_estoque/controller/stock_controller.dart';
import 'package:atualiza_estoque/login/user_login.dart';
import 'package:atualiza_estoque/persistence/firestore_connection.dart';
import 'package:atualiza_estoque/view/stock_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/confirm_dialog.dart';
import '../login/login.dart';
import '../model/stock.dart';
import '../model/user.dart';
import 'admin_view/tabview.dart';
import 'home.dart';

class DefaultView extends StatefulWidget {
  const DefaultView({Key? key}) : super(key: key);

  @override
  State<DefaultView> createState() => _DefaultViewState();
}

class _DefaultViewState extends State<DefaultView> {
  // Create list of Widgets to be used in the
  // BottomNavigationBar
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    StockUpdate(
      mode: ("adicionar"),
    ),
    StockUpdate(mode: "alterar"),
    TabViewAdmin(),
  ];

  // Create the controllers for the view
  StockController _stockController = StockController();
  FireStoreController _fireStoreController = FireStoreController();

  // Send all stocks to the Admin
  _sendItems() async {
    List<Stock> tmp = await _stockController.findAll("adicionar") +
        await _stockController.findAll("alterar");

    for (Stock stock in tmp) {
      _fireStoreController.insert(stock);
      _deleteItem(stock.id);
    }
  }

  // Delete Stock from the list
  _deleteItem(String id) {
    setState(() {
      _stockController.remove(id);
    });
  }

  // Verify if the user has the privilege to access
  // some view.
  void _onItemTapped(int index) async {
    // Get email from the logged user
    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    if (userEmail == null) return;
    UserApp actualUser = UserApp(null, userEmail, "");

    // Verify if the user has privileges
    bool hasPrivilegeUser = await UserLogin().verifyUser(actualUser, "user");
    bool hasPrivilegeAdmin = await UserLogin().verifyUser(actualUser, "admin");

    // Verify if the user has the correct privilege
    if (hasPrivilegeAdmin) {
    } else if (!hasPrivilegeUser || (index == 3 && !hasPrivilegeAdmin)) {
      showAlertDialog(context, "Sem permissão",
          "Você não tem permissão para acessar esta seção.", "Voltar");
      return;
    }
    // Update page index
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showConfirmDialog(
                context,
                "Enviar estoque",
                "Você tem certeza de que deseja enviar o estoque atualizado?",
                "Enviar",
                "Cancelar",
                () {
                  _sendItems();
                  _onItemTapped(0);
                  snackBarAlert(context, "Itens enviados com sucesso.");
                },
              );
            },
            icon: const Icon(Icons.send_sharp),
            iconSize: 28.0,
            color: Colors.black,
            splashRadius: 28,
          ),
          IconButton(
            onPressed: () {
              showConfirmDialog(
                context,
                "Sair da conta",
                "Você tem certeza de que deseja sair de sua conta?",
                "Sair",
                "Cancelar",
                Login().signOut,
              );
            },
            icon: const Icon(Icons.logout_outlined),
            iconSize: 28.0,
            color: Colors.black,
            splashRadius: 28,
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 16,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Contagem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Admin',
          ),
        ],
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 72, 157, 227),
        onTap: _onItemTapped,
        iconSize: 28.0,
      ),
    );
  }
}
