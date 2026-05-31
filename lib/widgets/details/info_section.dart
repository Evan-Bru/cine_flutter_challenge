import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../core/fonts/app_fonts.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final String value;

  const InfoSection({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.roboto(
            color: AppColors.nougat,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppFonts.roboto(
            color: AppColors.transparentNougat60,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
