import 'package:flutter/material.dart';

class DetailsSerial extends StatelessWidget {
  const DetailsSerial({Key? key, required this.serial}) : super(key: key);

  final String serial;
  final double fontSize = 20.0;
  final double titleFontSize = 24.0;
  final double padding = 8.0;
  final double minHeight = 80.0;
  final double maxHeight = 300.0;
  final double width = 360.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
          elevation: 2.0,
          child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Serial Number",
                    style: TextStyle(fontSize: titleFontSize),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(serial,
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
