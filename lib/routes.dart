import 'package:go_router/go_router.dart';
import 'package:login/screens/login.dart';
import 'package:login/screens/password.dart';
import 'package:login/screens/success.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginPage()),
    GoRoute(
      path: '/password',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return PasswordPage(phone: phone);
      },
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return SuccessPage(phone: phone);
      },
    ),
  ],
);
