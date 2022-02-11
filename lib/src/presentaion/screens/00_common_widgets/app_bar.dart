import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        // statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.blueGrey),
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: Text(
          'FRENZY',
          style: TextStyle(
              color: Colors.blue,
              // fontSize: 26,
              fontFamily: 'Merienda',
              fontWeight: FontWeight.w900,
              letterSpacing: 5),
        ),
      ),
      bottom: TabBar(
        labelColor: Colors.blueGrey,
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        unselectedLabelStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        indicatorWeight: 3,
        tabs: const [
          Tab(text: 'Trending'),
          Tab(text: 'Latest'),
        ],
      ),
    );
  }
}
