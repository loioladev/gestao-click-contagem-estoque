import 'package:flutter/material.dart';

class CreateElevatedButton extends StatefulWidget {
  final String textButton;
  final Function functionToCall;
  const CreateElevatedButton(
      {Key? key, required this.functionToCall, required this.textButton})
      : super(key: key);

  @override
  State<CreateElevatedButton> createState() => _CreateElevatedButtonState();
}

class _CreateElevatedButtonState extends State<CreateElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          widget.functionToCall.call();
        },
        child: Text(
          widget.textButton,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          onSurface: Colors.white,
          primary: const Color(0xFF2F6F8A),
        ),
      ),
    );
  }
}
