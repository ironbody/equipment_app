import 'package:flutter/material.dart';

class DetailStatus extends StatelessWidget {
  const DetailStatus({Key? key, required this.available}) : super(key: key);

  final bool? available;
  final double fontSize = 20.0;
  final double titleFontSize = 24.0;
  final double padding = 8.0;
  final double minHeight = 80.0;
  final double maxHeight = 300.0;
  final double width = 360.0;

  @override
  Widget build(BuildContext context) {
    // var _textWidget = Text("Status unknown", style:TextStyle(fontSize: fontSize));

    var _textWidget = Text(
      "Available!",
      style: TextStyle(color: Colors.greenAccent, fontSize: fontSize),
    );

    switch (available) {
      case true:
        _textWidget = Text(
          "Available!",
          style: TextStyle(color: Colors.greenAccent, fontSize: fontSize),
        );
        break;
      case false:
        _textWidget = Text(
          "Unavailable",
          style: TextStyle(color: Colors.redAccent, fontSize: fontSize),
        );
        break;
      default:
    }

    return SizedBox(
      width: width,
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(fontSize: titleFontSize),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  _textWidget,
                ],
              ))),
    );
  }
}
