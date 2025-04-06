import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String phone;

  const SuccessPage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('ورود موفق'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'شماره وارد شده:\n$phone',
          textAlign: TextAlign.center,
          style:  TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
