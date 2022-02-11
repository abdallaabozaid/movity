import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/api/notification/notification_api.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  Future<void> _delay() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        print(state);
        if (state is LocalUser && state.user == null) {
          Navigator.pushReplacementNamed(context, onBoardingScreen);
        } else if (state is LocalUser && state.user != null) {
          Navigator.pushReplacementNamed(context, homeScreen);
        }
      },
      child: FutureBuilder(
        future: _delay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  'movity',
                  style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Comforter Brush',
                  ),
                ),
              ),
            );
          } else {
            return Builder(
              builder: (context) {
                BlocProvider.of<AuthCubit>(context).emittingLocalUser();

                return const Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: Text(
                      'movity',
                      style: TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Comforter Brush',
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
