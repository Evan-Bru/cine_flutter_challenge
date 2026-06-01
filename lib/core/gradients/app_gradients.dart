import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppGradients {
  static const featuredMovieOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      AppColors.darkBlue78,
      AppColors.darkBlue,
    ],
    stops: [
      0.0,
      0.62,
      0.85,
    ],
  );
  static const detailsImageOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      AppColors.darkBlue68,
      AppColors.darkBlue98,
    ],
    stops: [
      0,
      0.63,
      0.96,
    ],
  );
}
