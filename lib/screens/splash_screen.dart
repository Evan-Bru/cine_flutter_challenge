import 'package:flutter/material.dart';
import 'package:cine_flutter_app/colors/app_colors.dart';
import 'package:cine_flutter_app/fonts/app_fonts.dart';
import 'login_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
      ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ired,
      body: Center(
        child: SizedBox(
          width: 214,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cine",
                    style: AppFonts.fraunces(
                      color: AppColors.nougat,
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    "Stream",
                    style: AppFonts.fraunces(
                      color: AppColors.nougat,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.9,
                      height: 0.9,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                "O CINEMA QUE VOCÊ AMA",
                textAlign: TextAlign.center,
                style: AppFonts.dmMono(
                  color: AppColors.nougat,
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 2.95,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}