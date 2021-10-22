import 'package:flutter/material.dart';

class DetailsDescription extends StatelessWidget {
  const DetailsDescription({Key? key, required this.description})
      : super(key: key);

  final String description;
  final double fontSize = 20.0;
  final double titleFontSize = 24.0;
  final double padding = 8.0;
  final double minHeight = 80.0;
  final double maxHeight = 312.0;
  final double width = 360.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight,
        maxHeight: maxHeight,
        minWidth: width,
        maxWidth: width,
      ),
      child: Card(
          elevation: 2.0,
          child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(fontSize: titleFontSize),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(description,
                  //       style: TextStyle(
                  //         fontSize: fontSize,
                  //       )),
                  // ),
                  Text(description,
                      style: TextStyle(
                        fontSize: fontSize,
                      )),
                ],
              ))),
    );
    // return SizedBox(
    //   height: height,
    //   child: Padding(
    //     padding: EdgeInsets.all(padding),
    //     child: Expanded(
    //         child: SingleChildScrollView(
    //             child: Text(description,
    //                 style: TextStyle(
    //                   fontSize: fontSize,
    //                 )))),
    //   ),
    // );
  }
}
