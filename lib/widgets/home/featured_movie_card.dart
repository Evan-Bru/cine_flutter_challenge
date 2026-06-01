// class _FeaturedMovieCard extends StatelessWidget
import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../core/fonts/app_fonts.dart';
import '../../core/gradients/app_gradients.dart';
import '../../models/movie_model.dart';
import '../../routes/app_routes.dart';

class FeaturedMovieCard extends StatelessWidget {
  final MovieModel movie;

  const FeaturedMovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 308,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movie.backdropUrl),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        padding: const .fromLTRB(25, 1, 40, 4),
        decoration: const BoxDecoration(
          gradient: AppGradients.featuredMovieOverlay,
        ),
        child: Column(
          mainAxisAlignment: .end,
          crossAxisAlignment: .start,
          children: [
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.fraunces(
                color: AppColors.nougat,
                fontSize: 24,
                fontWeight: .w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.transparentNougat60,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: AppFonts.roboto(
                    color: AppColors.transparentNougat60,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '|',
                  style: AppFonts.roboto(
                    color: AppColors.transparentNougat60,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _getReleaseYear(movie.releaseDate),
                  style: AppFonts.roboto(
                    color: AppColors.transparentNougat60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: movie.id,
                      );
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 24,
                    ),
                    label: Text(
                      'Assistir Agora',
                      style: AppFonts.roboto(
                        color: AppColors.nougat,
                        fontWeight: .w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.intenseRed,
                      foregroundColor: AppColors.nougat,
                      padding: const .fromLTRB(9, 16, 9, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 22),
                Container(
                  height: 57,
                  width: 57,
                  decoration: BoxDecoration(
                    border: .all(
                      color: AppColors.transparentNougat08,
                    ),
                    borderRadius: .circular(16),
                  ),
                  child: const Icon(
                    Icons.bookmark_border,
                    color: AppColors.nougat,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _getReleaseYear(String releaseDate) {
    if (releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }

    return 'Ano não informado';
  }
}
