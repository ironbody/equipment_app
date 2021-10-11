import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: const Text(
          "EDIT",
        ),
        style: OutlinedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        )
    );
  }
}
