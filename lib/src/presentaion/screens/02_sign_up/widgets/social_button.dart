import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {Key? key, required this.onPressed, required this.iconAssetName})
      : super(key: key);
  final VoidCallback onPressed;
  final String iconAssetName;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        // width: 140,
        height: 55,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(11),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/sign_up/button_bg.jpg'),
          ),
        ),
        child: IconButton(
          icon: Image.asset(
            'assets/images/sign_up/$iconAssetName.png',
            color: const Color(0xffA9885B),
          ),
          onPressed: onPressed,
          color: const Color(0xffA9885B),
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
