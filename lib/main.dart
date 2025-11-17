import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/auth_controller.dart';
import 'controllers/bookings_controller.dart';
import 'controllers/chat_controller.dart';
import 'controllers/comparison_controller.dart';
import 'controllers/hotels_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/settings_controller.dart';
import 'controllers/theme_controller.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_tab_bar.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_tab_screen.dart';
import 'features/onboarding/onboarding_story_screen.dart';
import 'features/search/search_tab_screen.dart';
import 'features/chat/ai_chat_tab_screen.dart';
import 'features/rewards_profile/rewards_profile_tab_screen.dart';
import 'features/settings/settings_tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(prefs);
  final settingsController = SettingsController(prefs);
  final authController = AuthController(prefs);
  await Future.wait([
    themeController.load(),
    settingsController.load(),
    authController.load(),
  ]);
  final hotelsController = HotelsController();
  final bookingsController = BookingsController();
  bookingsController.seedHotels(hotelsController.visible);
  final searchController = SearchController(hotelsController);
  final comparisonController = ComparisonController();
  final chatController = ChatController();
  runApp(RoamifyApp(
    themeController: themeController,
    settingsController: settingsController,
    authController: authController,
    hotelsController: hotelsController,
    bookingsController: bookingsController,
    searchController: searchController,
    comparisonController: comparisonController,
    chatController: chatController,
  ));
}

class RoamifyApp extends StatefulWidget {
  const RoamifyApp({
    super.key,
    required this.themeController,
    required this.settingsController,
    required this.authController,
    required this.hotelsController,
    required this.bookingsController,
    required this.searchController,
    required this.comparisonController,
    required this.chatController,
  });

  final ThemeController themeController;
  final SettingsController settingsController;
  final AuthController authController;
  final HotelsController hotelsController;
  final BookingsController bookingsController;
  final SearchController searchController;
  final ComparisonController comparisonController;
  final ChatController chatController;

  @override
  State<RoamifyApp> createState() => _RoamifyAppState();
}

class _RoamifyAppState extends State<RoamifyApp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([widget.themeController, widget.settingsController]),
      builder: (context, _) {
        return MaterialApp(
          title: 'Roamify',
          theme: AppTheme.light(widget.themeController.primaryColor),
          darkTheme: AppTheme.dark(widget.themeController.primaryColor),
          themeMode: widget.themeController.mode,
          debugShowCheckedModeBanner: false,
          locale: widget.settingsController.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: RootRouter(
            authController: widget.authController,
            hotelsController: widget.hotelsController,
            bookingsController: widget.bookingsController,
            searchController: widget.searchController,
            comparisonController: widget.comparisonController,
            themeController: widget.themeController,
            settingsController: widget.settingsController,
            chatController: widget.chatController,
          ),
        );
      },
    );
  }
}

class RootRouter extends StatefulWidget {
  const RootRouter({
    super.key,
    required this.authController,
    required this.hotelsController,
    required this.bookingsController,
    required this.searchController,
    required this.comparisonController,
    required this.themeController,
    required this.settingsController,
    required this.chatController,
  });

  final AuthController authController;
  final HotelsController hotelsController;
  final BookingsController bookingsController;
  final SearchController searchController;
  final ComparisonController comparisonController;
  final ThemeController themeController;
  final SettingsController settingsController;
  final ChatController chatController;

  @override
  State<RootRouter> createState() => _RootRouterState();
}

class _RootRouterState extends State<RootRouter> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.authController,
      builder: (context, _) {
        if (!widget.authController.hasSeenOnboarding) {
          return OnboardingStoryScreen(onFinish: widget.authController.markOnboardingSeen);
        }
        if (!widget.authController.isLoggedIn) {
          return LoginScreen(authController: widget.authController);
        }
        return MainShell(
          hotelsController: widget.hotelsController,
          bookingsController: widget.bookingsController,
          searchController: widget.searchController,
          comparisonController: widget.comparisonController,
          themeController: widget.themeController,
          settingsController: widget.settingsController,
          chatController: widget.chatController,
        );
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.hotelsController,
    required this.bookingsController,
    required this.searchController,
    required this.comparisonController,
    required this.themeController,
    required this.settingsController,
    required this.chatController,
  });

  final HotelsController hotelsController;
  final BookingsController bookingsController;
  final SearchController searchController;
  final ComparisonController comparisonController;
  final ThemeController themeController;
  final SettingsController settingsController;
  final ChatController chatController;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = widget.settingsController.reduceMotion;
    return DefaultTabController(
      length: 5,
      child: Builder(builder: (context) {
        final controller = DefaultTabController.of(context);
        final children = [
          HomeTabScreen(
            hotelsController: widget.hotelsController,
            comparisonController: widget.comparisonController,
            bookingsController: widget.bookingsController,
          ).animate(target: reduceMotion ? 0 : 1).fadeIn(duration: 400.ms).slide(begin: const Offset(0.1, 0)),
          SearchTabScreen(
            hotelsController: widget.hotelsController,
            searchController: widget.searchController,
            comparisonController: widget.comparisonController,
          ).animate(target: reduceMotion ? 0 : 1).fadeIn(duration: 400.ms).slide(begin: const Offset(0.1, 0)),
          AiChatTabScreen(controller: widget.chatController),
          RewardsProfileTabScreen(bookingsController: widget.bookingsController),
          SettingsTabScreen(
            themeController: widget.themeController,
            settingsController: widget.settingsController,
            hotelsController: widget.hotelsController,
            bookingsController: widget.bookingsController,
          ),
        ];
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    children: children,
                  ),
                ),
                RoamifyTabBar(controller: controller!),
              ],
            ),
          ),
        );
      }),
    );
  }
}
