import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/user_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/logic/preferences/user/user_preferences.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/home_app_drawer.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/fav_actors.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/fav_movies_builder.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/header_info.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel user = AuthCubit.userModel!;
    final String aa =
        UserPreferences.jsonEncoderForMoviesList(user.favoriteMovies);
    UserPreferences.backToMoviesList(aa);

    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Colors.transparent,
        child: HomeAppDrawer(currentScreen: 3),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const ProfileHeader(),
                Text(
                  user.firstName,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                HeaderInfo(user: user),
                Divider(
                  endIndent: 20,
                  indent: 20,
                  height: 30,
                  color: AppColors.appGrey,
                ),
                FavoriteMoviesBuilder(favoriteMovies: user.favoriteMovies),
                Divider(
                  endIndent: 20,
                  indent: 20,
                  height: 30,
                  color: AppColors.appGrey,
                ),
                FavoriteActorsBuilder(favActorList: user.favoriteActors)
              ],
            ),
          );
        },
      ),
    );
  }
}
