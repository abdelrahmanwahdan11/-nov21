import 'package:flutter/material.dart';
import '../../core/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Reset')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: controller, decoration: const InputDecoration(labelText: 'Email or phone')),
            const SizedBox(height: 16),
            PrimaryButton(text: 'Send reset link', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
