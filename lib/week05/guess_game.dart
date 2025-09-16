import 'package:flutter/material.dart';
import 'dart:math';

class GuessGame extends StatefulWidget {
  const GuessGame({super.key});

  @override
  State<GuessGame> createState() => _GuessGameState();
}

class _GuessGameState extends State<GuessGame> {
  final TextEditingController _controller = TextEditingController();
  late int _answer;
  int _attemptsLeft = 3;
  String _message = "";

  @override
  void initState() {
    super.initState();
    _replay(); 
  }

  void _replay() {
    setState(() {
      _answer = Random().nextInt(10); 
      _attemptsLeft = 3;
      _message = "";
      _controller.clear();
    });
  }

  void _guess() {
    String input = _controller.text.trim();
    if (input.isEmpty || int.tryParse(input) == null) {
      setState(() {
        _message = "Please guess a number 0-9";
      });
      return;
    }

    int guess = int.parse(input);

    if (_attemptsLeft <= 0 || _message == "Correct, you win!") {
      return;
    }

    setState(() {
      _attemptsLeft--;
      if (guess == _answer) {
        _message = "Correct, you win!";
      } else if (_attemptsLeft == 0) {
        _message = "Sorry, you lose. The answer is $_answer.";
      } else if (guess < _answer) {
        _message = "$guess is too small, $_attemptsLeft chance(s) left";
      } else {
        _message = "$guess is too large, $_attemptsLeft chance(s) left";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String buttonLabel;
    VoidCallback buttonAction;

    if (_attemptsLeft > 0 && _message != "Correct, you win!") {
      buttonLabel = "Guess";
      buttonAction = _guess;
    } else {
      buttonLabel = "Replay";
      buttonAction = _replay;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Guess a number game')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Guess a number 0-9',
              ),
              controller: _controller,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 5),
            Text(
              _message,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: buttonAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.grey),
              ),
              child: Text(buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
