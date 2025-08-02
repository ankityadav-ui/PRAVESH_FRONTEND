// Refactored visitor_photo.dart for responsiveness
import 'dart:ui' show PathMetric, PathMetrics;
import 'package:flutter/material.dart';
import 'package:pravesh_screen/guard/visitor_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor Photo Capture',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 52, 59, 72),
        fontFamily: 'Inter',
      ),
      home: const CaptureVisitorPhotoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CaptureVisitorPhotoScreen extends StatelessWidget {
  const CaptureVisitorPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color secondaryTextColor = Color(0xFF9E9E9E);
    const Color placeholderColor = Color(0xFF273348);
    const Color accentGreen = Color(0xFF34D17B);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Capture Visitor Photo',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: screenWidth * 0.01),
                  child: Text(
                    'Take a photo of the visitor for identification',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.15),
              _DashedBorder(
                strokeWidth: 2,
                color: Colors.white.withOpacity(0.4),
                radius: const Radius.circular(20),
                dashPattern: const [10, 8],
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: placeholderColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white.withOpacity(0.5),
                      size: screenWidth * 0.25,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.06),
              Text(
                'Position visitor in frame and capture photo',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: screenWidth * 0.035,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.08),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt_rounded, size: screenWidth * 0.055),
                label: Text('Capture Photo', style: TextStyle(fontSize: screenWidth * 0.04)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VisitorInformationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: accentGreen,
                  minimumSize: Size(screenWidth * 0.55, screenWidth * 0.13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashed Border Widget (No changes needed, already responsive)
class _DashedBorder extends StatelessWidget {
  const _DashedBorder({
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.radius = Radius.zero,
    this.dashPattern = const [3, 1],
  });

  final Widget child;
  final Color color;
  final double strokeWidth;
  final Radius radius;
  final List<double> dashPattern;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedPathPainter(
        color: color,
        strokeWidth: strokeWidth,
        radius: radius,
        dashPattern: dashPattern,
      ),
      child: child,
    );
  }
}

// Dashed Border Painter (No changes needed)
class _DashedPathPainter extends CustomPainter {
  _DashedPathPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.dashPattern,
  });

  final Color color;
  final double strokeWidth;
  final Radius radius;
  final List<double> dashPattern;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        radius,
      ));

    Path dashPath = _createDashedPath(path, dashPattern);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path originalPath, List<double> dashPattern) {
    final Path dest = Path();
    final PathMetrics metrics = originalPath.computeMetrics();

    for (final PathMetric metric in metrics) {
      double distance = 0.0;
      int dashIndex = 0;
      while (distance < metric.length) {
        final double len = dashPattern[dashIndex % dashPattern.length];
        if (dashIndex % 2 == 0) {
          dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
        }
        distance += len;
        dashIndex++;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}