import 'package:flutter/material.dart';

class TimeInfo extends StatelessWidget {
  final String start;
  final String end;

  const TimeInfo({super.key, required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          start,
          style: TextStyle(
            color: Color(0xFF3D7984),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "-",
          style: TextStyle(
            color: Color(0xFF3D7984),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          end,
          style: TextStyle(
            color: Color(0xFF3D7984),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
