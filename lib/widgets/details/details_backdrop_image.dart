import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../models/movie_model.dart';

class DetailsBackdropImage extends StatelessWidget {
  final MovieModel movie;

  const DetailsBackdropImage({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      movie.backdropUrl,
      width: double.infinity,
      height: 185,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 185,
          color: AppColors.transparentNougat08,
          child: const Icon(
            Icons.broken_image,
            color: AppColors.mediumGray,
          ),
        );
      },
    );
  }
}
