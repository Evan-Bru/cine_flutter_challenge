import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';
import '../widgets/cine_stream_logo.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CineStreamLogo(),
            SizedBox(height: 24),
            CircularProgressIndicator(
              color: AppColors.intenseRed,
            ),
          ],
        ),
      ),
    );
  }
}
