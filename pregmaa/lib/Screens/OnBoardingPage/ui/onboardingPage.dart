import 'package:flutter/material.dart';
import 'package:pregmaa/Theme/ColorsPallet/Colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboardingpage extends StatefulWidget {
  const Onboardingpage({super.key});

  @override
  State<Onboardingpage> createState() => _OnboardingpageState();
}

class _OnboardingpageState extends State<Onboardingpage> {
  PageController _pageController = PageController();
  bool isLastPage = true;
  bool isFirstPage = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colorspalette.white,

      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 4;
                isFirstPage = index == 0;
              });
            },
            children: [
              _builtPageIdicator(
                images: 'assets/images/onBoardingImages/img1.png',
                logo: 'assets/images/onBoardingImages/pregamaa.png',
                text: 'Welcome',
                subText:
                    'Welcome to PregaMaa,\n A New Hope for Pregnant Women of India',
              ),
              _builtPageIdicator(
                images: 'assets/images/onBoardingImages/img2.png',
                logo: 'assets/images/onBoardingImages/pregamaa.png',
                text: 'Tracking Tools',
                subText:
                    'The app will provide tracking tools to help\nusersmonitor their prgnancy and postpartum\nprogress,including weight tracking,contraction\ntiming and breastfeeding tracker.',
              ),
              _builtPageIdicator(
                images: 'assets/images/onBoardingImages/img3.png',
                logo: 'assets/images/onBoardingImages/pregamaa.png',
                text: 'Educational Resources',
                subText:
                    'The app will provide educational resources\nto help users learn about maternal health\nincluding articles,videos and podcasts.',
              ),

              _builtPageIdicator(
                images: 'assets/images/onBoardingImages/img1.png',
                logo: 'assets/images/onBoardingImages/pregamaa.png',
                text: 'Community Support',
                subText:
                    'The app will provide a community support\nfeature to help users connect with other\nusers share experiences, and receive support.',
              ),
            ],
          ),

          Positioned(
            bottom: size.height * 0.027,
            left: size.width * 0.40,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 4,
              effect: ExpandingDotsEffect(
                activeDotColor: Colorspalette.indexColor,
                dotHeight: 15,
                dotWidth: 8,
                dotColor: Colors.grey,
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.01,
            left: 10,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'SKIP',
                style: TextStyle(fontSize: 20, color: Colorspalette.textColor),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.01,
            right: 10,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'NEXT',
                style: TextStyle(fontSize: 20, color: Colorspalette.textColor),
              ),
            ),
          ),
          isLastPage
              ? Positioned(
                  bottom: size.height * 0.1,
                  left: 20,
                  right: 20,

                  child: Container(
                    width: size.width * 0.5,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colorspalette.indexColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colorspalette.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  //page indicator widget
  Widget _builtPageIdicator({
    required String images,
    required String logo,
    required String text,
    required String subText,
  }) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        isFirstPage
            ? Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Container(
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  child: Image.asset(logo),
                ),
              )
            : Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Container(
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  child: Row(
                    children: [
                      Text(
                        "Tracking",
                        style: TextStyle(color: Colorspalette.textColor),
                      ),
                    ],
                  ),
                ),
              ),
        Positioned(
          top: size.height * 0.189,
          left: 20,
          right: 20,

          child: Center(
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.3,
              child: Image.asset(images),
            ),
          ),
        ),
        isFirstPage
            ? Positioned(
                bottom: size.height * 0.41,
                left: 20,
                right: 20,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colorspalette.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : SizedBox(),
        Positioned(
          bottom: size.height * 0.25,
          left: 20,
          right: 20,
          child: Text(
            subText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colorspalette.textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
