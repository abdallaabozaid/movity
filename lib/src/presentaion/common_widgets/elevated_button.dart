import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key, required this.labelText, required this.onPressed})
      : super(key: key);

  final String labelText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: 330,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.goldenColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          labelText,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              wordSpacing: 1.3,
              letterSpacing: 1.5),
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        primary: Colors.transparent,
      ),
    );
  }
}
