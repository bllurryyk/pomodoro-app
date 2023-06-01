import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home.dart';
import 'package:pomodoro/screens/login.dart';
import 'package:pomodoro/widgets/primary_button_method.dart';
import 'package:pomodoro/widgets/checkbox.dart';
import 'package:pomodoro/widgets/login_option.dart';
import 'package:pomodoro/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController surnameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    Future<void> _createAccount() async {
      final String name = nameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
        );

        // Você pode adicionar código aqui para salvar os detalhes adicionais do usuário, como nome, sobrenome, etc.

        // Redirecione para a tela de Home após o cadastro bem-sucedido
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('A senha é muito fraca.');
        } else if (e.code == 'email-already-in-use') {
          print('O e-mail já está sendo usado por outra conta.');
        } else {
          print('Erro durante o cadastro do usuário: ${e.message}');
        }
      } catch (e) {
        print('Erro desconhecido durante o cadastro do usuário: $e');
      }
    }

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
                method: _createAccount,
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
