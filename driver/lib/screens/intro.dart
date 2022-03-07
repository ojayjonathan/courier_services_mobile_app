import 'package:courier_services/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushNamed(AppRoutes.welcome);
  }

  Widget _buldImage(String assetName) {
    return Image.asset(
      "assets/images/$assetName",
      width: 350,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xff495057)),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        imagePadding: EdgeInsets.all(15),
        imageAlignment: Alignment.center,
        bodyTextStyle:
            TextStyle(color: Color(0xff495057), fontWeight: FontWeight.w400));

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "We do country wide cargo delivery",
          image: _buldImage("intro_p1.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get started",
          body: "Create an  account to get started.",
          image: _buldImage("truck.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Add a vehicle",
          body: "Upload your vehicle information",
          image: _buldImage("intro_p3_.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get notified",
          body:
              "Get notified when  a client request your services",
          image: _buldImage("intro_p3.png"),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
