import 'package:flutter/material.dart';
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

  // IMAGEM VINDO DA API
  String bgimg = 'https://images.adsttc.com/media/images/58d5/3a58/e58e/ce48/a700/003f/newsletter/002.jpg?1490369108';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(bgimg), fit: BoxFit.cover),
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
                                color: AppColors.ired,
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

                        const Text(
                          'O CINEMA QUE VOCÊ AMA',

                          style: TextStyle(
                            color: AppColors.nougat,
                            fontSize: 11,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // CARD DO LOGIN
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(28, 55, 28, 20),

                    decoration: const BoxDecoration(
                      color: AppColors.dblue,

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'EMAIL',
                            style: TextStyle(
                              color: AppColors.nougat,
                              fontSize: 10,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        TextField(
                          controller: emailController,

                          style: const TextStyle(color: AppColors.nougat),

                          decoration: const InputDecoration(
                            hintText: 'seu@gmail.com',

                            hintStyle: TextStyle(color: AppColors.tnougat),

                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.nougat),
                            ),

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.ared),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          'SENHA',
                          style: TextStyle(
                            color: AppColors.nougat,
                            fontSize: 10,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          style: const TextStyle(color: AppColors.nougat),

                          decoration: InputDecoration(
                            hintText: '123456',

                            hintStyle: const TextStyle(
                              color: AppColors.tnougat,
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
                              borderSide: BorderSide(color: AppColors.lred),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,

                          child: TextButton(
                            onPressed: () {},

                            child: const Text(
                              'Esqueceu a senha?',

                              style: TextStyle(
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
                              Navigator.pushReplacementNamed(context, AppRoutes.home);
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.ired2,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            child: const Text(
                              'Entrar',

                              style: TextStyle(
                                color: AppColors.nougat,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              const Text(
                                'Não possui conta?',

                                style: TextStyle(
                                  color: AppColors.nougat,
                                  fontSize: 12,
                                ),
                              ),

                              TextButton(
                                onPressed: () {},

                                child: const Text(
                                  'Cadastre-se',

                                  style: TextStyle(
                                    color: AppColors.ired2,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        const Center(
                          child: Text(
                            '© 2024 CineStream',

                            style: TextStyle(
                              color: AppColors.mgray,
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
      ),
    );
  }
}
