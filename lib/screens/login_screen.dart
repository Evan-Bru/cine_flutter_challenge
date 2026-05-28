import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cine_flutter_app/colors/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool esconderSenha = true;

  // IMAGEM VINDO DA API
  String imagemFundo = 'https://images.adsttc.com/media/images/58d5/3a58/e58e/ce48/a700/003f/newsletter/002.jpg?1490369108';

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imagemFundo),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              // TOPO
              SizedBox(
                height: 271,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cine",
                            style: GoogleFonts.fraunces(
                              color: AppColors.ired,
                              fontSize: 40,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                            ),
                          ),

                          const SizedBox(width: 3),

                          Text(
                            "Stream",
                            style: GoogleFonts.fraunces(
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
                  width: double.infinity,

                  padding: const EdgeInsets.fromLTRB(28, 55, 28, 20),

                  decoration: const BoxDecoration(
                    color: Color(0xFF1C1D22),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'EMAIL',
                        style: TextStyle(
                          color: AppColors.nougat,
                          fontSize: 10,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
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
                            borderSide: BorderSide(color: Colors.redAccent),
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
                        controller: senhaController,

                        obscureText: esconderSenha,

                        style: const TextStyle(color: AppColors.nougat),

                        decoration: InputDecoration(
                          hintText: '123456',

                          hintStyle: const TextStyle(color: AppColors.tnougat),

                          suffixIcon: IconButton(
                            icon: Icon(
                              esconderSenha
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,

                              color: AppColors.nougat,
                              size: 18,
                            ),

                            onPressed: () {
                              setState(() {
                                esconderSenha = !esconderSenha;
                              });
                            },
                          ),

                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.nougat),
                          ),

                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,

                        child: TextButton(
                          onPressed: () {},

                          child: const Text(
                            'Esqueceu a senha?',

                            style: TextStyle(color: AppColors.nougat, fontSize: 11),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton(
                          onPressed: () {},

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF1E3C),

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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

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
                                color: Color(0xFFFF1E3C),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      const Center(
                        child: Text(
                          '© 2024 CineStream',

                          style: TextStyle(color: AppColors.mgray, fontSize: 10),
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
  }
}
