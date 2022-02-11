import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/platform_exception_alert_dialog.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/scaffold_appbar.dart';
import 'package:movity/src/presentaion/screens/02_sign_up/widgets/email_sign_in_form.dart';
import 'package:movity/src/presentaion/screens/02_sign_up/widgets/social_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.fromSignOut}) : super(key: key);
  final bool fromSignOut;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final auth = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        child: const ScaffoldAppBar(titleText: 'Sign In'),
        preferredSize: Size(size.width, 70),
      ),
      body: Stack(
        children: [
          _buildContent(context, size, auth),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) =>
                current is Loading && previous != current,
            builder: (context, state) {
              if (state is Loading) {
                if (state.isLoading) {
                  return Stack(
                    alignment: Alignment.center,
                    children: const [
                      Opacity(
                        opacity: 0.3,
                        child: ModalBarrier(
                            dismissible: false, color: Colors.grey),
                      ),
                      CircularProgressIndicator(
                        color: Colors.deepOrange,
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _buildContent(
    BuildContext context,
    Size size,
    AuthCubit auth,
  ) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      // physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(children: [
              Text(
                'Sign in with one of following options',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appGrey,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _socialSigning(context, auth),
              const SizedBox(
                height: 30,
              ),
              EmailSignInForm(fromSignOut: widget.fromSignOut),
              const SizedBox(
                height: 15,
              ),
              guestButton(context, auth)
            ]),
            _buildAuthBlocListener(),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthBlocListener() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Loading) {
        } else if (state is AuthError) {
          PlatformExceptionAlertDialog(
                  title: 'Error', platformE: state.exception)
              .show(context, isDissmissible: false);
        } else if (state is Logged) {
          if (state.user.isAnon) {
            // anon flow

            Navigator.of(context).pushNamedAndRemoveUntil(
                editProfileScreen, (Route<dynamic> route) => false,
                arguments: true);
            // Navigator.pushReplacementNamed(context, editProfileScreen,
            //     arguments: true);
          } else if (state.user.isNew!) {
            Navigator.pushReplacementNamed(context, editProfileScreen,
                arguments: true);
          } else if (!state.user.isNew!) {
            Navigator.pushReplacementNamed(context, homeScreen);
          }
        }
      },
      child: Container(),
    );
  }

  Widget guestButton(BuildContext context, AuthCubit auth) {
    return GestureDetector(
      onTap: () async {
        await _signInAnon(context, auth);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.goldenColor),
        ),
        child: const Text(
          'GUEST',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _signInAnon(BuildContext context, AuthCubit auth) async {
    await auth.signInAnon();
  }

  Widget _socialSigning(BuildContext context, AuthCubit auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: SocialButton(
            onPressed: () async {
              await auth.signInWithGoogle();
            },
            iconAssetName: 'google_icon',
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 6,
          child: SocialButton(
            onPressed: () {
              // _signInWithFacebook(context);
            },
            iconAssetName: 'fb_icon',
          ),
        ),
      ],
    );
  }
}
