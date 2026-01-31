import 'package:flutter/material.dart';

class MosaicCard extends StatelessWidget {
  final String activity;
  final int duration;

  const MosaicCard({super.key, required this.activity, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFFECF8FB),
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(color: Color(0xFF0D68C0)),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_circle_fill_rounded,
                color: Color(0xFF0EA5C6),
                size: 48,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MOSAIC",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D68C0),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      activity,
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
                      "${duration.toString()} Menit",
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
          ],
        ),
      ),
    );
  }
}
