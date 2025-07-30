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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // ✅ Back works now
          },
        ),
        title: const Text(
          'Capture Visitor Photo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Subtitle
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  'Take a photo of the visitor for identification',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Dashed border photo placeholder
            _DashedBorder(
              strokeWidth: 2,
              color: Colors.white.withOpacity(0.4),
              radius: const Radius.circular(20),
              dashPattern: const [10, 8],
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  color: placeholderColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white.withOpacity(0.5),
                  size: 100,
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Position visitor in frame and capture photo',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Capture Photo Button
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt_rounded, size: 22),
              label: const Text('Capture Photo'),
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
                minimumSize: const Size(220, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashed Border Widget
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

// Dashed Border Painter
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
