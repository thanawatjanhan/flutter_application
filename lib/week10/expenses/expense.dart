// For gerneral users
// Show all expenses of the user
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'add.dart';
import 'edit.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final url = '192.168.1.112:3000';
  bool isWaiting = false;
  String uname = '';
  int uid = 0;
  List? expenses;

  void popDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: const Text('Error'), content: Text(message));
      },
    );
  }

  void getExpenses() async {
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
    uid = user['uid'];

    setState(() {
      isWaiting = true;
      uname = user['username'];
    });

    try {
      Uri uri = Uri.http(url, '/api/user/expense/$uid');
      http.Response response = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));
      // check server's response
      if (response.statusCode == 200) {
        expenses = jsonDecode(response.body);
        // print(expenses);
      } else {
        // to prevent warning of using context in async function
        if (!mounted) return;
        popDialog(response.body);
      }
    } on TimeoutException catch (e) {
      debugPrint(e.message);
      if (!mounted) return;
      popDialog('Timeout error, try again!');
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) return;
      popDialog('Unknown error, try again!');
    } finally {
      setState(() {
        isWaiting = false;
      });
    }
  }

  void confirmDelete(itemID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sure to delete?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteExpense(itemID);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void deleteExpense(itemID) async {
    setState(() {
      isWaiting = true;
    });

    try {
      Uri uri = Uri.http(url, '/api/user/expense/$itemID');
      http.Response response = await http
          .delete(uri)
          .timeout(const Duration(seconds: 10));
      // check server's response
      if (response.statusCode == 200) {
        // update UI
        setState(() {
          expenses!.removeWhere((item) => item['id'] == itemID);
        });
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

  void addExpense() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Add()),
    );
  }

  void editExpense(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Edit(expense: expenses![index])),
    );
  }

  void logout() async {
    // remove stored token
    final storage = await SharedPreferences.getInstance();
    await storage.remove('token');

    if (!mounted) return;
    // back to login, clear all history
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your expenses'),
        actions: [
          Text(uname),
          IconButton(onPressed: logout, icon: const Icon(Icons.key_off)),
        ],
      ),
      body: isWaiting
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: expenses == null ? 0 : expenses!.length,
              itemBuilder: (context, index) {
                // convert datetime String to local DateTime
                DateTime dt = DateTime.parse(
                  expenses![index]['date'],
                ).toLocal();
                return ListTile(
                  leading: IconButton(
                    onPressed: () => editExpense(index),
                    icon: const Icon(Icons.edit),
                  ),
                  title: Text(
                    '${expenses![index]['item']}: ${expenses![index]['paid']} baht',
                  ),
                  subtitle: Text('${dt.day}/${dt.month}/${dt.year}'),
                  trailing: IconButton(
                    onPressed: () => confirmDelete(expenses![index]['id']),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
