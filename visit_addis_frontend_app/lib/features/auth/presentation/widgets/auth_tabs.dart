import 'package:flutter/material.dart';

class AuthTabs extends StatelessWidget {
  const AuthTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/login';
    final isLogin = currentRoute == '/login';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: isLogin ? null : () => Navigator.pushNamed(context, '/login'),
          style: TextButton.styleFrom(
            foregroundColor: isLogin ? Colors.black : Colors.grey,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          child: const Text('Login'),
        ),
        const SizedBox(width: 24),
        TextButton(
          onPressed:
              !isLogin ? null : () => Navigator.pushNamed(context, '/register'),
          style: TextButton.styleFrom(
            foregroundColor: !isLogin ? Colors.black : Colors.grey,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: !isLogin ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          child: const Text('Register'),
        ),
      ],
    );
  }
} 