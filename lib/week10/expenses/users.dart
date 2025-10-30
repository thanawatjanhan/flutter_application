// Only for admin
// Show all users in the system
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final url = '192.168.1.112:3000';
  bool isWaiting = false;
  String uname = '';
  List? users;

  void popDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: const Text('Error'), content: Text(message));
      },
    );
  }

  void getUsers() async {
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

    setState(() {
      isWaiting = true;
      uname = user['username'];
    });

    // get all users
    try {
      Uri uri = Uri.http(url, '/api/admin/users');
      http.Response response = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));
      // check server's response
      if (response.statusCode == 200) {
        users = jsonDecode(response.body);
      } else {
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
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
        actions: [
          Text(uname),
          IconButton(onPressed: logout, icon: const Icon(Icons.key_off)),
        ],
      ),
      body: isWaiting
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: users == null ? 0 : users!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${users![index]['username']}'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check, color: Colors.green),
                  ),
                );
              },
            ),
    );
  }
}
