import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/initialInfo/firstpage.dart';
import 'package:pravesh_screen/initialInfo/secondpage.dart';
import 'package:pravesh_screen/initialInfo/thirdpage.dart';
import 'package:pravesh_screen/widgets/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pravesh_screen/home_screen.dart'; // <-- Add this import at top if not present

class IntroPages extends StatefulWidget {
  const IntroPages({super.key});

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final newPage = _controller.page?.round() ?? 0;
      if (newPage != currentPage) {
        setState(() {
          currentPage = newPage;
        });
      }
    });
  }

  void nextPage() {
    if (currentPage < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // On last page → navigate somewhere else if needed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final colors = appColors(context);

    return Scaffold(
      body: Container(
        color: IntroBackground,
        child: Stack(
          children: [
            // PageView
            PageView(
              controller: _controller,
              physics: const ClampingScrollPhysics(),
              clipBehavior: Clip.none,
              padEnds: false,
              children: [
                Material(color: IntroBackground, child: Firstpage()),
                Material(color: IntroBackground, child: Secondpage()),
                Material(color: IntroBackground, child: Thirdpage()),
              ],
            ),

            // Page Indicator
            Positioned(
              left: width * 0.375,
              bottom: height * 0.15,
              child: SizedBox(
                width: width * 0.25,
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 1.5,
                    dotWidth: width * 0.025,
                    dotHeight: height * 0.012,
                    spacing: width * 0.02,
                    dotColor: colors.grey,
                    activeDotColor: colors.green,
                    strokeWidth: width * 0.002,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
              ),
            ),

            // Arrow Buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Arrow
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: currentPage == 0 ? colors.grey : colors.green,
                      size: width * 0.07,
                    ),
                    onPressed:
                        currentPage == 0 ? null : () => previousPage(),
                  ),

                  // Forward Arrow
                  IconButton(
                    icon: Icon(
                      currentPage == 2
                          ? Icons.check_circle_outline
                          : Icons.arrow_forward_ios,
                      color: colors.green,
                      size: width * 0.07,
                    ),
                    onPressed: () => nextPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
