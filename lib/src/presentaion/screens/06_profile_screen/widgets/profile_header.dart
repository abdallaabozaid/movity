import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthCubit.userModel;

    return SizedBox(
      height: 315,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: user?.headerImageFile == null
                      ? Image.asset(
                          'assets/images/user_info/best_default.png',
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          user!.headerImageFile!,
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          fit: BoxFit.cover,
                        ));
            },
          ),
          Positioned(
            left: 15,
            top: 50,
            child: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    // _scaffoldState.currentState!.openDrawer(),
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu, size: 30),
                  color: AppColors.goldenColor,
                );
              },
            ),
          ),
          Positioned(
            right: 15,
            top: 50,
            child: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    // _scaffoldState.currentState!.openDrawer(),
                    Navigator.pushNamed(
                      context,
                      editProfileScreen,
                      arguments: false,
                    );
                  },
                  icon: const Icon(Icons.edit, size: 25),
                  color: AppColors.goldenColor,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.goldenColor, width: 3),
                ),
                child: ClipOval(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) => user?.profileImageFile == null
                        ? CachedNetworkImage(
                            placeholderFadeInDuration:
                                const Duration(seconds: 0),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            imageUrl: user!.profileImgUrl,
                            placeholder: (context, url) => Image(
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                              image: AssetImage(
                                user.isAnon
                                    ? 'assets/images/user_info/anon_profile.jpg'
                                    : 'assets/images/user_info/profile_default.png',
                              ),
                            ),
                            errorWidget: (context, url, error) => const Image(
                              image: AssetImage(
                                  'assets/images/user_info/profile_default.png'),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          )
                        : Image.file(
                            user!.profileImageFile!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
