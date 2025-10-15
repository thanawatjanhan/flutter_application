import 'package:flutter/material.dart';

class Assignment1 extends StatefulWidget {
  const Assignment1({super.key});

  @override
  State<Assignment1> createState() => _Assignment1State();
}

class _Assignment1State extends State<Assignment1> {
  DateTime? fromDate;
  DateTime? toDate;
  late DateTime today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
  }

  String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void selectFromDate() async {
    DateTime initialFrom = fromDate ?? today;
    DateTime firstDate = DateTime(today.year, 1, 1);
    DateTime lastDate = DateTime(today.year, 12, 31);

    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: initialFrom,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (dt != null) {
      setState(() {
        fromDate = dt;
        if (toDate == null || toDate!.isBefore(fromDate!)) {
          toDate = fromDate;
        }
      });
    }
  }

  void selectToDate() async {
    if (fromDate == null) return;

    DateTime initialTo = toDate ?? fromDate!;
    DateTime firstDate = fromDate!;
    DateTime lastDate = DateTime(today.year, 12, 31);

    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: initialTo,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (dt != null) {
      setState(() {
        toDate = dt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DatePicker Demo')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FilledButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: selectFromDate,
                  label: const Text('From'),
                ),
                const SizedBox(width: 10),
                Text(formatDate(fromDate)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                FilledButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: selectToDate,
                  label: const Text('To'),
                ),
                const SizedBox(width: 10),
                Text(formatDate(toDate)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
