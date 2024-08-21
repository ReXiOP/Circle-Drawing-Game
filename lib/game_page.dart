import 'package:flutter/material.dart';
import 'drawing_painter.dart';
import 'score_calculator.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Offset> _points = [];
  double _score = 0.0;

  final Offset _center = Offset(200, 400); // Adjust this to match your reference circle's position
  final double _radius = 100.0; // Reference circle radius

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Draw a Circle")),
      backgroundColor: Colors.black, // Deep black background color
      body: Stack(
        children: [
          // Reference Circle with white fill and "SaJid" text
          Center(
            child: Container(
              width: _radius * 2,
              height: _radius * 2,
              decoration: BoxDecoration(
                color: Colors.white, // Fill color for the reference circle
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Center(
                child: Text(
                  "SaJid",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black, // Text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Drawing Area
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _points.add(details.localPosition);
              });
            },
            onPanEnd: (details) {
              setState(() {
                _score = calculateScore(_points, _center, _radius);
              });
              _points.clear();
              _showScoreDialog();
            },
            child: CustomPaint(
              painter: DrawingPainter(_points),
              child: Container(),
            ),
          ),
          // Display Score
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Score: ${_score.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your Score'),
        content: Text('You scored ${_score.toStringAsFixed(2)} points!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
