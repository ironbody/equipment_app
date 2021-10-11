import 'package:flutter/material.dart';

class RentButton extends StatelessWidget {
  const RentButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          "RENT",
          // style: TextStyle(color: Theme.of(context).primaryColor),
        ),

        );
  }
}
