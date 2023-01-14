

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDialog extends StatelessWidget {

  final Function()? onpressed;
  final CircleAvatar circleAvatar;
  final String title;
  final String description;

  CustomDialog({
    Key? key, this.onpressed, required this.circleAvatar,required this.title,required this.description
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 5,),
                  description.text.size(20).center.make(),
                  SizedBox(height: 15,),
                  ElevatedButton(onPressed:onpressed ,
                    child: Text('Okay', style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: circleAvatar,
            )
        ],
      )
    );
  }
}
