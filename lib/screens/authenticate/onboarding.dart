import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final String asset = "assets/images/mask-woman.svg";

  @override
  Widget build(BuildContext context) {
    saveOnboarding() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("onboarding-completed", true);
    }

    double devHeight = MediaQuery.of(context).size.height;
    List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        titleWidget: Padding(
          padding: EdgeInsets.only(top: devHeight * 0.1),
          child: Text(
            "Oria",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "LobsterTwo",
                fontWeight: FontWeight.bold,
                fontSize: 50),
          ),
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Discover doctors around you and book appointments all at a reasonable cost",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/images/onboard.svg",
                fit: BoxFit.contain,
                height: devHeight * 0.5,
              ),
            ),
          ],
        ),
        decoration: const PageDecoration(
          pageColor: Color.fromRGBO(28, 40, 51, 1),
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          "Track your appointments easily",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        bodyWidget: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Easily check your appointment dates and their details",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        image: Padding(
          padding: EdgeInsets.only(top: devHeight * 0.1),
          child: Align(
            child: SvgPicture.asset(
              "assets/images/slide-2.svg",
              fit: BoxFit.contain,
              height: devHeight * 0.40,
            ),
            alignment: Alignment.bottomLeft,
          ),
        ),
        decoration: const PageDecoration(
          pageColor: Color.fromRGBO(28, 40, 51, 1),
        ),
      ),
      PageViewModel(
        decoration: const PageDecoration(
          pageColor: Color.fromRGBO(28, 40, 51, 1),
        ),
        titleWidget: Padding(
          padding: EdgeInsets.only(top: devHeight * 0.1),
          child: Text(
            "Find the nearest hospitals",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
        bodyWidget: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Easily find the nearest hospitals near you and get instant directions",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: SvgPicture.asset(
                    "assets/images/map.svg",
                    fit: BoxFit.contain,
                    height: devHeight * 0.40,
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              ),
            ],
          ),
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          "All Done!",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "LobsterTwo",
              fontWeight: FontWeight.bold,
              fontSize: 50),
        ),
        bodyWidget: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Let's Proceed to Register for Oria",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        image: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            child: SvgPicture.asset(
              "assets/images/slide-3.svg",
              fit: BoxFit.contain,
              height: devHeight * 0.40,
            ),
            alignment: Alignment.bottomLeft,
          ),
        ),
        decoration: const PageDecoration(
          pageColor: Color.fromRGBO(28, 40, 51, 1),
        ),
      )
    ];
    return Scaffold(
      body: IntroductionScreen(
        pages: listPagesViewModel,
        globalBackgroundColor: Color.fromRGBO(28, 40, 51, 1),
        onDone: () {
          // When done button is press
          saveOnboarding();
          Navigator.of(context).popAndPushNamed("/login");
        },
        onSkip: () {
          // You can also override onSkip callback
        },
        // showSkipButton: true,
        skip: const Icon(
          Icons.skip_next,
          color: Colors.white,
          size: 30,
        ),
        next: const Icon(
          Icons.arrow_right_alt,
          color: Colors.white,
          size: 30,
        ),
        done: const Text("Finish",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                fontSize: 20)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.white,
            color: Colors.white30,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
