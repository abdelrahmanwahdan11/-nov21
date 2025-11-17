import 'package:flutter/material.dart';
import '../../core/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
              TextFormField(controller: _password, decoration: const InputDecoration(labelText: 'Password')),
              const SizedBox(height: 24),
              PrimaryButton(text: 'Create account', onPressed: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}
