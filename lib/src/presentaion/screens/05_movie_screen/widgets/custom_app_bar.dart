import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/presentaion/common_widgets/common_text_widget.dart';
import 'package:movity/src/presentaion/screens/05_movie_screen/widgets/header_image.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar(
      {Key? key, required this.movieImg, required this.title})
      : super(key: key);
  final String movieImg;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      flexibleSpace: HeaderImage(movieImg: movieImg),
      expandedHeight: 300,
      collapsedHeight: 30,
      toolbarHeight: 30,
      iconTheme: IconThemeData(color: AppColors.goldenColor, size: 30),

      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      floating: true,
      // pinned: true,
      // snap: true,
      // stretch: true,
      bottom: PreferredSize(
        child: CommonTextWidget(text: title, color: Colors.white, size: 36),
        preferredSize: const Size(double.infinity, 100),
      ),
      // pinned: true,
    );
  }
}
