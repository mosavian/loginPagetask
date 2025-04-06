import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/success',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return SuccessPage(phone: phone);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SH',
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}

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
    final patterns = [
      RegExp(r'^09\d{9}$'),
      RegExp(r'^989\d{9}$'),
      RegExp(r'^\+989\d{9}$'),
    ];

    final matched = patterns.any((pattern) => pattern.hasMatch(english));
    setState(() {
      isValid = matched;
      errorText = matched ? null : 'شماره معتبر نیست';
    });
  }

  void _onNext() {
    final phone = _toEnglishDigits(phoneController.text).replaceAll(' ', '');
    final cleanPhone =
        phone.startsWith('09')
            ? phone
            : phone.startsWith('989')
            ? '0${phone.substring(2)}'
            : phone.startsWith('+989')
            ? '0${phone.substring(3)}'
            : phone;

    context.go('/success?phone=$cleanPhone');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),

                Text(
                  'شماره همراه',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'لطفاً کشور و شماره همراه خود را وارد کنید.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            '+98',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.flag, size: 20),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
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
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isValid ? _onNext : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor:
                          isValid ? Colors.teal : Colors.grey.shade300,
                      foregroundColor:
                          isValid ? Colors.white : Colors.grey.shade600,
                    ),
                    child: const Text(
                      'تایید و ادامه',
                      style: TextStyle(fontSize: 16),
                    ),
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

class SuccessPage extends StatelessWidget {
  final String phone;

  const SuccessPage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ورود موفق'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'شماره وارد شده:\n$phone',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
