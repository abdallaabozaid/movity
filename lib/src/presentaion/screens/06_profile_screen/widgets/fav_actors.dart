import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';

class FavoriteActorsBuilder extends StatelessWidget {
  const FavoriteActorsBuilder({Key? key, required this.favActorList})
      : super(key: key);
  final List<ActorList> favActorList;
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
        favActorList.isEmpty
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
                    return ActorUnit(actor: actor);
                  },
                ),
              ),
      ],
    );
  }
}

class ActorUnit extends StatelessWidget {
  const ActorUnit({Key? key, required this.actor}) : super(key: key);
  final ActorList actor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
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
            onBackgroundImageError: (exception, stackTrace) => const Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/common/img_loading.gif')),
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
