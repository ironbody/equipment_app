import 'package:flutter/material.dart';

class DetailsRentDuration extends StatelessWidget {
  const DetailsRentDuration({Key? key, required this.duration})
      : super(key: key);

  final int duration;
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
          child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Rent duration",
                    style: TextStyle(fontSize: titleFontSize),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text("${duration} days",
                      style: TextStyle(
                        fontSize: fontSize,
                      )),
                ],
              ))),
    );
  }
}
