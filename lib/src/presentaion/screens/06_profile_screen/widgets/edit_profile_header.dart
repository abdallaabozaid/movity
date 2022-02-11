import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';

class EditProfileHeader extends StatefulWidget {
  EditProfileHeader({Key? key}) : super(key: key);

  @override
  State<EditProfileHeader> createState() => _EditProfileHeaderState();
}

class _EditProfileHeaderState extends State<EditProfileHeader> {
  File? _headerFileImage;

  File? _profileFileImage;

  @override
  Widget build(BuildContext context) {
    final user = AuthCubit.userModel;

    return SizedBox(
      height: 315,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is ImageEdited && state.headerFile != null) {
                  _headerFileImage = state.headerFile;
                } else if (state is ImageEdited && state.profileFile != null) {
                  _profileFileImage = state.profileFile;
                }
              },
              builder: (context, state) {
                return user?.headerImageFile != null
                    ? Image.file(
                        _headerFileImage ?? user!.headerImageFile!,
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                        fit: BoxFit.cover,
                      )
                    : _headerFileImage == null
                        ? Image.asset(
                            'assets/images/user_info/best_default.png',
                            width: MediaQuery.of(context).size.width,
                            height: 280,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _headerFileImage!,
                            width: MediaQuery.of(context).size.width,
                            height: 280,
                            fit: BoxFit.cover,
                          );
              },
            ),
          ),
          Positioned(
            bottom: 140,
            child: _editIcon(
              context: context,
              width: 70,
              iconSize: 40,
              profileImage: false,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return user?.profileImageFile != null
                            ? Image.file(
                                _profileFileImage ?? user!.profileImageFile!,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              )
                            : _profileFileImage == null
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
                                      image: AssetImage(user.isAnon
                                          ? 'assets/images/user_info/anon_profile.jpg'
                                          : 'assets/images/user_info/profile_default.png'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Image(
                                      image: AssetImage(
                                          'assets/images/user_info/profile_default.png'),
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    ),
                                  )
                                : Image.file(
                                    _profileFileImage!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  );
                      },
                    ),
                    Builder(builder: (ctx) {
                      return _editIcon(
                        context: context,
                        width: 50,
                        iconSize: 30,
                        profileImage: true,
                      );
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _editIcon({
    required BuildContext context,
    required double width,
    required double iconSize,
    required bool profileImage,
  }) {
    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20)),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          _showPickImageOptions(context, profileImage: profileImage);
        },
        icon: Icon(Icons.add_a_photo_outlined, size: iconSize),
        color: AppColors.goldenColor,
      ),
    );
  }

  Future pickImage(BuildContext context,
      {required ImageSource source, required bool profileImage}) async {
    final imageFile = await ImagePicker().pickImage(source: source);

    if (imageFile == null) {
      return;
    } else {
      final AuthCubit auth = BlocProvider.of<AuthCubit>(context);
      final imageTemp = File(imageFile.path);

      if (profileImage) {
        auth.imageEdited(imageTemp, null);
      } else {
        auth.imageEdited(null, imageTemp);
      }
    }
  }

  void _showPickImageOptions(BuildContext ctx, {required bool profileImage}) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 100,
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
                const Text(
                  'Get photo from',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        primary: AppColors.goldenColor,
                        onPrimary: Colors.white,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        pickImage(ctx,
                            source: ImageSource.camera,
                            profileImage: profileImage);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        primary: AppColors.goldenColor,
                        onPrimary: Colors.white,
                      ),
                      child: const Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        pickImage(ctx,
                            source: ImageSource.gallery,
                            profileImage: profileImage);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
