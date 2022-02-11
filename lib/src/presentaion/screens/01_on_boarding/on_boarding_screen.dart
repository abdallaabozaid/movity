import 'package:flutter/material.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';
import 'package:movity/src/presentaion/screens/01_on_boarding/widgets/on_boarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        bool? willColse = false;
        willColse = await const AwareAlertDialog(
          alertContentText: 'Are you sure you want to exit ?',
          title: 'Exit confirmation ..',
          cancelText: 'cancel',
        ).show(context, isDissmissible: false);
        return willColse!;
      },
      child: Stack(children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return OnBoardingPage(
                  currentIndex: index, pageController: _pageController);
            },
          ),
        ),
      ]),
    );
  }
}
