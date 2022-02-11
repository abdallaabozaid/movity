import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/searched_movies_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/search_builder/search_result_item.dart';

class SearchResultBuilder extends StatelessWidget {
  const SearchResultBuilder({Key? key, required this.movieList})
      : super(key: key);
  final List<SearchedMovie> movieList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return movieList.isEmpty
            ? _emptyText()
            : ListView.builder(
                itemCount: movieList.length,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ResultItem(
                    movie: movieList[index],
                  );
                },
              );
      },
    );
  }

  Widget _emptyText() {
    return Center(
      child: Text(
        'There is no movie with this title',
        style: TextStyle(color: AppColors.goldenColor, fontSize: 20),
      ),
    );
  }
}
