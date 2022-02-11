import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/src/data/api/notification/notification_api.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/logic/connectivity/cubit/internet_cubit.dart';
import 'package:movity/src/logic/landing/landing_screen.dart';
import 'package:movity/src/logic/preferences/movies/movies_preferences.dart';
import 'package:movity/src/logic/preferences/theme/app_theme_preferences.dart';
import 'package:movity/src/logic/preferences/user/user_preferences.dart';
import 'package:movity/src/logic/theme/bloc/theme_bloc.dart';

import 'config/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
    ),
  );
  await Firebase.initializeApp();
  await ThemePreferences.initializeThemePreferences();
  await UserPreferences.initializeUserPreferences();
  await TopMoviesPreferences.initializeTopMoviesPreferences();
  await NotificationApi.init();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    MyApp(
      connectivity: Connectivity(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.connectivity, Key? key}) : super(key: key);
  final Connectivity connectivity;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movity',
            theme: state.themeData,
            onGenerateRoute: AppRouter.generateRoute,
            home: const LandingScreen(),
          );
        },
      ),
    );
  }
}
