import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        width: 200,
        height: 200,
        image: AssetImage('assets/images/common/loading_circle.gif'),
      ),
    );
  }
}
