import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../cine_stream_logo.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CineStreamLogo(
          fontSize: 24,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: AppColors.mediumGray,
            size: 20,
          ),
        ),
      ],
    );
  }
}
