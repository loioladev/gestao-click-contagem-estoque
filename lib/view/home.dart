import 'package:flutter/material.dart';

Widget createListTile(String text, IconData newIcon) {
  return ListTile(
    leading: Container(
      padding: const EdgeInsets.only(right: 12.0),
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.black))),
      child: Icon(
        newIcon,
        color: Colors.black,
      ),
    ),
    title: Text(
      text,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.justify,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Estoque Vipoint",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.justify,
        ),
        createListTile(
            "Seção de acréscimo de estoque. Para adicionar mais "
            "estoque em um produto, vá para a seção que possui o icone ao lado.",
            Icons.library_add),
        createListTile(
            "Seção de contagem de estoque. Para alterar o valor"
            "do estoque de algum produto, vá para a seção que possui o icone "
            "ao lado.",
            Icons.edit),
        createListTile(
            "Seção disponível apenas para os administradores.", Icons.person),
        createListTile(
            "Após realizar a contagem de estoque, clique no "
            "icone igual ao visto na esquerda para enviar o estoque para "
            "aprovação.",
            Icons.send_sharp),
        createListTile(
            "Para sair de sua conta do Google, basta clicar no "
            "icone igual ao visto na esquerda.",
            Icons.logout_outlined),
        createListTile(
            "Caso não tenha acesso as páginas seguintes, "
            "entre em contato com algum administrador para que o acesso"
            " seja concedido.",
            Icons.question_mark),
      ],
    );
  }
}
