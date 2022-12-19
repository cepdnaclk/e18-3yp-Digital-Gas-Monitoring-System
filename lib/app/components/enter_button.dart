import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EnterButton extends StatelessWidget {
  EnterButton({required this.text, required this.textColour, required this.buttonColour, required this.onPressed});

  String text;
  Color buttonColour;
  Color textColour;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: buttonColour,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),

      ),
    );
    return Container(
        height: 40,
        constraints: const BoxConstraints(
            maxWidth: 500
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ElevatedButton(
          style: raisedButtonStyle,
          onPressed: () {onPressed();},
          child: Text(text,style: TextStyle(color: textColour),),
        )
    );
  }
}

