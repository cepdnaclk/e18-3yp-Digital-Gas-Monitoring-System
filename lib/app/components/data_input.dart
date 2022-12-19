import 'package:flutter/material.dart';

class DataInput extends StatelessWidget {
  const DataInput({Key? key, required this.title, required this.hint}) : super(key: key);
  final String title;
  final String hint;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 15.0, color: Colors.black54),
        ),
        SizedBox(
          height: 3,
        ),
        SizedBox(
          width: 300,
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),

            textAlign: TextAlign.start,
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hint,
              hintStyle:
              TextStyle(fontSize: 15, color: Colors.black26),
            ),
          ),
        ),
      ],
    );
  }
}


