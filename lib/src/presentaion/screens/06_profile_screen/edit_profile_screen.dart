import 'package:flutter/material.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/scaffold_appbar.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/edit_form.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/edit_profile_header.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.isNew}) : super(key: key);

  final bool isNew;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? willColse = false;
        willColse = await AwareAlertDialog(
          alertContentText: isNew
              ? 'Skip now ?'
              : 'If you go back changes won\'t be saved  ?',
          title: isNew ? 'Skipping ' : 'Warning ..',
          cancelText: 'cancel',
        ).show(context, isDissmissible: false);

        if (isNew) {
          Navigator.pushReplacementNamed(context, homeScreen);

          return true;
        } else {
          return willColse!;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          child: ScaffoldAppBar(
            titleText: isNew ? 'Compelete your proflie' : 'Edit your profile',
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 90),
        ),
        body: SingleChildScrollView(
          // controller: controller,
          child: Column(
            children: [
              EditProfileHeader(),
              EditProfileForm(isNew: isNew),
            ],
          ),
        ),
      ),
    );
  }
}
