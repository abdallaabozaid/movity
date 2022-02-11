import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/settings.png',
                height: 20,
                width: 18,
              ),
              Text(
                '  General',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.goldenColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: RichText(
            text: TextSpan(
              text: 'About App',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.appGrey,
                fontFamily: 'Crete Round',
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showModalSheet(context);
                },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _confirmSignOut(context),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff8E99AF),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.appGrey.withOpacity(0.8),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Made with Love .. '),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.goldenColor,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Close'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _signOut(BuildContext context) async {
    final AuthCubit _auth = BlocProvider.of<AuthCubit>(context);

    try {
      await _auth.signOut();
    } on PlatformException catch (e) {
      AwareAlertDialog(
              alertContentText: e.message.toString(), title: 'Logging out .. ')
          .show(context, isDissmissible: false);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final signOutConfirmationResult = await const AwareAlertDialog(
      alertContentText: 'Are you sure you want to log out ? ',
      title: 'Logging out .. ',
      cancelText: 'Cancel',
    ).show(context, isDissmissible: false);

    if (signOutConfirmationResult == true) {
      _signOut(context);
      Navigator.pushNamedAndRemoveUntil(context, signUpScreen, (route) => false,
          arguments: true);
    }
  }
}
