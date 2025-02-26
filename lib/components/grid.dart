
import 'dart:math';

import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double scrollOffset;
  final double mouseX;
  final double mouseY;
  final double animationValue;

  GridPainter({
    required this.scrollOffset,
    required this.mouseX,
    required this.mouseY,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gridSize = 40.0;
    final waveAmplitude = 20.0; // Amplitude of the wave effect
    final mouseInfluenceRadius = 150.0; // Radius of mouse influence
    final mouseInfluenceStrength = 100.0; // Strength of mouse influence

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withOpacity(0.1);

    // Draw horizontal lines with wave effect
    for (double y = 0; y < size.height; y += gridSize) {
      final path = Path();
      bool started = false;

      for (double x = 0; x < size.width; x += 5) {
        // Calculate distance from mouse
        final dx = x - mouseX;
        final dy = y - mouseY;
        final distanceFromMouse = sqrt(dx * dx + dy * dy);

        // Calculate wave effect based on mouse position
        final waveEffect = distanceFromMouse < mouseInfluenceRadius
            ? mouseInfluenceStrength *
                (1 - distanceFromMouse / mouseInfluenceRadius) *
                sin((x + scrollOffset) * 0.01)
            : 0.0;

        final yPos = y + waveEffect;

        if (!started) {
          path.moveTo(x, yPos);
          started = true;
        } else {
          path.lineTo(x, yPos);
        }
      }

      canvas.drawPath(path, paint);
    }

    // Draw vertical lines with wave effect
    for (double x = 0; x < size.width; x += gridSize) {
      final path = Path();
      bool started = false;

      for (double y = 0; y < size.height; y += 5) {
        // Calculate distance from mouse
        final dx = x - mouseX;
        final dy = y - mouseY;
        final distanceFromMouse = sqrt(dx * dx + dy * dy);

        // Calculate wave effect based on mouse position
        final waveEffect = distanceFromMouse < mouseInfluenceRadius
            ? mouseInfluenceStrength *
                (1 - distanceFromMouse / mouseInfluenceRadius) *
                sin((y + scrollOffset) * 0.01)
            : 0.0;

        final xPos = x + waveEffect;

        if (!started) {
          path.moveTo(xPos, y);
          started = true;
        } else {
          path.lineTo(xPos, y);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.scrollOffset != scrollOffset ||
        oldDelegate.mouseX != mouseX ||
        oldDelegate.mouseY != mouseY ||
        oldDelegate.animationValue != animationValue;
  }
}