import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mosaic/Layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailC = TextEditingController();
    var passwordC = TextEditingController();

    void goToHome(String token) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Layout(token: token)),
      );
    }

    void handleLogin() async {
      var email = emailC.text;
      var password = passwordC.text;

      try {
        final response = await http.post(
          Uri.parse(
            'https://vgq9k988-8000.asse.devtunnels.ms/api/v1/auth/login',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          goToHome(result["data"]["token"]);
        } else {
          print('Login failed: ${response.body}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                TextField(
                  controller: emailC,
                  decoration: InputDecoration(
                    hint: Text(
                      "Masukkan email...",
                      style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                TextField(
                  controller: passwordC,
                  obscureText: true,
                  decoration: InputDecoration(
                    hint: Text(
                      "Masukkan password...",
                      style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),

                SizedBox(height: 50),

                FilledButton(
                  onPressed: () {
                    handleLogin();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF13C8EC),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
