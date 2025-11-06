import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'expense.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String url = '10.0.2.2:3000';
  bool isWaiting = false;
  final tcUsername = TextEditingController();
  final tcPassword = TextEditingController();

  void popDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text(title), content: Text(message));
      },
    );
  }

  void login() async {
    setState(() {
      isWaiting = true;
    });
    try {
      Uri uri = Uri.http(url, '/api/login');
      Map account = {
        'username': tcUsername.text.trim(),
        'password': tcPassword.text.trim(),
      };
      http.Response response = await http
          .post(
            uri,
            body: jsonEncode(account),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));
      // check server's response
      if (response.statusCode == 200) {
        String token = response.body;
        // get JWT token and save to local storage
        final storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: token);
        // decode JWT to get username and role
        final jwt = JWT.decode(token);
        Map payload = jwt.payload;
        // print(payload);

        // navigate to admin page or user page
        if (payload['role'] == 'admin') {
          popDialog('Success', 'Welcome admin');
        } else if (payload['role'] == 'user') {
          // navigate to expense page
          // check mounted to use 'context' for navigation in 'async' method
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const Expense(),
            ),
          );
        }
      } else {
        // wrong username or password
        popDialog('Error', response.body);
      }
    } on TimeoutException catch (e) {
      debugPrint(e.message);
      popDialog('Error', 'Timeout error, try again!');
    } catch (e) {
      debugPrint(e.toString());
      popDialog('Error', 'Unknown error, try again!');
    } finally {
      setState(() {
        isWaiting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tcUsername,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Username',
                suffixIcon: IconButton(
                  onPressed: () {
                    tcUsername.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              controller: tcPassword,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    tcPassword.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 8),
            isWaiting
                ? const CircularProgressIndicator()
                : FilledButton(onPressed: login, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
