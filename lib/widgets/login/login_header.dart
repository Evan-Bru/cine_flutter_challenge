import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../core/fonts/app_fonts.dart';
import '../cine_stream_logo.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CineStreamLogo(),
            const SizedBox(height: 1),
            Text(
              'O CINEMA QUE VOCÊ AMA',
              style: AppFonts.dmMono(
                color: AppColors.nougat,
                fontSize: 11,
                letterSpacing: 2.75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
