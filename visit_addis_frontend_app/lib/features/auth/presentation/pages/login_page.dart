import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_addis_frontend_app/features/auth/services/auth_service.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    if (authService.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authService.errorMessage!)));
        authService.clearError();
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text(
                'Visit Addis',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Discover the beauty of Ethiopia's capital",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              // Login/Register Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'your@email.com',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '********',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 24),
              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      authService.isLoading
                          ? null
                          : () async {
                            if (_formKey.currentState!.validate()) {
                              final success = await authService.login(
                                _emailController.text.trim(),
                                _passwordController.text,
                              );
                              if (success && mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/events',
                                );
                              }
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      authService.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                ),
              ),
              const SizedBox(height: 24),
              // OR Divider
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              // Google Login Button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.grey),
                ),
                onPressed: () {
                  print('Google login pressed');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata),
                    SizedBox(width: 8),
                    Text('Continue with Google'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
