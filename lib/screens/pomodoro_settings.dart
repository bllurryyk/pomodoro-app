import 'package:flutter/material.dart';
import 'package:pomodoro/screens/pomodoro.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:pomodoro/widgets/pomodoro_form.dart';
import 'package:pomodoro/widgets/primary_button_on_pressed.dart';

class PomodoroSettingsScreen extends StatefulWidget {
  const PomodoroSettingsScreen({super.key});

  @override
  State<PomodoroSettingsScreen> createState() => _PomodoroSettingsScreenState();
}

class _PomodoroSettingsScreenState extends State<PomodoroSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController cyclesController = TextEditingController();
    final TextEditingController workTimeController = TextEditingController();
    final TextEditingController shortBreakTimeController =
        TextEditingController();
    final TextEditingController longBreakTimeController =
        TextEditingController();

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
                'Pomodoro',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: PomodoroSettingsForm(
                cyclesController: cyclesController,
                workTimeController: workTimeController,
                shortBreakTimeController: shortBreakTimeController,
                longBreakTimeController: longBreakTimeController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: PrimaryButtonOnPressed(
                buttonText: 'Salvar',
                onPressed: () {
                  if (cyclesController.text.isNotEmpty) {
                    PomodoroSettings.updateSettings(
                      newCyclesController: int.parse(cyclesController.text),
                    );
                  }
                  if (workTimeController.text.isNotEmpty) {
                    PomodoroSettings.updateSettings(
                      newWorkTime: int.parse(workTimeController.text) * 60,
                    );
                  }
                  if (shortBreakTimeController.text.isNotEmpty) {
                    PomodoroSettings.updateSettings(
                      newShortBreakTime:
                          int.parse(shortBreakTimeController.text) * 60,
                    );
                  }
                  if (longBreakTimeController.text.isNotEmpty) {
                    PomodoroSettings.updateSettings(
                      newLongBreakTime:
                          int.parse(longBreakTimeController.text) * 60,
                    );
                  }
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
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
