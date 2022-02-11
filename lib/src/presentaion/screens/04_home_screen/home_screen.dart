import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/api/notification/notification_api.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';
import 'package:movity/src/logic/movies/cubit/movies_cubit.dart';
import 'package:movity/src/presentaion/common_widgets/loading_circle.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/home_app_drawer.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/home_body_content.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // NotificationApi.onNotificationOpen.stream.listen(onClickeNotification);

    super.initState();
  }

  // void onClickeNotification(String? payLoad) {
  //   if (payLoad == null || payLoad.isEmpty) {
  //     return;
  //   } else {
  //     Navigator.pushNamed(context, movieScreen, arguments: payLoad);
  //   }
  // }

  List<MovieItem> topMovies = [];

  List<MovieItem> mostPopularMovies = [];

  List<MovieItem> topSeries = [];

  bool _isLoading = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Future<bool> _onWillPop(BuildContext context) async {
    if (Scaffold.of(context).isDrawerOpen) {
      return true;
    } else {
      bool? willColse = false;
      willColse = await const AwareAlertDialog(
        alertContentText: 'Are you sure you want to exit ?',
        title: 'Exit confirmation ..',
        cancelText: 'cancel',
      ).show(context, isDissmissible: false);

      return willColse!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoviesCubit _moviesCubit = BlocProvider.of<MoviesCubit>(context);

    return Builder(
      builder: (context) {
        topMovies = _moviesCubit.loadedMovies ?? [];
        mostPopularMovies = _moviesCubit.mostPopularMovies ?? [];
        return Center(
          child: Scaffold(
            drawer: const Drawer(
              // backgroundColor: Colors.transparent,
              child: HomeAppDrawer(
                currentScreen: 0,
              ),
            ),
            key: _scaffoldKey,
            body: BlocConsumer<MoviesCubit, MoviesState>(
              listener: (context, state) {
                if (state is LoadingMovies) {
                  _isLoading = state.isLoading;
                } else if (state is LoadedTopMovis) {
                  topMovies = state.topmovieItems!;
                  mostPopularMovies = state.popularMovieItems!;
                }
              },
              builder: (context, state) {
                return WillPopScope(
                  child: _isLoading
                      ? const LoadingCircle()
                      : SingleChildScrollView(
                          // controller: _scrollController,
                          child: HomeBodyContent(
                            topMovies: topMovies,
                            mostPopularMovies: mostPopularMovies,
                            scaffoldKey: _scaffoldKey,
                          ),
                        ),
                  onWillPop: () => _onWillPop(context),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
