import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Developer Info"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: RainbowWaveText(
            text: """
Muhammad Sajid
Student of Model Institute of Science & Technology (MIST), CSE
""",
            link: "https://www.facebook.com/0x0sajid/",
          ),
        ),
      ),
    );
  }
}

class RainbowWaveText extends StatefulWidget {
  final String text;
  final String link;

  RainbowWaveText({required this.text, required this.link});

  @override
  _RainbowWaveTextState createState() => _RainbowWaveTextState();
}

class _RainbowWaveTextState extends State<RainbowWaveText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -10, end: 10).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: RainbowWaveTextPainter(_animation.value),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'ComicSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Open the Facebook link in a web browser
                      launch(widget.link);
                    },
                    child: Text(
                      widget.link,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RainbowWaveTextPainter extends CustomPainter {
  final double offset;
  final List<Color> rainbowColors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple];

  RainbowWaveTextPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final textPainter = TextPainter(
      text: TextSpan(
        text: "Muhammad Sajid\nStudent of Model Institute of Science & Technology (MIST), CSE",
        style: TextStyle(
          fontSize: 0,
          color: Colors.white,
          fontFamily: 'ComicSans',
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    final path = Path();
    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    for (double y = 0; y < textHeight; y += 20) {
      path.moveTo(0, y + offset);
      path.lineTo(textWidth, y + offset);
    }

    paint.shader = LinearGradient(
      colors: rainbowColors,
      stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
