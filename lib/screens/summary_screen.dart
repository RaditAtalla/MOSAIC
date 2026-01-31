import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SummaryScreen extends StatefulWidget {
  final String token;
  final String uuid;
  const SummaryScreen({super.key, required this.uuid, required this.token});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String summary = "";

  Future<void> fetchSummary() async {
    try {
      print('Fetching summary for UUID: ${widget.uuid}');
      final response = await http.post(
        Uri.parse(
          'https://vgq9k988-8000.asse.devtunnels.ms/api/v1/ai/materials/summary',
        ),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'materialId': widget.uuid}),
      );

      print('Summary response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['data']);
        if (data['success'] == true && data['data'] != null) {
          setState(() {
            summary = data['data']['content'];
          });
        }
      } else {
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error fetching materials: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(children: [Text("Summary"), Text(summary)]),
        ),
      ),
    );
  }
}
