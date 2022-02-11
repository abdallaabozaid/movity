import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/scaffold_appbar.dart';

class AnonNewUserScreen extends StatelessWidget {
  const AnonNewUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit auth = BlocProvider.of<AuthCubit>(context);

    // final BaseUser user = auth.userModel!;
    return Scaffold(
      appBar: PreferredSize(
        child: const ScaffoldAppBar(titleText: 'Welcome anon'),
        preferredSize: Size(MediaQuery.of(context).size.width, 90),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout_rounded),
        backgroundColor: AppColors.goldenColor,
        onPressed: () {
          _confirmSignOut(context, auth);
        },
      ),
      body: Center(
        child: Text(
          'Welcome Anon .. ',
          style: TextStyle(color: AppColors.goldenColor, fontSize: 40),
        ),
      ),
    );
  }

  void _signOut(BuildContext context, AuthCubit auth) async {
    try {
      await auth.signOut();
      print('sign out');
    } on PlatformException catch (e) {
      AwareAlertDialog(
              alertContentText: e.message.toString(), title: 'Logging out .. ')
          .show(context, isDissmissible: false);
    }
  }

  Future<void> _confirmSignOut(BuildContext context, AuthCubit auth) async {
    print('confrirm sign out');
    final signOutConfirmationResult = await const AwareAlertDialog(
      alertContentText: 'Are you sure you want to log out ? ',
      title: 'Logging out .. ',
      cancelText: 'Cancel',
    ).show(context, isDissmissible: false);

    if (signOutConfirmationResult == true) {
      _signOut(context, auth);
      Navigator.pushReplacementNamed(context, signUpScreen);
    }
  }
}
