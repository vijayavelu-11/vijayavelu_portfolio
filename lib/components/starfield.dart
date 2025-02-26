import 'dart:math';

import 'package:flutter/material.dart';

class StarfieldPainter extends CustomPainter {
  final double animationValue;
  final Random _random = Random(42); // Fixed seed for consistent star positions
  final List<Star> _stars = [];
  final List<Star> _distantStars = []; // Background layer of smaller stars

  StarfieldPainter(this.animationValue) {
    if (_stars.isEmpty) {
      // Generate stars only once
      for (int i = 0; i < 200; i++) {
        _distantStars.add(Star(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: _random.nextDouble() * 0.7,
          blinkPhase: _random.nextDouble() * 2 * pi,
          color: Colors.white,
        ));
      }
      for (int i = 0; i < 150; i++) {
        _stars.add(Star(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: _random.nextDouble() * 1.8,
          blinkPhase: _random.nextDouble() * 2 * pi,
          color: Colors.white,
        ));
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw distant stars
    for (final star in _distantStars) {
      final x = star.x * size.width;
      final y = star.y * size.height;
      final brightness = 0.3 + 0.3 * sin(animationValue * pi + star.blinkPhase);
      paint.color = star.color.withOpacity(0.2 + brightness * 0.3);
      canvas.drawCircle(Offset(x, y), star.size * (0.6 + brightness * 0.4), paint);
    }

    // Draw main stars
    for (final star in _stars) {
      final x = star.x * size.width;
      final y = star.y * size.height;
      final brightness = 0.6 + 0.4 * sin(animationValue * 2 * pi + star.blinkPhase);
      paint.color = star.color.withOpacity(0.4 + brightness * 0.6);
      canvas.drawCircle(Offset(x, y), star.size * (0.7 + brightness * 0.3), paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarfieldPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double blinkPhase;
  final Color color;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.blinkPhase,
    required this.color,
  });
}