import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.authController});

  final AuthController authController;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  double _strength = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('register'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value != null && value.contains('@') ? null : 'Invalid email',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  setState(() => _strength = _passwordStrength(value));
                },
                validator: (value) => value != null && value.length >= 6 ? null : 'Min 6 chars',
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: _strength, minHeight: 6, borderRadius: BorderRadius.circular(12)),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm password'),
                validator: (value) => value == _passwordController.text ? null : 'Passwords must match',
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: t.translate('register'),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  await widget.authController.login(_emailController.text, _passwordController.text);
                  if (mounted) Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _passwordStrength(String value) {
    double strength = 0;
    if (value.length >= 6) strength += 0.3;
    if (value.contains(RegExp(r'[A-Z]'))) strength += 0.3;
    if (value.contains(RegExp(r'[0-9]'))) strength += 0.2;
    if (value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) strength += 0.2;
    return strength.clamp(0, 1);
  }
}
