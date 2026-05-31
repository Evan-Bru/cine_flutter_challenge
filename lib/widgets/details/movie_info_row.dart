import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../core/fonts/app_fonts.dart';
import '../../models/movie_model.dart';

class MovieInfoRow extends StatelessWidget {
  final MovieModel movie;

  const MovieInfoRow({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final year = _getReleaseYear(movie.releaseDate);

    return Row(
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
          year,
          style: AppFonts.roboto(
            color: AppColors.transparentNougat60,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            movie.genres.isNotEmpty ? movie.genres.join(', ') : 'Gênero não informado',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.roboto(
              color: AppColors.transparentNougat60,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          movie.runtime > 0 ? '${movie.runtime}m' : '--',
          style: AppFonts.roboto(
            color: AppColors.transparentNougat60,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  static String _getReleaseYear(String releaseDate) {
    if (releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }

    return 'Ano não informado';
  }
}
