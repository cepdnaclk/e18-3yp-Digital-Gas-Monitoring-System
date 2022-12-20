import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  HomeContainer({required this.image, required this.text, required this.onTap});

  Image image;
  String text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        onTap();
      },
      // The custom button
      child: Padding(
        padding:
            const EdgeInsets.only(right: 30, left: 30, top: 20, bottom: 20),
        child: Container(
            width: width,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.cyan,
                    Colors.green,
                  ],
                )),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 120,
                    width: 120,
                    constraints: const BoxConstraints(maxHeight: 340),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40), child: image
                        // margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
