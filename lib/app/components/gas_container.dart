import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GasContainer extends StatelessWidget {
  GasContainer({required this.width, required this.widget, required this.text});

  double? width;
  Widget widget;
  String text;


  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20,),

        child: Container(
            width: width,

            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(children: [
              Align(
                alignment: Alignment.center,
                child:Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: widget
                ),
              ),
               Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only( bottom: 20.0,top: 20),
                  child: Text(text,textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,

                  ),),
                ),
              )
            ],)
        ),
      ),
    );
  }
}


