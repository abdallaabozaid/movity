import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/app_theme.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/common_widgets/elevated_button.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/edit_fav_actors.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/edit_fav_movies_builder.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    Key? key,
    required this.isNew,
  }) : super(key: key);

  final bool isNew;
  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  File? headerFileImage;
  File? profileFileImage;

  bool _isValidating = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitt() async {
    _isValidating = true;
    final inputValidation = _formKey.currentState!.validate();
    if (inputValidation) {
      _formKey.currentState!.save();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit auth = BlocProvider.of<AuthCubit>(context);
    final user = AuthCubit.userModel;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ImageEdited && state.headerFile != null) {
          headerFileImage = state.headerFile;
        } else if (state is ImageEdited && state.profileFile != null) {
          profileFileImage = state.profileFile;
        }
      },
      buildWhen: (previous, current) =>
          current is FormToggled && previous != current,
      builder: (context, state) {
        return Form(
          autovalidateMode: _isValidating
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        flex: 6, child: _firstNameField(user?.firstName, auth)),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(flex: 6, child: _lastNameField(user?.lastName)),
                  ],
                ),
                const SizedBox(height: 24),
                _emailField(user?.email),
                const SizedBox(
                  height: 20,
                ),

                _bestQuoteField(),

                const SizedBox(
                  height: 20,
                ),
                user!.favoriteMovies.isEmpty
                    ? Container()
                    : EditFavoriteMoviesBuilder(),

                user.favoriteActors.isEmpty
                    ? Container()
                    : EditFavoriteActorsBuilder(),

                CommonButton(
                    labelText: 'Save',
                    onPressed: () {
                      _submitt();
                      if (profileFileImage != null) {
                        auth.editUser(profileFileImage: profileFileImage);
                      }
                      if (headerFileImage != null) {
                        auth.editUser(
                          headerFileImage: headerFileImage,
                        );
                      }

                      widget.isNew
                          ? Navigator.pushReplacementNamed(context, homeScreen)
                          : Navigator.pop(context);
                    }),
                const SizedBox(height: 10),
                // _trailinText(context, auth),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _firstNameField(String? firstName, AuthCubit auth) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a value';
        }
      },
      initialValue: firstName,
      onSaved: (newValue) {
        auth.editUser(firstName: newValue);
      },
      // controller: _firstNameController,
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        enabledBorder: AppTheming.enabledBorder,
        disabledBorder: AppTheming.disabledBorder,
        errorBorder: AppTheming.errorBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        labelText: 'First name',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _lastNameField(String? lastName) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a value';
        }
      },
      // controller: _lastNameTextController,
      initialValue: lastName,
      onSaved: (newValue) {
        AuthCubit.userModel!.lastName =
            newValue ?? AuthCubit.userModel!.lastName;
      },
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        enabledBorder: AppTheming.enabledBorder,
        disabledBorder: AppTheming.disabledBorder,
        errorBorder: AppTheming.errorBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        labelText: 'Last name',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _emailField(String? email) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter ypur email adress ..';
        } else if (!value.contains('.com')) {
          return 'Invalid email adress ..';
        }
      },
      onChanged: (email) {},
      initialValue: email,
      // controller: _emailTextController,
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      keyboardAppearance: Brightness.dark,
      keyboardType: TextInputType.emailAddress,
      enableSuggestions: true,
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white),
      enabled: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        errorBorder: AppTheming.errorBorder,
        enabledBorder: AppTheming.enabledBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        disabledBorder: AppTheming.disabledBorder,
        labelText: 'Email',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _bestQuoteField() {
    return TextFormField(
      initialValue: AuthCubit.userModel?.bestQuote,
      onSaved: (newValue) {
        AuthCubit.userModel!.bestQuote =
            newValue ?? AuthCubit.userModel!.bestQuote;
      },
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      keyboardAppearance: Brightness.dark,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white),
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        enabledBorder: AppTheming.enabledBorder,
        errorBorder: AppTheming.errorBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        disabledBorder: AppTheming.disabledBorder,
        labelText: 'Best Quote',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
