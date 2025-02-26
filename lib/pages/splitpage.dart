import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vijayavelu_portfolio/components/caed.dart';
import 'package:vijayavelu_portfolio/components/grid.dart';
import 'package:vijayavelu_portfolio/components/starfield.dart';
import 'package:vijayavelu_portfolio/pages/footer.dart';

class SplitScreenLayout extends StatefulWidget {
  const SplitScreenLayout({super.key});

  @override
  _SplitScreenLayoutState createState() => _SplitScreenLayoutState();
}

class _SplitScreenLayoutState extends State<SplitScreenLayout>
    with SingleTickerProviderStateMixin {
  double scrollOffset = 0.0;
  double mouseX = 0.0;
  double mouseY = 0.0;
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  // Define the projects list inside the class
  final List<Project> projects = [
    Project(
      name: 'PROJECT - VIZUUU - BOT',
      description: 'Vizuu - AI Assistance is your all-in-one intelligent assistant, merging advanced AI with the ease of voice commands and the creativity of image generation.',
    ),
    Project(
      name: 'FASHIO - AI ',
      description: 'Struggling to put together the perfect outfit? Our app uses cutting-edge AI to create personalized fashion suggestions for any occasion. Simply share your style preferences, and our AI, powered by Gemini, will recommend looks that flatter you and boost your confidence.',
    ),
    Project(
      name: 'GOOGLE CLONE',
      description: 'I am excited to share my latest project—a Google clone built using Flutter for both web and mobile platforms! This cross-platform application ensures a seamless user experience across all devices, leveraging Flutter robust framework.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Function to launch the resume URL
  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            mouseX = event.position.dx;
            mouseY = event.position.dy;
          });
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              setState(() {
                scrollOffset = scrollNotification.metrics.pixels;
              });
            }
            return true;
          },
          child: Stack(
            children: [
              // Background Effects Layer with Parallax
              Positioned(
                top: -scrollOffset * 0.5,
                child: RepaintBoundary(
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF121212),
                              Color(0xFF050505),
                            ],
                          ),
                        ),
                      ),
                      CustomPaint(
                        size: Size(screenWidth, screenHeight * 2),
                        painter: StarfieldPainter(_animationController.value),
                      ),
                      CustomPaint(
                        size: Size(screenWidth, screenHeight * 2),
                        painter: GridPainter(
                          scrollOffset: scrollOffset,
                          mouseX: mouseX,
                          mouseY: mouseY,
                          animationValue: _animationController.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              

              // Content Layer - Split Screen Layout
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Split Screen Content
                    SizedBox(
                      height: screenHeight,
                      child: isMobile
                          ? Column(
                              children: [
                                // Left Side Content for Mobile
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hey There,',
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: isMobile ? 40 : 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'I am Vijayavelu,',
                                          style: GoogleFonts.lato(
                                            color: Colors.grey,
                                            fontSize: isMobile ? 40 : 60,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Flutter developer',
                                          style: GoogleFonts.lato(
                                            color: Colors.blueAccent,
                                            fontSize: isMobile ? 40 : 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Passionate and skilled Flutter Developer with expertise in building high-performance, cross-platform mobile applications for Android, iOS, and web. Proficient in creating visually stunning, responsive, and user-friendly interfaces using Flutters rich widget library and animations. Experienced in state management (Provider, Bloc, Riverpod), API integration, Firebase services, and testing. Dedicated to delivering scalable, maintainable, and efficient solutions that provide seamless user experiences across all platforms.',
                                          style: GoogleFonts.lato(
                                            color: Color.fromARGB(179, 255, 255, 255),
                                            fontSize: isMobile ? 12 : 13,
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                                // Right Side Rotating Images for Mobile
                                Expanded(
                                  child: RepaintBoundary(
                                    child: RotatingImagesAroundCenterImage(),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                // Left Side Content for Desktop
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(40),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hey There,',
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'I am Vijayavelu,',
                                          style: GoogleFonts.lato(
                                            color: Colors.grey,
                                            fontSize: 60,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Flutter developer',
                                          style: GoogleFonts.lato(
                                            color: Colors.blueAccent,
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Passionate and skilled Flutter Developer with expertise in building high-performance, cross-platform mobile applications for Android, iOS, and web. Proficient in creating visually stunning, responsive, and user-friendly interfaces using Flutters rich widget library and animations. Experienced in state management (Provider, Bloc, Riverpod), API integration, Firebase services, and testing. Dedicated to delivering scalable, maintainable, and efficient solutions that provide seamless user experiences across all platforms.',
                                          style: GoogleFonts.lato(
                                            color: Color.fromARGB(179, 255, 255, 255),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Right Side Rotating Images for Desktop
                                Expanded(
                                  flex: 1,
                                  child: RepaintBoundary(
                                    child: RotatingImagesAroundCenterImage(),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    // 3D Project Cards
                    ...projects.map((project) {
                      int index = projects.indexOf(project);
                      double cardScrollOffset = scrollOffset - (index * 600);
                      double opacity = (cardScrollOffset / 600).clamp(0.0, 1.0);
                      double rotation = (cardScrollOffset / 600).clamp(-0.2, 0.2);

                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // Perspective
                          ..rotateY(rotation),
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: opacity,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.name,
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: isMobile ? screenWidth * 0.8 : 800,
                                    child: Text(
                                      project.description,
                                      style: GoogleFonts.lato(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 80),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // Footer
                    const Footer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class RotatingImagesAroundCenterImage extends StatefulWidget {
  const RotatingImagesAroundCenterImage({super.key});

  @override
  _RotatingImagesAroundCenterImageState createState() =>
      _RotatingImagesAroundCenterImageState();
}

class _RotatingImagesAroundCenterImageState
    extends State<RotatingImagesAroundCenterImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<String> images = [
    'lib/images/flutterlogo.png',
    'lib/images/bloclogo.png',
    'lib/images/supabaselogo.png',
    'lib/images/firebaselogo.png',
    'lib/images/androidstd.png',
    'lib/images/javaimgg.png',
    'lib/images/github.png',
    'lib/images/dart.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    // Adjust the radius based on screen size
    double radius = isMobile ? screenWidth * 0.3 : 200; // Smaller radius for mobile

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating Images Around the Center Image
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: List.generate(images.length, (index) {
                  final angle = (2 * pi / images.length) * index +
                      (_controller.value * 2 * pi);
                  // Calculate positions dynamically based on screen size
                  final x = radius * cos(angle);
                  final y = radius * sin(angle);

                  return Transform.translate(
                    offset: Offset(x, y),
                    child: Image.asset(
                      images[index],
                      width: isMobile ? 30 : 50, // Smaller images for mobile
                      height: isMobile ? 30 : 50,
                    ),
                  );
                }),
              );
            },
          ),
          // Central Image (Static)
          Container(
            width: isMobile ? 150 : 250, // Smaller central image for mobile
            height: isMobile ? 150 : 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage('lib/images/vijayimage.png'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey.shade300, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}