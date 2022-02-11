import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';

class CastDetails extends StatelessWidget {
  const CastDetails({Key? key, required this.actorList}) : super(key: key);
  final List<ActorList> actorList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Cast',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: actorList.length,
            itemBuilder: (BuildContext context, int index) {
              final ActorList actor = actorList[index];
              return CastUnit(actor: actor);
            },
          ),
        ),
      ],
    );
  }
}

class CastUnit extends StatelessWidget {
  const CastUnit({Key? key, required this.actor}) : super(key: key);
  final ActorList actor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: 115,
                height: 115,
              ),
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
                onBackgroundImageError: (exception, stackTrace) => const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/common/img_loading.gif')),
              ),
              Positioned(
                bottom: 0,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    // bool _inTheFavoriteList =
                    //     AuthCubit.userModel!.favoriteActors.contains(actor);

                    // print("aaaaa ${_inTheFavoriteList}");
                    bool _alreadyExist = AuthCubit.userModel!.favoriteActors
                        .where((element) => actor.id == element.id)
                        .isNotEmpty;

                    return InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        final AuthCubit auth =
                            BlocProvider.of<AuthCubit>(context);
                        if (AuthCubit.userModel!.favoriteActors
                            .contains(actor)) {
                          _alreadyExist = true;
                        } else {
                          auth.editUser(addFavoriteActor: actor);
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.goldenColor,
                        ),
                        child: _alreadyExist
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                      ),
                    );
                  },
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
    );
  }
}
