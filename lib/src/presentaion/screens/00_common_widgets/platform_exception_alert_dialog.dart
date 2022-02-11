import 'package:flutter/services.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';

class PlatformExceptionAlertDialog extends AwareAlertDialog {
  PlatformExceptionAlertDialog({
    required String title,
    required PlatformException platformE,
  }) : super(
          alertContentText: _message(platformE),
          title: title,
        );

  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message!;
  }

  // ignore: prefer_final_fields
  static Map<String, String> _errors = {
    'invalid-email': 'بقى دا ايميل ',
    'user-disabled':
        'hrown if the user corresponding to the given email has been disabled.',
    'user-not-found': 'User not found .. ',
    'wrong-password': 'Wrong password',
    'email-already-in-use': 'email-already-in-use',
    'operation-not-allowed': 'invalid-email',
    'weak-password': 'weak-password',
  };
}
