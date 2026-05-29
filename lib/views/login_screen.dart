import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';
import '../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;

  final MovieController movieController = MovieController();

  @override
  void initState() {
    super.initState();

    movieController.getPopularMovies();
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
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: movieController.movies,
        builder: (context, movies, child) {
          final String backgroundImageUrl = movies.isNotEmpty
              ? movies.first.backdropUrl
              : 'https://images.adsttc.com/media/images/58d5/3a58/e58e/ce48/a700/003f/newsletter/002.jpg?1490369108';

          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(backgroundImageUrl), fit: BoxFit.cover),
            ),

            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const .only(top: 82),
                child: Column(
                  children: [
                    // TOPO
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .25,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Row(
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
                            ),

                            const SizedBox(height: 8),

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
                    ),

                    // CARD DO LOGIN
                    Expanded(
                      child: Container(
                        padding: const .fromLTRB(28, 55, 28, 20),

                        decoration: const BoxDecoration(
                          color: AppColors.darkBlue,

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Padding(
                              padding: const .only(top: 10),
                              child: Text(
                                'EMAIL',
                                style: AppFonts.roboto(
                                  color: AppColors.nougat,
                                  fontSize: 10,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            TextField(
                              controller: emailController,

                              style: AppFonts.roboto(color: AppColors.nougat),

                              decoration: InputDecoration(
                                hintText: 'seu@gmail.com',

                                hintStyle: AppFonts.roboto(color: AppColors.transparentNougat),

                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.nougat),
                                ),

                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.accentRed),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            Text(
                              'SENHA',
                              style: AppFonts.roboto(
                                color: AppColors.nougat,
                                fontSize: 10,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

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
                                  borderSide: BorderSide(color: AppColors.nougat),
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
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            SizedBox(
                              height: 52,

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

                                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.intenseRed,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

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
                                        fontSize: 12,
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
