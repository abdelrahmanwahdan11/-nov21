import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('reset_password'))),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.translate('forgot_password'),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn(duration: 400.ms).slide(begin: const Offset(0, 0.2)),
              const SizedBox(height: 12),
              Text(
                t.translate('reset_sent'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: t.translate('email_phone')),
                validator: (value) {
                  if (value == null || value.isEmpty) return t.translate('required');
                  if (!value.contains('@')) return t.translate('invalid_email');
                  return null;
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: _submitted ? t.translate('reset_sent') : t.translate('send'),
                onPressed: _submitted
                    ? null
                    : () {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => _submitted = true);
                        Future.delayed(const Duration(seconds: 1), () {
                          if (mounted) Navigator.of(context).pop();
                        });
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
