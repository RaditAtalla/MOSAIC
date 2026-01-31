import 'package:flutter/material.dart';
import 'package:mosaic/widgets/mosaic_card.dart';
import 'package:mosaic/widgets/subject_card.dart';
import 'package:mosaic/widgets/time_card.dart';
import 'package:mosaic/widgets/time_info.dart';

class JadwalScreen extends StatelessWidget {
  const JadwalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubjectCard(
              name: "Kalkulus: Anti-Derivative",
              masteryPercentage: 50,
            ),
            SizedBox(height: 30),

            Text(
              "Jadwal Kamu",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Row(
              children: [
                TimeInfo(start: "07:30", end: "10:30"),
                SizedBox(width: 20),
                TimeCard(
                  title: "Praktikum DPBO",
                  place: "TULT 0604",
                  duration: 3,
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [
                TimeInfo(start: "10:30", end: "10:45"),
                SizedBox(width: 20),
                MosaicCard(activity: "Flashcard", duration: 15),
              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [
                TimeInfo(start: "11:00", end: "13:00"),
                SizedBox(width: 20),
                TimeCard(
                  title: "Rapat UKM",
                  place: "Outdoor Class",
                  duration: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
