import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
