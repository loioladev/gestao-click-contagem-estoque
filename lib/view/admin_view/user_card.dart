import 'package:flutter/material.dart';

import '../../components/confirm_dialog.dart';
import '../../model/user.dart';

class UserCards extends StatefulWidget {
  final UserApp userUsed;
  final Function functionUsed;
  const UserCards(
      {Key? key, required this.userUsed, required this.functionUsed})
      : super(key: key);

  @override
  State<UserCards> createState() => _UserCardsState();
}

class _UserCardsState extends State<UserCards> {
  // Change icon according to the user's privilege
  IconData whichIcon(String type) {
    if (type == "admin") {
      return Icons.admin_panel_settings;
    }
    return Icons.person;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 10, 120, 167)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child:
                Icon(whichIcon(widget.userUsed.privilege), color: Colors.white),
          ),
          title: Text(
            widget.userUsed.email,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            onPressed: () {
              showConfirmDialog(
                  context,
                  "Deletar item",
                  "Você tem certeza em deletar o usuário ${widget.userUsed.email}?",
                  "Deletar",
                  "Cancelar", () {
                widget.functionUsed.call();
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
