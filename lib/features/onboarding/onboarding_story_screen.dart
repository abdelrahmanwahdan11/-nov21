import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/localization/app_localizations.dart';

class OnboardingPageModel {
  const OnboardingPageModel({required this.title, required this.body, required this.image});

  final String title;
  final String body;
  final String image;
}

class OnboardingStoryScreen extends StatefulWidget {
  const OnboardingStoryScreen({super.key, required this.onFinish});

  final Future<void> Function() onFinish;

  @override
  State<OnboardingStoryScreen> createState() => _OnboardingStoryScreenState();
}

class _OnboardingStoryScreenState extends State<OnboardingStoryScreen> {
  late final PageController _controller;
  int _index = 0;
  Timer? _timer;

  List<OnboardingPageModel> _pages(BuildContext context) => [
        const OnboardingPageModel(
          title: 'Curated stays',
          body: 'Discover hotels with earthy palettes, botanical lobbies and AI powered itineraries.',
          image: 'https://images.unsplash.com/photo-1489515217757-5fd1be406fef',
        ),
        const OnboardingPageModel(
          title: 'Live comparisons',
          body: 'Compare suites, rewards, price trends and hidden perks instantly.',
          image: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1',
        ),
        const OnboardingPageModel(
          title: 'AI travel companion',
          body: 'Chat with Roamify to craft bespoke journeys infused with local culture.',
          image: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        ),
      ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final pages = _pages(context);
      if (_index < pages.length - 1) {
        _index++;
        _controller.animateToPage(_index, duration: 400.ms, curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final pages = _pages(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await widget.onFinish();
                },
                child: Text(t.translate('skip')),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _index = value),
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(page.image, fit: BoxFit.cover),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          page.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                        ).animate().fadeIn(duration: 500.ms).slide(begin: const Offset(0, 0.2)),
                        const SizedBox(height: 12),
                        Text(
                          page.body,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: 300.ms,
                  width: _index == i ? 32 : 8,
                  height: 8,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _index == i ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _controller.nextPage(duration: 400.ms, curve: Curves.easeOut),
                      child: Text(t.translate('next')),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await widget.onFinish();
                      },
                      child: Text(t.translate('get_started')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
