// class _FeaturedMovieCard extends StatelessWidget
import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../core/fonts/app_fonts.dart';
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
      height: 210,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: NetworkImage(movie.backdropUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent.withValues(alpha: 0.05),
              AppColors.darkBlue.withValues(alpha: 0.35),
              AppColors.darkBlue.withValues(alpha: 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.fraunces(
                color: AppColors.nougat,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
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
                  _getReleaseYear(movie.releaseDate),
                  style: AppFonts.roboto(
                    color: AppColors.transparentNougat60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
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
                      size: 18,
                    ),
                    label: Text(
                      'Assistir Agora',
                      style: AppFonts.roboto(
                        color: AppColors.nougat,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.intenseRed,
                      foregroundColor: AppColors.nougat,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.transparentNougat08,
                    ),
                    borderRadius: BorderRadius.circular(8),
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
