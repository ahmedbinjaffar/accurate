import 'package:flutter/material.dart';

class TopHeading extends StatelessWidget {
  final String title;
  final dynamic colour;
  const TopHeading({super.key, required this.title, this.colour});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(color: colour, fontWeight: FontWeight.bold, fontSize: 20),
    );
    
    
  }
}
