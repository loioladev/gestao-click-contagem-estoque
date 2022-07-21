import 'package:flutter/material.dart';

import '../../components/loading_items.dart';
import '../../controller/user_controller.dart';
import '../../model/stock.dart';

class LogStock extends StatefulWidget {
  final String date;
  final String email;
  const LogStock({Key? key, required this.email, required this.date})
      : super(key: key);

  @override
  State<LogStock> createState() => _LogStockState();
}

class _LogStockState extends State<LogStock> {
  UserController _userController = UserController();

  // Change icon of the stock
  Icon whichIcon(String type) {
    IconData aux;
    if (type == "alterar") {
      aux = Icons.edit;
    } else {
      aux = Icons.add;
    }
    return Icon(
      aux,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ]),
        body: Column(
          children: [
            FutureBuilder<List<Stock>>(
              initialData: [],
              future:
                  _userController.getStocksByDate(widget.email, widget.date),
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
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final Stock stock = items[index];
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 10, 120, 167)),
                              child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      stock.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  trailing: whichIcon(stock.mode)),
                            ),
                          );
                        },
                        itemCount: items.length,
                      ),
                    );
                }
                return const Text("Erro");
              },
            )
          ],
        ));
  }
}
