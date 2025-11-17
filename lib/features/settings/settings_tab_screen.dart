import 'package:flutter/material.dart';

import '../../controllers/settings_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../core/localization/app_localizations.dart';

class SettingsTabScreen extends StatelessWidget {
  const SettingsTabScreen({super.key, required this.themeController, required this.settingsController});

  final ThemeController themeController;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final colors = [
      const Color(0xFF4F6F52),
      const Color(0xFF6E8F4B),
      const Color(0xFF3B5D3A),
      const Color(0xFF8C6C4F),
    ];
    return AnimatedBuilder(
      animation: Listenable.merge([themeController, settingsController]),
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(t.translate('language'), style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: AppLocalizations.supportedLocales
                  .map((locale) => Expanded(
                        child: RadioListTile<Locale>(
                          title: Text(locale.languageCode.toUpperCase()),
                          value: locale,
                          groupValue: settingsController.locale,
                          onChanged: (value) => settingsController.updateLocale(value!),
                        ),
                      ))
                  .toList(),
            ),
            SwitchListTile(
              title: Text(t.translate('dark_mode')),
              value: themeController.isDark,
              onChanged: (_) => themeController.toggleDark(),
            ),
            SwitchListTile(
              title: const Text('Reduce animations'),
              value: settingsController.reduceMotion,
              onChanged: (_) => settingsController.toggleMotion(),
            ),
            const SizedBox(height: 12),
            Text(t.translate('primary_color'), style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 12,
              children: colors
                  .map((color) => GestureDetector(
                        onTap: () => themeController.updatePrimary(color),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: themeController.primaryColor == color
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            ListTile(
              title: Text(t.translate('about')),
              subtitle: Text(t.translate('version')),
            )
          ],
        );
      },
    );
  }
}
