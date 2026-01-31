import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlashcardScreen extends StatefulWidget {
  final String uuid;
  final String token;

  const FlashcardScreen({super.key, required this.uuid, required this.token});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late Timer _timer;
  int _secondsRemaining = 900;

  List<Map<String, dynamic>> flashcards = [];

  int _currentIndex = 0;
  bool _showBack = false;

  Future<void> fetchFlashcards() async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://vgq9k988-8000.asse.devtunnels.ms/api/v1/ai/materials/flashcards',
        ),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'materialId': widget.uuid}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          setState(() {
            flashcards = List<Map<String, dynamic>>.from(data['data']);
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching flashcards: $e');
    }
  }

  void sendAnswer(bool isCorrect) async {
    try {
      await http.post(
        Uri.parse(
          'https://vgq9k988-8000.asse.devtunnels.ms/api/v1/ai/materials/${widget.uuid}/flashcards/attempts',
        ),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'flashcardId': flashcards[_currentIndex]["id"],
          'selectedAnswer': isCorrect,
        }),
      );

      _goToNextCard();
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic>? get currentFlashcard {
    if (flashcards.isEmpty || _currentIndex >= flashcards.length) {
      return null;
    }
    return flashcards[_currentIndex];
  }

  void _goToNextCard() {
    setState(() {
      _showBack = false;

      if (_currentIndex < flashcards.length - 1) {
        _currentIndex++;
      } else {
        Navigator.of(context).pop(); // finished all cards
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFlashcards();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (flashcards.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 48),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
            centerTitle: true,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFECF8FB),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.quiz_outlined),
                  SizedBox(width: 10),
                  Text(
                    "Flashcard",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _showBack = !_showBack;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 20,
                      color: const Color(0xFF13C8EC).withOpacity(0.05),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 350,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Text(
                                _showBack
                                    ? (currentFlashcard?['back'] as String? ??
                                          '')
                                    : (currentFlashcard?['front'] as String? ??
                                          ''),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFBFCFD),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.touch_app,
                                  size: 32,
                                  color: Color(0xFF0D68C0),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  _showBack ? "Jawab" : "T A M P I L K A N",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D68C0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECF8FB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Difficulty: ${currentFlashcard?['difficulty']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3D7984),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_showBack) ...[
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => sendAnswer(false),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Salah",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => sendAnswer(true),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Benar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
