import 'package:flutter/material.dart';

class DatepickerDemo extends StatefulWidget {
  const DatepickerDemo({super.key});

  @override
  State<DatepickerDemo> createState() => _DatepickerDemoState();
}

class _DatepickerDemoState extends State<DatepickerDemo> {
  String date = "";
  String time = "";
  String dialog = "";

  void showCalender() async {
    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, 9, 1),
      lastDate: DateTime(DateTime.now().year, 10, 31),
    );

    if (dt != null) {
      setState(() {
        date = "${dt.day}/${dt.month}/${dt.year}";
      });
    } else {
      setState(() {
        date = "Please select a date";
      });
    }
  }

  void showTime() async {
    TimeOfDay? td = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (td != null) {
      setState(() {
        time = "${td.hour}:${td.minute}";
      });
    } else {
      setState(() {
        time = "Please select a time";
      });
    }
  }

  void showAlert() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Column(
            children: [
              Image.network(
                "https://www.iconarchive.com/download/i80224/custom-icon-design/flatastic-1/delete-1.64.png",
              ),
              Text("The item will be removed permanently"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  dialog = "You choose OK";
                });
              },
              child: Text("OK"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(date),
            FilledButton.icon(
              onPressed: showCalender,
              icon: Icon(Icons.calendar_today),
              label: Text("Select"),
            ),
            SizedBox(height: 30),
            Text(time),
            FilledButton.icon(
              onPressed: showTime,
              icon: Icon(Icons.access_time),
              label: Text("Select"),
            ),
            SizedBox(height: 30),
            FilledButton.icon(
              onPressed: showAlert,
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              label: Text("Delete"),
            ),
            Text(dialog),
          ],
        ),
      ),
    );
  }
}
