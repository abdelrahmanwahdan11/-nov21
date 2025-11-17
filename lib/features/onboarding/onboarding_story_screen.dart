import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/primary_button.dart';

class OnboardingStoryScreen extends StatefulWidget {
  const OnboardingStoryScreen({super.key, required this.onFinish});

  final VoidCallback onFinish;

  @override
  State<OnboardingStoryScreen> createState() => _OnboardingStoryScreenState();
}

class _OnboardingStoryScreenState extends State<OnboardingStoryScreen> {
  final PageController _controller = PageController();
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_index < 2) {
        _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
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
    final t = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final pages = [
      _OnboardingPage(
        title: t.translate('welcome'),
        description: 'Discover immersive stays with AI guidance.',
        image: 'https://images.unsplash.com/photo-1501117716987-c8e1ecb210af',
      ),
      _OnboardingPage(
        title: 'Compare & book',
        description: 'Check prices, amenities and book locally.',
        image: 'https://images.unsplash.com/photo-1507679799987-c73779587ccf',
      ),
      _OnboardingPage(
        title: 'Chat with Roamify',
        description: 'Ask the bot for tailored picks.',
        image: 'https://images.unsplash.com/photo-1501119990246-6c8744b3205e',
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _index = i),
                itemCount: pages.length,
                itemBuilder: (_, i) => pages[i],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (i) {
                final active = i == _index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.all(4),
                  width: active ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? Theme.of(context).primaryColor : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: PrimaryButton(
                text: _index == pages.length - 1 ? 'Get started' : 'Next',
                onPressed: () {
                  if (_index == pages.length - 1) {
                    widget.onFinish();
                  } else {
                    _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.title, required this.description, required this.image});
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(image, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.5)],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(description, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
