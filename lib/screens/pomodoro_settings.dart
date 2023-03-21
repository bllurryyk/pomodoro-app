import 'package:flutter/material.dart';
import 'package:pomodoro/screens/pomodoro.dart';
import 'package:pomodoro/widgets/pomodoro_form.dart';
import 'package:pomodoro/widgets/primary_button.dart';

class PomodoroSettingsScreen extends StatelessWidget {
  const PomodoroSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Configurações',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: PomodoroSettingsForm(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: PrimaryButton(
                buttonText: 'Salvar',
                routeWidget: PomodoroScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
