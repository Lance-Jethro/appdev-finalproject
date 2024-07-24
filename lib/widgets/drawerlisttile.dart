import 'package:flutter/material.dart';

class MyDrawerListTile extends StatelessWidget {
  const MyDrawerListTile({
    Key? key,
    required this.leading,
    required this.text,
    required this.onTapCallback,
    this.color = Colors.white,
  }) : super(key: key);

  final IconData leading;
  final String text;
  final VoidCallback onTapCallback;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      tileColor: color,
      onTap: onTapCallback,
    );
  }
}
