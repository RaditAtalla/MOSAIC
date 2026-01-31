import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final String title;
  final String place;
  final int duration;

  const TimeCard({
    super.key,
    required this.title,
    required this.place,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFFEFF3F6),
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(color: Color(0xFFE4E8EC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  place,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3D7984),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(radius: 3, backgroundColor: Color(0xFF3D7984)),
                SizedBox(width: 10),
                Text(
                  "${duration.toString()} Jam",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3D7984),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
