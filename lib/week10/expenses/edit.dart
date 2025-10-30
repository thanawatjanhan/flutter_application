import 'dart:async';
import 'dart:convert';
import 'expense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final Map expense;
  const Edit({super.key, required this.expense});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
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

  void editExpense() async {
    setState(() {
      isWaiting = true;
    });

    try {
      Uri uri = Uri.http(url, '/api/user/expense/${widget.expense['id']}');
      Map updateExpense = {
        'item': tcItem.text.trim(),
        'paid': tcPaid.text.trim(),
      };
      http.Response response = await http
          .put(
            uri,
            body: jsonEncode(updateExpense),
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
  void initState() {
    super.initState();
    tcItem.text = widget.expense['item'];
    tcPaid.text = widget.expense['paid'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit expense')),
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
                    onPressed: editExpense,
                    child: const Text('Save'),
                  ),
          ],
        ),
      ),
    );
  }
}
