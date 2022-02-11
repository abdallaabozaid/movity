import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';
import 'package:movity/src/data/model/moveis/searched_movies_model.dart';
import 'package:movity/src/logic/movies/cubit/movies_cubit.dart';
import 'package:movity/src/logic/searched_movies/bloc/searched_movies_bloc.dart';
import 'package:movity/src/presentaion/common_widgets/common_text_widget.dart';
import 'package:movity/src/presentaion/common_widgets/loading_circle.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/movies_builder.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/recommended_movies.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/search_builder/search_builder.dart';

class HomeBodyContent extends StatefulWidget {
  const HomeBodyContent(
      {Key? key,
      required this.topMovies,
      required this.mostPopularMovies,
      required this.scaffoldKey})
      : super(key: key);
  final List<MovieItem> topMovies;
  final List<MovieItem> mostPopularMovies;

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<HomeBodyContent> createState() => _HomeBodyContentState();
}

class _HomeBodyContentState extends State<HomeBodyContent> {
  final TextEditingController _searchFieldController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<SearchedMovie> _searchedMovies = [];
  bool _loading = false;
  bool _isSearching = false;

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _searchTextField(context),
          Builder(
            builder: (context) {
              return BlocBuilder<MoviesCubit, MoviesState>(
                builder: (context, state) {
                  return BlocConsumer<SearchedMoviesBloc, SearchedMoviesState>(
                    listener: (context, state) {
                      if (state is SearchedMoviesLoaded) {
                        _loading = false;

                        _searchedMovies = state.searchedMovies;
                      } else if (state is SearchedMoviesLoading) {
                        _loading = true;
                      } else {
                        _loading = false;
                      }
                    },
                    builder: (context, state) {
                      if (!_isSearching) {
                        return MainMoviesColumn(
                          topMovies: widget.topMovies,
                          mostPopularMovies: widget.mostPopularMovies,
                        );
                      } else {
                        if (_loading) {
                          return const Center(
                            child: LoadingCircle(),
                          );
                        } else {
                          if (_searchFieldController.text.isEmpty &&
                              _searchedMovies.isEmpty) {
                            return _welcomeSearchText();
                          } else {
                            return SearchResultBuilder(
                              movieList: _searchedMovies,
                            );
                          }
                        }
                      }
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Container _welcomeSearchText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: const CommonTextWidget(
        text: 'Start searching .. ',
        color: Colors.white,
        size: 22,
      ),
    );
  }

  void _startSearching() {
    setState(() {
      _isSearching = true;
    });
  }

  void _endSearching() {
    _clearSearch();
    _searchedMovies = [];
    _searchFocusNode.unfocus();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchFieldController.clear();
    });
  }

  Padding _searchTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: _searchFieldController,
        focusNode: _searchFocusNode,
        onSubmitted: (searchWord) {
          if (searchWord.isEmpty) {
            _endSearching();
            return;
          } else {
            _startSearching();
            onSubmitted(context, searchWord);
          }
        },
        onChanged: (searchWord) {
          if (_searchFieldController.text.isEmpty) {
            _searchedMovies = [];
            setState(
              () {
                _isSearching = false;
              },
            );
          }
        },
        onTap: () {
          _startSearching();
        },
        decoration: _searchInputDecoration(context, widget.scaffoldKey),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void onSubmitted(BuildContext context, String searchWord) {
    final searchCubit = BlocProvider.of<SearchedMoviesBloc>(context);
    searchCubit.add(GetSearchedMovies(searchWord));
  }

  InputDecoration _searchInputDecoration(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(18),
      prefixIcon: IconButton(
        icon: const Icon(Icons.menu_rounded),
        color: Colors.white,
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
          // Scaffold.of(context).openDrawer();
        },
      ),
      suffixIcon: _isSearching
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchFieldController.clear();
                _endSearching();
              },
              color: AppColors.appGrey,
            )
          : IconButton(
              onPressed: () {
                _searchFocusNode.requestFocus();
                _startSearching();
              },
              icon: const Icon(Icons.search),
              color: AppColors.appGrey,
            ),
      hintText: 'Search movies .. ',
      hintStyle: const TextStyle(
          color: Color(0xff9C9C9C), fontSize: 20, fontWeight: FontWeight.w100),
      filled: true,
      fillColor: const Color(0xff1A1A1A),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.appGrey, width: 0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }
}

class MainMoviesColumn extends StatelessWidget {
  const MainMoviesColumn(
      {Key? key, required this.topMovies, required this.mostPopularMovies})
      : super(key: key);
  final List<MovieItem> topMovies;
  final List<MovieItem> mostPopularMovies;

  List<MovieItem> _getRecommendedMovies() {
    final _random = Random();

    final List<MovieItem> recommended = [
      mostPopularMovies[_random.nextInt(mostPopularMovies.length)],
      mostPopularMovies[_random.nextInt(mostPopularMovies.length)],
      mostPopularMovies[_random.nextInt(mostPopularMovies.length)],
      mostPopularMovies[_random.nextInt(mostPopularMovies.length)],
      mostPopularMovies[_random.nextInt(mostPopularMovies.length)],
    ];

    return recommended;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: CommonTextWidget(
            text: 'Movies',
            color: Colors.white,
            size: 30,
          ),
        ),
        RecommendedMoviesWidget(
          recommendedMovies: _getRecommendedMovies(),
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: CommonTextWidget(
              text: 'Most Popular movies', size: 22, color: Colors.white),
        ),
        SizedBox(
          height: 240,
          child: MoviesBuilder(
            loadedMovies: mostPopularMovies,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: CommonTextWidget(
            text: 'Top Rated Movies',
            size: 22,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 240,
          child: MoviesBuilder(
            loadedMovies: topMovies,
          ),
        ),
      ],
    );
  }
}
