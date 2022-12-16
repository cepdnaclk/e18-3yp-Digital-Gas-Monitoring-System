import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.onPressed,
        required this.colour,
        required this.title,
        required this.buttonTextColour});
  final Function onPressed;
  final String title;
  final Color colour;
  final Color buttonTextColour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          minWidth: 200.0,
          height: 45.0,
          child: Text(
            title,
            style: TextStyle(
              color: buttonTextColour,
            ),
          ),
        ),
      ),
    );
  }
}
