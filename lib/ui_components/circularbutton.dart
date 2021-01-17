import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double iconSize;
  // final Function onPressed;
  final VoidCallback onPressed;
  const CircularButton({
    @required this.icon,
    this.color: Colors.white,
    this.iconColor: Colors.blue,
    this.iconSize: 25.0,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
