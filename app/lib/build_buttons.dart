import 'package:flutter/material.dart';

class BuildButtons extends StatelessWidget {
  const BuildButtons({
    super.key,
    required this.color,
    required this.label,
    required this.onPressed,
    this.hover,
    this.shape,
  });

  final Color color;
  final String label;
  final VoidCallback? onPressed;
  final Color? hover;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      elevation: 1,
      padding: EdgeInsets.all(12),
      disabledColor: Colors.grey,
      shape: (shape == null) ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)) : shape,
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}