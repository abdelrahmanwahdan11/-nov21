import 'package:flutter/material.dart';
import '../../controllers/hotels_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/dummy_data.dart';

class SettingsTabScreen extends StatelessWidget {
  const SettingsTabScreen({super.key, required this.themeController, required this.settingsController, required this.hotelsController, required this.bookingsController});

  final ThemeController themeController;
  final SettingsController settingsController;
  final HotelsController hotelsController;
  final dynamic bookingsController;

  @override
  Widget build(BuildContext context) {
    final t = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return AnimatedBuilder(
      animation: Listenable.merge([themeController, settingsController]),
      builder: (_, __) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              value: themeController.mode == ThemeMode.dark,
              onChanged: themeController.toggleDark,
              title: Text(t.translate('theme')),
            ),
            ListTile(
              title: Text(t.translate('language')),
              trailing: DropdownButton<Locale>(
                value: settingsController.locale,
                onChanged: (loc) => settingsController.setLocale(loc ?? const Locale('en')),
                items: const [
                  DropdownMenuItem(value: Locale('en'), child: Text('English')),
                  DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
                ],
              ),
            ),
            const Divider(),
            Text(t.translate('primary_color')),
            Wrap(
              spacing: 8,
              children: primaryChoices
                  .map((c) => GestureDetector(
                        onTap: () => themeController.setPrimary(c),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(color: themeController.primaryColor == c ? Colors.black : Colors.transparent, width: 2),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SwitchListTile(
              value: settingsController.reduceMotion,
              onChanged: settingsController.toggleReduceMotion,
              title: const Text('Reduce motion'),
            ),
          ],
        );
      },
    );
  }
}
