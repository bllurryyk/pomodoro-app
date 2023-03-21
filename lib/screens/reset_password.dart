import 'package:flutter/material.dart';
import 'package:pomodoro/screens/login.dart';
import 'package:pomodoro/widgets/primary_button.dart';
import 'package:pomodoro/widgets/reset_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 250,
            ),
            const Text(
              'Redefinir senha',
              style: TextStyle(
                  color: Colors.red, fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Por favor, informe o seu endereço de e-mail',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const ResetForm(),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogInScreen(),
                      ));
                },
                child: const PrimaryButton(
                  buttonText: 'Redefinir senha',
                  routeWidget: LogInScreen(),
                )),
          ],
        ),
      ),
    );
  }
}
