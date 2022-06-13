import 'package:flutter/material.dart';

import '../utils/Strings.dart';
import 'home_page.dart';

class IntroPage extends StatefulWidget {
  static final String id = "intro_page";

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          currentIndex == 2?Container(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, HomePage.id);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20, left: 20, bottom: 55),
                child: Text(
                  'Skip',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ): SizedBox.shrink(),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              makePage(
                  image: 'assets/images/image_1.png',
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent),
              makePage(
                  reverse: true,
                  image: 'assets/images/image_2.png',
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent),
              makePage(
                  image: 'assets/images/image_3.png',
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent),
            ],
          ),
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}