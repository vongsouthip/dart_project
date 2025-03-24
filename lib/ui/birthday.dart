import 'package:flutter/material.dart';

class Birthday extends StatefulWidget {
  const Birthday({super.key});

  @override
  State<Birthday> createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  DateTime? datePicker;
  final currentTime = DateTime.now();
  int? age;

  // DateFormat dateFormat = DateFormat();

  Future<void> selectDate() async {
    final DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 7, 25),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickerDate == null) return;

    setState(() {
      datePicker = pickerDate;
      // currentTime.year - datePicker!.year;
      age = currentTime.difference(datePicker!).inDays ~/ 365;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Birthday')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              datePicker != null
                  ? '${datePicker!.day}/${datePicker!.month}/${datePicker!.year}'
                  : 'No date selected',
            ),
            OutlinedButton(
              onPressed: () {
                selectDate();
              },
              child: Text('Select birth date'),
            ),
            SizedBox(height: 25),
            Text('Your Age is: $age', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
