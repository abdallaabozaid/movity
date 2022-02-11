import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FormTrailing extends StatelessWidget {
  const FormTrailing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Color(0xff9C9C9C)),
        children: [
          const TextSpan(
            text: 'Already have an account ?  ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: 'Login',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('tapped');
                })
        ],
      ),
    );
  }
}
