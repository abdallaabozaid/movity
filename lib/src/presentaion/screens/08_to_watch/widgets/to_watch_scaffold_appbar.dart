import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToWatchScaffoldAppBar extends StatelessWidget {
  const ToWatchScaffoldAppBar({Key? key, required this.titleText})
      : super(key: key);
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      // leadingWidth: 10,
      toolbarHeight: 90,
      // leading: const SizedBox(),
      title: Text(
        titleText,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontFamily: 'Comforter Brush',
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
