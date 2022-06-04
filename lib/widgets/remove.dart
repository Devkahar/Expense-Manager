import 'package:flutter/material.dart';

class RemoveItem extends StatelessWidget {
  const RemoveItem({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.remove_circle_outline,
        color: Colors.red,
      ),
    );
  }
}
