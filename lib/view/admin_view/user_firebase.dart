import 'package:atualiza_estoque/components/loading_items.dart';
import 'package:atualiza_estoque/components/snackbar_alert.dart';
import 'package:atualiza_estoque/login/user_login.dart';
import 'package:atualiza_estoque/model/user.dart';
import 'package:atualiza_estoque/view/admin_view/user_card.dart';

import 'package:flutter/material.dart';

class UserFirebase extends StatefulWidget {
  const UserFirebase({Key? key}) : super(key: key);

  @override
  State<UserFirebase> createState() => _UserFirebaseState();
}

class _UserFirebaseState extends State<UserFirebase> {
  // Delete user from Firebase
  _deleteItem(String id) async {
    String ref = await UserLogin().removeUser(id);
    setState(() {
      snackBarAlert(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<List<UserApp>>(
      initialData: const [],
      future: UserLogin().findAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return loadingScreen();
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            final List<UserApp> users = snapshot.data!;
            users.sort(((a, b) => a.privilege.compareTo(b.privilege)));
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final UserApp user = users[index];
                return UserCards(
                  functionUsed: () {
                    _deleteItem(user.id);
                  },
                  userUsed: user,
                );
              },
              itemCount: users.length,
            );
        }
        return const Text("Erro");
      },
    ));
  }
}
