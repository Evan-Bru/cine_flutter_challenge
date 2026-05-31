import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';
import '../routes/app_routes.dart';
import '../widgets/loading_screen.dart';
import '../widgets/login/login_header.dart';

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
      'https://cdn.atarde.com.br/img/Artigo-Destaque/1380000/1200x720/rede-de-cinema-lanca-promocao-que-sorteia-ingresso0138475200202604022121-ScaleDownProportional.webp?fallback=https%3A%2F%2Fcdn.atarde.com.br%2Fimg%2FArtigo-Destaque%2F1380000%2Frede-de-cinema-lanca-promocao-que-sorteia-ingresso0138475200202604022121.jpg%3Fxid%3D7035109%26resize%3D1000%252C500%26t%3D1780252685&xid=7035109';

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
      return const LoadingScreen();
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
            child: LoginHeader(context: context),
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
