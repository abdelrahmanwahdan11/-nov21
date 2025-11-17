import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../localization/app_localizations.dart';

class RoamifyTabBar extends StatelessWidget {
  const RoamifyTabBar({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final t = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.12), borderRadius: BorderRadius.circular(24)),
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
        tabs: [
          _Tab(icon: IconlyBold.home, label: t.translate('home')),
          _Tab(icon: IconlyBold.search, label: t.translate('search')),
          _Tab(icon: IconlyBold.chat, label: t.translate('ai')),
          _Tab(icon: IconlyBold.ticket_star, label: t.translate('rewards')),
          _Tab(icon: IconlyBold.setting, label: t.translate('settings')),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(icon),
      text: label,
    );
  }
}
