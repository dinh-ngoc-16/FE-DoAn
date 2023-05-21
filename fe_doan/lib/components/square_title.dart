import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final double size;
  final double circular;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.size,
    required this.circular,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.transparent),
      //   borderRadius: BorderRadius.circular(circular),
      //   color: Colors.grey[200],
      // ),
      child: Image.asset(
        imagePath,
        height: size,
      ),
    );
  }
}
