import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';
import '../routes/app_routes.dart';
import '../widgets/cine_stream_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final MovieController movieController = MovieController();

  bool hidePassword = true;
  bool isPreparingLogin = true;

  String? backgroundImageUrl;

  static const String fallbackImageUrl =
      'https://images.adsttc.com/media/images/58d5/3a58/e58e/ce48/a700/003f/newsletter/002.jpg?1490369108';

  @override
  void initState() {
    super.initState();
    _prepareLogin();
  }

  Future<void> _prepareLogin() async {
    await movieController.getPopularMovies();

    final movies = movieController.movies.value;

    if (!mounted) {
      return;
    }

    if (movies.isNotEmpty) {
      final imageUrl = movies.first.backdropUrl;

      await precacheImage(
        NetworkImage(imageUrl),
        context,
      );

      backgroundImageUrl = imageUrl;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isPreparingLogin = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    movieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPreparingLogin) {
      return const Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
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

    final imageUrl = backgroundImageUrl ?? fallbackImageUrl;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: _buildBackgroundImage(imageUrl),
          ),
          Positioned(
            top: 78,
            child: _buildHeaderTitles(),
          ),
          Positioned(
            bottom: 0,
            child: _buildFormContainer(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      height: MediaQuery.sizeOf(context).height * 0.5,
      width: MediaQuery.sizeOf(context).width,
    );
  }

  Widget _buildHeaderTitles() {
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

  Widget _buildFormContainer() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.639,
      width: MediaQuery.sizeOf(context).width,
      padding: const .fromLTRB(36, 79, 36, 20),
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        border: Border(
          top: BorderSide(color: AppColors.nougat.withAlpha(102)),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Text(
            'EMAIL',
            style: AppFonts.roboto(
              color: AppColors.nougat,
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            style: AppFonts.roboto(color: AppColors.nougat),
            decoration: InputDecoration(
              hintText: 'seu@gmail.com',
              hintStyle: AppFonts.roboto(
                color: AppColors.transparentNougat,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparentNougat12),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentRed),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Text(
            'SENHA',
            style: AppFonts.roboto(
              color: AppColors.nougat,
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 11),
          TextField(
            controller: passwordController,
            obscureText: hidePassword,
            style: AppFonts.roboto(color: AppColors.nougat),
            decoration: InputDecoration(
              hintText: '123456',
              hintStyle: AppFonts.roboto(
                color: AppColors.transparentNougat,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: AppColors.nougat,
                  size: 17,
                ),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparentNougat12),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightRed),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Esqueceu a senha?',
                style: AppFonts.roboto(
                  color: AppColors.nougat,
                  fontSize: 11,
                  fontWeight: .w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 29),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha email e senha.'),
                    ),
                  );
                  return;
                }

                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.home,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.intenseRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Entrar',
                style: AppFonts.roboto(
                  color: AppColors.nougat,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const .symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Não possui conta?',
                  style: AppFonts.roboto(
                    color: AppColors.aliceBlue,
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Cadastre-se',
                    style: AppFonts.roboto(
                      color: AppColors.intenseRed,
                      fontSize: 14,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Text(
              '© 2024 CineStream',
              style: AppFonts.roboto(
                color: AppColors.mediumGray,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
