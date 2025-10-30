import 'dart:async';
import 'dart:convert';
import 'login.dart';
import 'expense.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final url = '192.168.1.112:3000';
  bool isWaiting = false;
  final tcItem = TextEditingController();
  final tcPaid = TextEditingController();

  void popDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: const Text('Error'), content: Text(message));
      },
    );
  }

  void addExpense() async {
    setState(() {
      isWaiting = true;
    });

    // get token from local storage
    final storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    if (token == null) {
      if (!mounted) return;
      // return to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );
      return;
    }
    // decode token to get user info
    final user = jsonDecode(token);

    try {
      Uri uri = Uri.http(url, '/api/user/expense');
      Map expense = {
        'uid': user['uid'],
        'item': tcItem.text.trim(),
        'paid': tcPaid.text.trim(),
      };
      http.Response response = await http
          .post(
            uri,
            body: jsonEncode(expense),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));
      // check server's response
      if (response.statusCode == 200) {
        // back to expense page
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Expense()),
          (route) => false,
        );
      } else {
        debugPrint(response.body);
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
      appBar: AppBar(title: const Text('Add new expense')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tcItem,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Item',
                suffixIcon: IconButton(
                  onPressed: () {
                    tcItem.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: tcPaid,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Paid',
                suffixIcon: IconButton(
                  onPressed: () {
                    tcPaid.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 16),
            isWaiting
                ? const CircularProgressIndicator()
                : FilledButton(
                    onPressed: addExpense,
                    child: const Text('Save'),
                  ),
          ],
        ),
      ),
    );
  }
}
