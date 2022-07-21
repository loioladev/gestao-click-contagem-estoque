import 'package:atualiza_estoque/components/listtile_builder.dart';
import 'package:atualiza_estoque/components/loading_items.dart';
import 'package:atualiza_estoque/controller/user_controller.dart';
import 'package:atualiza_estoque/model/user.dart';
import 'package:atualiza_estoque/view/admin_view/log_date.dart';
import 'package:flutter/material.dart';

class AdminLog extends StatefulWidget {
  const AdminLog({Key? key}) : super(key: key);

  @override
  State<AdminLog> createState() => _AdminLogState();
}

class _AdminLogState extends State<AdminLog> {
  UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(4)),
          FutureBuilder<List<UserApp>>(
            initialData: [],
            future: _userController.findAll("user"),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return loadingScreen();
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  final List<UserApp> items = snapshot.data!;
                  items.sort(
                      ((a, b) => a.email.length.compareTo(b.email.length)));
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final UserApp user = items[index];
                      return ListTileBuilder(
                        iconUsed: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        textUsed: user.email,
                        functionUsed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      LogDate(email: user.email))));
                        },
                      );
                    },
                    itemCount: items.length,
                  );
              }
              return const Text("Erro");
            },
          )
        ],
      ),
    );
  }
}
