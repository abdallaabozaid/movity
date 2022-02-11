import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/to_watch_card_content.dart';

class ToWatchItem extends StatelessWidget {
  const ToWatchItem({
    Key? key,
    required this.movie,
    required this.watched,
    required this.index,
  }) : super(key: key);
  final Movie movie;
  final int index;
  final bool watched;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(movie.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        final AuthCubit auth = BlocProvider.of<AuthCubit>(context);

        auth.removeToWatch(movie);
      },
      background: _dismissBackground(),
      confirmDismiss: (direction) {
        return _dismissConfirmation(context);
      },
      child: Padding(
        padding: EdgeInsets.zero,
        child: Card(
          color: AppColors.goldenColor,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.goldenColor, width: 3),
            ),
            child: CardContent(
              movie: movie,
              index: index,
              watched: watched,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _dismissConfirmation(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.appGrey.withOpacity(0.7),
        title: const Text(
          'Are you sure ?!',
          textAlign: TextAlign.center,
        ),
        content:
            Text('${movie.title} Do you wanna remove the movie from list ? '),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: Text(
                'Confirm',
                style: TextStyle(color: AppColors.goldenColor),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: Text(
                'cancel',
                style: TextStyle(color: AppColors.goldenColor),
              )),
        ],
      ),
    );
  }

  Widget _dismissBackground() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 15,
      ),
      child: Container(
        padding: const EdgeInsets.all(17),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}
