import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';

class EditFavoriteActorsBuilder extends StatelessWidget {
  EditFavoriteActorsBuilder({Key? key}) : super(key: key);
  final List<ActorList> favActorList = AuthCubit.userModel!.favoriteActors;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Favorite Actors',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) => favActorList.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    'No actors yet',
                    style: TextStyle(color: AppColors.goldenColor),
                  ),
                )
              : SizedBox(
                  height: 150,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: favActorList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ActorList actor = favActorList[index];
                      return EditActorUnit(actor: actor);
                    },
                  ),
                ),
        )
      ],
    );
  }
}

class EditActorUnit extends StatelessWidget {
  const EditActorUnit({Key? key, required this.actor}) : super(key: key);
  final ActorList actor;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(actor.id),
      direction: DismissDirection.up,
      onDismissed: (direction) {
        AuthCubit.userModel!.favoriteActors
            .removeWhere((element) => actor.id == element.id);

        BlocProvider.of<AuthCubit>(context).editUser();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    actor.asCharacter,
                    style: const TextStyle(fontSize: 8, color: Colors.white),
                  ),
                  foregroundImage: CachedNetworkImageProvider(actor.image),
                  // NetworkImage(actor.image),
                  backgroundColor: AppColors.goldenColor,
                  backgroundImage:
                      const AssetImage('assets/images/common/img_loading.gif'),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/common/img_loading.gif')),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Colors.white24, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_upward_sharp,
                    size: 60,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              actor.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
