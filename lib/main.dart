import 'package:flutter/material.dart';
import 'pages/languageselect.dart';
import './pages/menu.dart'; // Import MenuPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Loading Screen',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  final String language; // Pass the selected language

  const LoadingScreen({super.key, required this.language});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sizeAnimation;
  late final Animation<double> _rotationAnimation;

  final Map<String, String> _translations = {
    'en': 'Loading...',
    'fr': 'Chargement...',
    'es': 'Cargando...',
    'de': 'Wird geladen...',
    'it': 'Caricamento...',
    'pt': 'Carregando...',
    'ru': 'Загрузка...',
    'zh': '加载中...',
    'ja': '読み込み中...',
  };

  String _getLoadingText(String languageCode) {
    return _translations[languageCode] ?? _translations['en']!;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // No reverse, continuous rotation in one direction

    _sizeAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 50.0, end: 100.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 100.0, end: 50.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // Delay navigation to MenuPage by 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Positioned widget to keep the text fixed
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                _getLoadingText(widget.language),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          // Positioned widget for the animated circle
          Positioned.fill(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 2.0 * 3.141592653589793,
                    child: Container(
                      width: _sizeAnimation.value,
                      height: _sizeAnimation.value,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                            Colors.purple,
                            Colors.red,
                          ],
                          stops: [0.0, 0.16, 0.32, 0.48, 0.64, 0.8, 1.0],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
