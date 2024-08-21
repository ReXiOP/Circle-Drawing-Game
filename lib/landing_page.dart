import 'package:flutter/material.dart';
import 'dart:math'; // Import this for random number generation
import 'game_page.dart'; // Import the GamePage to navigate to it
import 'developer_info_page.dart'; // Import the Developer Info Page

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: RainbowCirclesAnimation(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Can you draw a",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: 'ComicSans',
                  ),
                ),
                Text(
                  "PERFECT CIRCLE?",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'ComicSans',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.white, // Button color
                    foregroundColor: Colors.black, // Text color
                  ),
                  child: Text(
                    "GO",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeveloperInfoPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(22),
                    backgroundColor: Colors.white, // Button color
                    foregroundColor: Colors.black, // Text color
                  ),
                  child: Text(
                    "Developer\n     Info",
                    style: TextStyle(fontSize: 15),
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

class RainbowCirclesAnimation extends StatefulWidget {
  @override
  _RainbowCirclesAnimationState createState() => _RainbowCirclesAnimationState();
}

class _RainbowCirclesAnimationState extends State<RainbowCirclesAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20), // Longer duration for slower animation
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RainbowCirclesPainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class RainbowCirclesPainter extends CustomPainter {
  final double animationValue;
  final List<Color> rainbowColors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple];
  final int numCircles = 10;

  RainbowCirclesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final random = Random();

    for (int i = 0; i < numCircles; i++) {
      paint.color = rainbowColors[i % rainbowColors.length].withOpacity(0.5);

      // Calculate circle radius based on animation value
      final radius = (animationValue * (size.width / 2)).clamp(0.0, size.width / 2);

      // Randomize circle position
      final center = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
