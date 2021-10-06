import 'package:flutter/material.dart';

class DetailIcon extends StatelessWidget {
  const DetailIcon({Key? key, required this.detailIcon}) : super(key: key);

  final IconData detailIcon;
  final double size = 100.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(detailIcon,
            size: size, color: Theme.of(context).primaryColor));
  }
}
