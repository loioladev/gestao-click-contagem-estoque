import 'package:atualiza_estoque/components/listtile_builder.dart';
import 'package:flutter/material.dart';

import '../../components/loading_items.dart';
import '../../controller/user_controller.dart';
import 'log_stock.dart';

class LogDate extends StatefulWidget {
  final String email;
  const LogDate({Key? key, required this.email}) : super(key: key);

  @override
  State<LogDate> createState() => _LogDateState();
}

class _LogDateState extends State<LogDate> {
  UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Escolha a data do log"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ]),
        body: Column(
          children: [
            FutureBuilder<List<String>>(
              initialData: [],
              future: _userController.getDates(widget.email),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return loadingScreen();
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    final List<String> items = snapshot.data!;
                    items.sort(((a, b) => a.compareTo(b)));
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final String date = items[index];
                        return ListTileBuilder(
                          iconUsed: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          textUsed: date,
                          functionUsed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LogStock(
                                        email: widget.email, date: date))));
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
        ));
  }
}
