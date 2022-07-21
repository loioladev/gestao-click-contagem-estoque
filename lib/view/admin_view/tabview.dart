import 'package:flutter/material.dart';

import 'stock.dart';
import 'user.dart';
import 'log.dart';

class TabViewAdmin extends StatefulWidget {
  const TabViewAdmin({Key? key}) : super(key: key);

  @override
  State<TabViewAdmin> createState() => _TabViewAdminState();
}

class _TabViewAdminState extends State<TabViewAdmin> {
  // Create list of tabs for the
  // TabView widget
  List<Tab> tabs = <Tab>[
    const Tab(text: "Estoque"),
    const Tab(text: "Usuários"),
    const Tab(text: "Log do sistema"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.black,
          tabs: tabs,
          indicatorColor: Colors.black,
        ),
        body: const TabBarView(
          children: <Widget>[
            AdminStock(),
            AdminUser(),
            AdminLog(),
          ],
        ),
      ),
    );
  }
}
