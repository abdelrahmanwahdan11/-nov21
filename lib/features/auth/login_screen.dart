import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/auth_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/primary_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.authController});

  final AuthController authController;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.translate('login'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ).animate().fadeIn(duration: 500.ms).slide(begin: const Offset(0, 0.2)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: t.translate('email_phone')),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: t.translate('password')),
                  obscureText: true,
                  validator: (value) => value != null && value.length >= 6 ? null : 'Min 6 chars',
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(t.translate('forgot_password')),
                          content: const Text('We sent a reset code to your inbox.'),
                        ),
                      );
                    },
                    child: Text(t.translate('forgot_password')),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: t.translate('login'),
                  onPressed: _loading
                      ? () {}
                      : () async {
                          if (!_formKey.currentState!.validate()) return;
                          setState(() => _loading = true);
                          await widget.authController.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (mounted) setState(() => _loading = false);
                        },
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => widget.authController.login('guest@roamify.app', 'guest'),
                  child: Text(t.translate('guest_login')),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(t.translate('register')),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(authController: widget.authController),
                        ),
                      ),
                      child: Text(t.translate('get_started')),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
