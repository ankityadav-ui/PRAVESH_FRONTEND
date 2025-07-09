import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/initialInfo/firstpage.dart';
import 'package:pravesh_screen/initialInfo/secondpage.dart';
import 'package:pravesh_screen/initialInfo/thirdpage.dart';
import 'package:pravesh_screen/widgets/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPages extends StatefulWidget {
  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final PageController _controller = PageController();

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
            // Main PageView
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
              left: width * 0.375, // Centering it with some flexibility
              bottom: height * 0.15,
              child: SizedBox(
                width: width * 0.25, // Container width for indicator space
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
          ],
        ),
      ),
    );
  }
}
