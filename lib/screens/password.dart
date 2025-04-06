import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordPage extends StatefulWidget {
  final String phone;

  const PasswordPage({super.key, required this.phone});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final passwordController = TextEditingController();
  bool isValid = false;

  void _validatePassword(String value) {
    setState(() {
      isValid = value.length >= 4;
    });
  }

  void _submit() {
    context.go('/success?phone=${widget.phone}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('رمز عبور'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  'رمز عبور را وارد کنید',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: _validatePassword,
                  decoration: InputDecoration(hintText: 'رمز عبور'),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isValid ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor:
                          isValid ? Colors.teal : Colors.grey.shade300,
                      foregroundColor:
                          isValid ? Colors.white : Colors.grey.shade600,
                    ),
                    child: Text('ورود'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
