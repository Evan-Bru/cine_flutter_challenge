import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../models/movie_model.dart';
import '../../routes/app_routes.dart';

class MoviePosterList extends StatelessWidget {
  final List<MovieModel> movies;

  const MoviePosterList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.details,
                arguments: movie.id,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie.posterUrl,
                width: 100,
                height: 155,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 155,
                    color: AppColors.transparentNougat08,
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.mediumGray,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
