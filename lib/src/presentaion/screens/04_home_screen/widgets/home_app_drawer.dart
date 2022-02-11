import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/model/user_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';

class HomeAppDrawer extends StatelessWidget {
  const HomeAppDrawer({Key? key, required this.currentScreen})
      : super(key: key);
  final int currentScreen;

  @override
  Widget build(BuildContext context) {
    final UserModel _currentUser = AuthCubit.userModel!;

    return Drawer(
      backgroundColor: Colors.black54,
      child: Column(
        children: [
          _headerStack(_currentUser),
          _buildDrawerOption(
            context,
            const Icon(
              Icons.dashboard,
            ),
            'Home',
            () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            currentScreen == 0,
          ),
          _buildDrawerOption(
            context,
            const Icon(
              Icons.fact_check_outlined,
            ),
            'To Watch',
            () {
              Navigator.pop(context);

              if (currentScreen == 0) {
                Navigator.pushNamed(context, mainToWatchScreen);
              } else {
                Navigator.pushReplacementNamed(context, mainToWatchScreen);
              }
            },
            currentScreen == 1,
          ),
          _buildDrawerOption(
            context,
            const Icon(
              Icons.account_box,
            ),
            'Profile',
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, profileScreen);
            },
            currentScreen == 3,
          ),
          _buildDrawerOption(
            context,
            const Icon(
              Icons.settings,
            ),
            'Settings',
            () {
              Navigator.pop(context);

              if (currentScreen == 0) {
                Navigator.pushNamed(context, settingsScreen);
              } else {
                Navigator.pushReplacementNamed(context, settingsScreen);
              }
            },
            currentScreen == 4,
          ),
          const Spacer(),
          _buildDrawerOption(
            context,
            const Icon(
              Icons.run_circle,
            ),
            'Logout',
            () async {
              // currentScreen = 5;

              await _confirmSignOut(context);
            },
            currentScreen == 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${_currentUser.email} ',
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack _headerStack(UserModel _currentUser) {
    return Stack(
      alignment: Alignment.center,
      children: [
        bestSceneImage(_currentUser),
        Positioned(
          left: 18,
          bottom: 18,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.goldenColor, width: 3),
                ),
                child: ClipOval(
                  child: _currentUser.profileImageFile == null
                      ? CachedNetworkImage(
                          placeholderFadeInDuration: const Duration(seconds: 0),
                          fit: BoxFit.cover,
                          imageUrl: _currentUser.profileImgUrl,
                          placeholder: (context, url) => Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _currentUser.isAnon
                                  ? 'assets/images/user_info/anon_profile.jpg'
                                  : 'assets/images/user_info/profile_default.png',
                            ),
                          ),
                          errorWidget: (context, url, error) => const Image(
                            image: AssetImage(
                                'assets/images/user_info/profile_default.png'),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.file(
                          _currentUser.profileImageFile!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${_currentUser.firstName} ',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bestSceneImage(UserModel _currentUser) {
    return _currentUser.headerImageFile == null
        ? const Image(
            image: AssetImage('assets/images/user_info/best_default.png'),
            height: 220,
            fit: BoxFit.cover,
          )
        : Image.file(
            _currentUser.headerImageFile!,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          );
  }

  _buildDrawerOption(BuildContext context, Icon icon, String title,
      void Function() onTap, bool selected) {
    return ListTile(
      leading: icon,
      iconColor: AppColors.appGrey,
      selectedColor: AppColors.goldenColor,
      selectedTileColor: Colors.white30,
      selected: selected,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.goldenColor,
        ),
      ),
      onTap: selected
          ? () {
              Navigator.pop(context);
            }
          : onTap,
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
