import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';

class CineStreamLogo extends StatelessWidget {
  const CineStreamLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Cine',
          style: AppFonts.fraunces(
            color: AppColors.intenseRed,
            fontSize: 40,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          'Stream',
          style: AppFonts.fraunces(
            color: AppColors.nougat,
            fontSize: 40,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.9,
            height: 0.9,
          ),
        ),
      ],
    );
  }
}
