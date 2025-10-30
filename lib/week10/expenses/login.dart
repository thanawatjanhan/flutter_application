import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'expense.dart';
import 'users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final url = "10.0.2.2.:3000";
  final url = "172.28.147.17:3000";
  bool isWaiting = false;
  final tcUsername = TextEditingController();
  final tcPassword = TextEditingController();

  void popDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: const Text('Error'), content: Text(message));
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
        // get token and save to local storage
        String token = response.body;
        // debugPrint(token);

        final storage = await SharedPreferences.getInstance();
        await storage.setString('token', token);
        // decode token to get user role
        final user = jsonDecode(token);
        // debugPrint(user['role']);

        // to prevent warning of using 'context' in navigation
        if (!mounted) return;
        // navigate to admin page or user page
        if (user['role'] == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const Users()),
          );
        } else if (user['role'] == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const Expense(),
            ),
          );
        }
      } else {
        // wrong username or password
        popDialog(response.body);
      }
    } on TimeoutException catch (e) {
      debugPrint(e.message);
      popDialog('Timeout error, try again!');
    } catch (e) {
      debugPrint(e.toString());
      popDialog('Unknown error, try again!');
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
