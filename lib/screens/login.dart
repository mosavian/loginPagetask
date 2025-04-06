import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  bool isValid = false;
  String? errorText;

  String _toEnglishDigits(String input) {
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    for (int i = 0; i < fa.length; i++) {
      input = input.replaceAll(fa[i], en[i]);
    }
    return input;
  }

  void _validatePhone(String value) {
    final english = _toEnglishDigits(value).replaceAll(RegExp(r'\s+'), '');
    final pattern = RegExp(r'^9\d{9}$');
    final isOk = pattern.hasMatch(english);
    setState(() {
      isValid = isOk;
      errorText = isOk ? null : 'شماره معتبر نیست';
    });
  }

  void _onNext() {
    final raw = _toEnglishDigits(phoneController.text).replaceAll(' ', '');
    final phone = '0$raw';
    context.go('/password?phone=$phone');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'شماره همراه',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'لطفاً کشور و شماره همراه خود را وارد کنید.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                SizedBox(height: 36),
                Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          onChanged: _validatePhone,
                          decoration: InputDecoration(
                            hintText: '912 345 6789',
                            errorText: errorText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text('+98', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Icon(Icons.flag, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isValid ? _onNext : null,
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
                    child: Text('تایید و ادامه'),
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
