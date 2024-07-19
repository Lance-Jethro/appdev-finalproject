import 'package:flutter/material.dart';

class PizzaCircle extends StatelessWidget {
  const PizzaCircle({
    super.key,
    required this.url,
    this.size = 150,
  });

  final String url;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(url),
        ),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
    );
  }
}
