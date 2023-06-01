// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home.dart';
import 'package:pomodoro/screens/reset_password.dart';
import 'package:pomodoro/screens/signup.dart';
import 'package:pomodoro/widgets/login_form.dart';
import 'package:pomodoro/widgets/primary_button_method.dart';
import 'package:pomodoro/widgets/login_option.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key});

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> login() async {
      try {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );

        // Login successful, you can navigate to the desired screen here
      } catch (e) {
        // Handle login error here
        print('Login error: $e');
      }
    }

    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    const Text('Bem vindo de volta',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 32,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text('Novo neste aplicativo?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LogInForm(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      buttonText: 'Login',
                      method: login,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Ou faça o login com:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const LoginOption(),
                  ],
                ),
              ),
            ),
          );
        }

        // While Firebase is initializing, show a loading indicator
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
