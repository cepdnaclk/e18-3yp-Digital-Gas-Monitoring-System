import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  InputTextField({required this.color, required this.hint});
  TextEditingController phoneController = TextEditingController();
  Color color;
  String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      constraints: const BoxConstraints(
          maxWidth: 500
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CupertinoTextField(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration:  BoxDecoration(

            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Colors.grey)

        ),
        controller: phoneController,
        clearButtonMode: OverlayVisibilityMode.editing,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        placeholder: hint,
      ),
    );
  }
}
