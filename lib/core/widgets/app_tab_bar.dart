import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../localization/app_localizations.dart';

class RoamifyTabBar extends StatelessWidget {
  const RoamifyTabBar({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labels = [
      AppLocalizations.of(context).translate('home'),
      AppLocalizations.of(context).translate('search'),
      AppLocalizations.of(context).translate('ai'),
      AppLocalizations.of(context).translate('rewards'),
      AppLocalizations.of(context).translate('settings'),
    ];
    final icons = const [
      IconlyBold.home,
      IconlyBold.search,
      IconlyBold.chat,
      IconlyBold.ticket_star,
      IconlyBold.setting,
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(.9),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(.12),
          borderRadius: BorderRadius.circular(24),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.textTheme.bodyMedium?.color?.withOpacity(.6),
        tabs: List.generate(5, (index) {
          return Tab(
            iconMargin: const EdgeInsets.only(bottom: 2),
            icon: Icon(icons[index]),
            child: Text(
              labels[index],
              style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          );
        }),
      ),
    );
  }
}
