import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({Key? key, required this.movieImg}) : super(key: key);
  final String movieImg;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          height: 420,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CachedNetworkImage(
                placeholderFadeInDuration: const Duration(seconds: 0),
                imageUrl: movieImg,
                width: MediaQuery.of(context).size.width,
                height: 420,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image(
                  image: const AssetImage(
                    'assets/images/common/loading_circle.gif',
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 420,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => const Image(
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/common/loading_circle.gif'),
                ),
              ),
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
            ],
          ),
        ),
        // SafeArea(
        //   child: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(
        //       Icons.arrow_back_rounded,
        //       size: 35,
        //       color: AppColors.goldenColor,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
