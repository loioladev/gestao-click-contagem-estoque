import 'package:atualiza_estoque/components/elevatedbutton.dart';
import 'package:flutter/material.dart';

import '../../components/snackbar_alert.dart';
import '../../components/stock_form.dart';
import '../../controller/stock_controller.dart';
import '../../login/user_login.dart';
import '../../model/user.dart';
import '../../persistence/firestore_connection.dart';
import 'user_firebase.dart';

class AdminUser extends StatefulWidget {
  const AdminUser({Key? key}) : super(key: key);

  @override
  State<AdminUser> createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  // Create controllers for connection with Firebase
  StockController _stockController = StockController();
  FireStoreController _fireStoreController = FireStoreController();

  // Create controllers for the validation of forms
  TextEditingController userController = TextEditingController();
  TextInputType userInputType = TextInputType.text;
  bool _validateUser = false;

  // Auxiliar string to use in DropDownButton
  String privilege = "user";

  // Verify if the form is correct
  bool _verifyItem(BuildContext context) {
    setState(() {
      userController.text.isEmpty
          ? _validateUser = true
          : _validateUser = false;
    });
    return _validateUser;
  }

  // insert user in database
  _insertUser(BuildContext context) async {
    UserApp user = UserApp(null, userController.text, privilege);
    String ref = await UserLogin().addUser(user);
    setState(() {
      snackBarAlert(context, ref);
    });
  }

  // Clear text in form
  _cleanTextField() {
    setState(() {
      userController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Flexible(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: createStockForm(
                      "Email", userController, userInputType, _validateUser),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(8.0),
                  value: privilege,
                  elevation: 8,
                  style: const TextStyle(color: Color(0xFF2F6F8A)),
                  underline: Container(
                    height: 2,
                    color: const Color(0xFF2F6F8A),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      privilege = newValue!;
                    });
                  },
                  items: <String>["user", "admin"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CreateElevatedButton(
              functionToCall: () {
                setState(() {
                  if (_verifyItem(context)) return;
                  _insertUser(context);
                  _cleanTextField();
                });
              },
              textButton: "Inserir"),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Usuários cadastrados",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          )
        ]),
        // ignore: prefer_const_constructors
        UserFirebase(),
      ]),
    );
  }
}
