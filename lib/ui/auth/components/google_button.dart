import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({required this.function, required this.text, super.key});

  final void Function()? function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage("assets/google.png"),
              width: 40,
              height: 40,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
