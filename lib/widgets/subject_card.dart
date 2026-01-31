import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String name;
  final int masteryPercentage;

  const SubjectCard({super.key, required this.name, required this.masteryPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentGeometry.bottomLeft,
                children: [
                  Container(color: Color(0xFFDFFAFF), height: 200),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.auto_graph, color: Color(0xFF3D7984)),
                            SizedBox(width: 10),
                            Text(
                              "Tingkat Keahlian",
                              style: TextStyle(
                                color: Color(0xFF3D7984),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 140,
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(10),
                                value: masteryPercentage / 100.0,
                                backgroundColor: Color(0xFFCDF7FF),
                                color: Color(0xFF13C8EC),
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${masteryPercentage.toString()}%",
                              style: TextStyle(
                                color: Color(0xFF13C8EC),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Color(0xFF13C8EC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle,
                            color: Colors.black,
                            size: 26,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Baca Ringkasan",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
