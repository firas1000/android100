// filepath: lib/visual_effects_background.dart // Example file path
import 'package:flutter/material.dart';
import 'package:animated_glitch/animated_glitch.dart'; // Import the package
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'dart:async';

void main() {
  runApp(const MyApp());
}

// Convert MyApp to StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClockScreen(),
    );
  }
}

class VisualEffectsBackground extends StatefulWidget {
  const VisualEffectsBackground({super.key});

  @override
  State<VisualEffectsBackground> createState() => _VisualEffectsBackgroundState();
}

class _VisualEffectsBackgroundState extends State<VisualEffectsBackground> {
  late final AnimatedGlitchController _glitchController;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimatedGlitchController(
      frequency: const Duration(milliseconds: 400),
      level: 3.0,
      distortionShift: const DistortionShift(count: 5),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _glitchController.start();
      }
    });
  }

  @override
  void dispose() {
    _glitchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGlitch(
      controller: _glitchController,
      filters: [
        GlitchColorFilter(
          blendMode: BlendMode.color,
          color: Colors.black,
        )
      ],
      child: Container(
        color: const Color(0xFF040a1a),
        constraints: const BoxConstraints.expand(),
      ),
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  String _timeString = '';
  bool _isVisible = true;
  late final AnimatedGlitchController _glitchController;
  Timer? _timeTimer;
  Timer? _visibilityTimer;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timeTimer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    _visibilityTimer = Timer.periodic(Duration(seconds: 2), (Timer t) => _toggleVisibility());

    _glitchController = AnimatedGlitchController(
      frequency: const Duration(milliseconds: 400),
      level: 3.0,
      distortionShift: const DistortionShift(count: 5),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _glitchController.start();
      }
    });
  }

  @override
  void dispose() {
    _timeTimer?.cancel();
    _visibilityTimer?.cancel();
    _glitchController.dispose();
    super.dispose();
  }

  void _getTime() {
    if (!mounted) return;
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  void _toggleVisibility() {
    if (!mounted) return;
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock App'),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: VisualEffectsBackground(),
          ),
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(_isVisible ? 8.0 : 40.0),
              decoration: BoxDecoration(
                color: _isVisible ? Colors.transparent : Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _isVisible ? 1.0 : 0.0,
                child: AnimatedGlitch(
                  controller: _glitchController,
                  filters: [
                    GlitchColorFilter(
                      blendMode: BlendMode.color,
                      color: Colors.black,
                    )
                  ],
                  child: Center(
                    child: Text(
                      _timeString,
                      style: GoogleFonts.geostar(
                        fontSize: 48,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
