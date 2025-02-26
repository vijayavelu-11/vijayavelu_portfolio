import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:html' as html;

class Footer extends StatelessWidget {
  const Footer({super.key});

  // Web-specific URL launcher
  void _launchURL(String url) {
    html.window.open(url, '_blank'); // Opens in a new tab
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 83, 83, 85).withOpacity(0.8),
            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          // Social Media Lottie Animations with Hover Cursor
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click, // Change cursor on hover
                child: GestureDetector(
                  onTap: () => _launchURL('https://github.com/vijayavelu-11'),
                  child: Lottie.asset(
                    'lib/images/github.json',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchURL('https://www.instagram.com/_guru_nadha_11?igsh=MW1pNDdlNGZyODEybQ=='),
                  child: Lottie.asset(
                    'lib/images/instagram.json',
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchURL('https://www.linkedin.com/in/vijayavelu-v/'),
                  child: Lottie.asset(
                    'lib/images/linkedin.json',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Copyright Notice
          const Text(
            '© 2023 Vijayavelu. All rights reserved.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          // Centered "Built using flutter💙" Text
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the Row contents
              children: const [
                Text(
                  'Built using ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  ' Flutter💙',
                  style: TextStyle(
                    color: Color.fromARGB(255, 69, 95, 243),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
