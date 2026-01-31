import 'package:flutter/material.dart';
import 'package:mosaic/widgets/subject_card.dart';

class MateriScreen extends StatelessWidget {
  const MateriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Material Hub", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
            Text("Kumpulan Materi Kamu", style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),),

            SizedBox(height: 30,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: BoxBorder.all(color: Color(0xFF94A3B8)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Color(0xFF94A3B8),),
                  hint: Text("Cari Subjek", style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 30,),

            SubjectCard(name: "Kalkulus: Anti-Derivative", masteryPercentage: 50),
            SizedBox(height: 20,),
            SubjectCard(name: "DPBO: Inheritance", masteryPercentage: 90),
            SizedBox(height: 20,),
            SubjectCard(name: "STD: Queue", masteryPercentage: 5),
          ],
        ),
      ),
    );
  }
}