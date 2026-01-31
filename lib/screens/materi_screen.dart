import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mosaic/widgets/subject_card.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class MateriScreen extends StatefulWidget {
  final String token;

  const MateriScreen({super.key, required this.token});

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  List<Map<String, dynamic>> materials = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchMaterials();
  }

  Future<void> fetchMaterials() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final response = await http.get(
        Uri.parse(
          'https://vgq9k988-8000.asse.devtunnels.ms/api/v1/ai/materials',
        ),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          setState(() {
            materials = List<Map<String, dynamic>>.from(data['data']);
            isLoading = false;
          });
          print('Materials fetched: ${materials.length} items');
        } else {
          setState(() {
            errorMessage = 'Failed to load materials';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error: ${response.statusCode}';
          isLoading = false;
        });
        print('Failed to fetch materials: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
      print('Error fetching materials: $e');
    }
  }

  @override
  Widget build(BuildContext context) {


    void addMaterial() async {
      print("=========ADD FILE===============");
      try {
        // Pick file
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          final file = result.files.single;
          final filePath = file.path!;
          final fileName = file.name;

          // Create multipart request
          final request = http.MultipartRequest(
            'POST',
            Uri.parse(
              'https://vgq9k988-8000.asse.devtunnels.ms/api/v1/ai/materials/upload',
            ),
          );

          // Add headers with bearer token
          request.headers['Authorization'] = 'Bearer ${widget.token}';

          // Add fields
          request.fields['title'] = fileName;

          // Detect MIME type and add file with content type
          final mimeType =
              lookupMimeType(filePath) ?? 'application/octet-stream';
          final parts = mimeType.split('/');
          final contentType = parts.length == 2
              ? MediaType(parts[0], parts[1])
              : MediaType('application', 'octet-stream');

          // Debug: log detected MIME and content type
          print(
            'Uploading file $fileName with mime $mimeType and contentType $contentType',
          );

          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              filePath,
              contentType: contentType,
            ),
          );

          // Send request
          final response = await request.send();
          final responseBody = await response.stream.bytesToString();

          if (response.statusCode == 200) {
            print('File uploaded successfully: $responseBody');
            // Refresh materials after upload
            fetchMaterials();
          } else {
            print('Upload failed: ${response.statusCode}');
            print('Response: $responseBody');
          }
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Material Hub",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              "Kumpulan Materi Kamu",
              style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),
            ),

            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: BoxBorder.all(color: Color(0xFF94A3B8)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Color(0xFF94A3B8)),
                  hint: Text(
                    "Cari Subjek",
                    style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 30),

            FilledButton(
              onPressed: addMaterial,
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
                  Text(
                    "Tambah Materi",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Display materials or loading/error state
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (errorMessage != null)
              Center(
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
            else if (materials.isEmpty)
              Center(
                child: Text(
                  "Tidak ada materi tersedia",
                  style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),
                ),
              )
            else
              ...materials.map((material) {
                final materialData = material['material'];
                final progress = material['progress']['total'];
                final masteryPercentage = (progress['progress'] as num).toInt();

                return Column(
                  children: [
                    SubjectCard(
                      token: widget.token,
                      uuid: materialData['id'],
                      name: materialData['title'],
                      masteryPercentage: masteryPercentage,
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
