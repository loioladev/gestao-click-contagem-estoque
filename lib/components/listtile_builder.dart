import 'package:flutter/material.dart';

class ListTileBuilder extends StatefulWidget {
  final Icon iconUsed;
  final String textUsed;
  final Function functionUsed;
  const ListTileBuilder(
      {Key? key,
      required this.iconUsed,
      required this.textUsed,
      required this.functionUsed})
      : super(key: key);

  @override
  State<ListTileBuilder> createState() => _ListTileBuilderState();
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 10, 120, 167)),
        child: ListTile(
            title: Text(
              widget.textUsed,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              widget.functionUsed.call();
            },
            trailing: widget.iconUsed),
      ),
    );
  }
}
