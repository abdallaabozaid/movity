import 'package:flutter/material.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/presentaion/common_widgets/elevated_button.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/home_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage(
      {required this.currentIndex, required this.pageController, Key? key})
      : super(key: key);
  final int currentIndex;
  final PageController pageController;
  static List<String> quotes = [
    'How  you ever gonna ',
    'Until you think you have  ',
    'you can run the mile',
  ];
  static List<String> quotes2ndLine = [
    'know if you never even try ?!',
    'the time To spend an evening with me',
    'You can walk straight through hell with a smile',
  ];
  static List<String> assetImages = [
    'assets/images/on_boarding_screen/6.jpg',
    'assets/images/on_boarding_screen/5.jpg',
    'assets/images/on_boarding_screen/7.jpg',
  ];

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
            image: AssetImage(OnBoardingPage.assetImages[widget.currentIndex]),
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [0.3, 1],
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                widget.currentIndex != 2
                    ? Text(
                        OnBoardingPage.quotes[widget.currentIndex],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
                widget.currentIndex != 2
                    ? Text(
                        OnBoardingPage.quotes2ndLine[widget.currentIndex],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style:
                            const TextStyle(fontSize: 34, color: Colors.white),
                      )
                    : Container(),
                const SizedBox(
                  height: 50,
                ),
                widget.currentIndex != 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(widget.currentIndex == index
                                  ? 'assets/images/on_boarding_screen/logo.png'
                                  : 'assets/images/on_boarding_screen/logo_disapled.png'),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: widget.currentIndex != 2 ? 170 : 300,
                ),
                widget.currentIndex != 2
                    ? ElevatedButton(
                        onPressed: () {
                          widget.pageController.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.decelerate);
                        },
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 30,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 30),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.white),
                          ),
                          primary: Colors.transparent,
                        ),
                      )
                    : CommonButton(
                        labelText: 'Get Started',
                        onPressed: () {
                          Navigator.pushNamed(context, signUpScreen,
                              arguments: false);
                        },
                      ),
                widget.currentIndex == 2
                    ? const SizedBox(
                        height: 50,
                      )
                    : Container(),
                widget.currentIndex != 2
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'movity',
                            style: TextStyle(
                                fontSize: 70,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Comforter Brush'),
                          ),
                          Image(
                            width: 80,
                            height: 60,
                            image: AssetImage(
                                'assets/images/on_boarding_screen/logoo.png'),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
