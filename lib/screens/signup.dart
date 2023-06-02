// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/check.dart';
import 'package:pomodoro/screens/login.dart';
import 'package:pomodoro/utils/toast_utils.dart';
import 'package:pomodoro/widgets/primary_button_method.dart';
import 'package:pomodoro/widgets/checkbox.dart';
import 'package:pomodoro/widgets/login_option.dart';
import 'package:pomodoro/widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> createUserInFirestore(String email) async {
    final User? user = _firebaseAuth.currentUser;
    final String? userId = user?.uid;

    if (userId != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'workTime': 25,
        'shortBreak': 5,
        'longBreak': 15,
        'cycles': 4,
      });
    }
  }

  Future<void> createAccount() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.updateDisplayName(nameController.text);
      await createUserInFirestore(email);
      ToastUtils.showSuccessToast('Cadastro realizado com sucesso!');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ChecarPage(),
          ),
          (route) => false);

      // Redirecione para a tela de Home após o cadastro bem-sucedido
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ToastUtils.showErrorToast('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        ToastUtils.showErrorToast(
            'O e-mail já está sendo usado por outra conta.');
      } else {
        ToastUtils.showErrorToast(
            'Erro durante o cadastro do usuário: ${e.message}');
      }
    } catch (e) {
      ToastUtils.showErrorToast(
          'Erro desconhecido durante o cadastro do usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Criar uma conta',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  const Text(
                    'Já tem uma conta?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SignUpForm(
                nameController: nameController,
                surnameController: surnameController,
                emailController: emailController,
                phoneController: phoneController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CheckBox(
                text: 'Concordo com os',
                link: 'termos e condições',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: PrimaryButton(
                buttonText: 'Cadastrar',
                method: createAccount,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Ou faça o login com:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: LoginOption(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
