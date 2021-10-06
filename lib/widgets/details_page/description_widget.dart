import 'package:flutter/material.dart';

class DetailsDescription extends StatelessWidget {
  const DetailsDescription({Key? key, required this.description})
      : super(key: key);

  final String description;
  final double fontSize = 20.0;
  final double padding = 30.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          description,
          style: TextStyle(fontSize: fontSize,),
        ),
      ),
    );
  }
}
