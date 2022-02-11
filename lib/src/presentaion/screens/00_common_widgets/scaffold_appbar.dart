import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaffoldAppBar extends StatelessWidget {
  const ScaffoldAppBar({Key? key, required this.titleText}) : super(key: key);
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      centerTitle: true,
      elevation: 0,
      leadingWidth: 10,
      titleSpacing: 0,
      toolbarHeight: 90,
      leading: const SizedBox(),
      title: Text(
        titleText,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
