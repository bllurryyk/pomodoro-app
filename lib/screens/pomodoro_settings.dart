import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:pomodoro/widgets/pomodoro_form.dart';
import 'package:pomodoro/widgets/primary_button_on_pressed.dart';

class PomodoroSettingsScreen extends StatefulWidget {
  const PomodoroSettingsScreen({super.key});

  @override
  State<PomodoroSettingsScreen> createState() => _PomodoroSettingsScreenState();
}

class _PomodoroSettingsScreenState extends State<PomodoroSettingsScreen> {
  Future<void> updateCycle(int cycle) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'cycles': cycle});
    }
  }

  Future<void> updateWorkTime(int workTime) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'workTime': workTime});
    }
  }

  Future<void> updateShortBreak(int shortBreak) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'shortBreak': shortBreak});
    }
  }

  Future<void> updateLongBreak(int longBreak) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'longBreak': longBreak});
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController cyclesController = TextEditingController();
    final TextEditingController workTimeController = TextEditingController();
    final TextEditingController shortBreakTimeController =
        TextEditingController();
    final TextEditingController longBreakTimeController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
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
                    updateCycle(int.parse(cyclesController.text));
                  }
                  if (workTimeController.text.isNotEmpty) {
                    PomodoroSettings.updateSettings(
                      newWorkTime: int.parse(workTimeController.text) * 60,
                    );
                    updateWorkTime(int.parse(workTimeController.text));
                  }
                  if (shortBreakTimeController.text.isNotEmpty) {
                    PomodoroSettings.updateSettings(
                      newShortBreakTime:
                          int.parse(shortBreakTimeController.text) * 60,
                    );
                    updateShortBreak(int.parse(shortBreakTimeController.text));
                  }
                  if (longBreakTimeController.text.isNotEmpty) {
                    PomodoroSettings.updateSettings(
                      newLongBreakTime:
                          int.parse(longBreakTimeController.text) * 60,
                    );
                    updateLongBreak(int.parse(longBreakTimeController.text));
                  }
                  setState(() {
                    PomodoroSettings.workTime =
                        int.parse(workTimeController.text) * 60;
                    PomodoroSettings.shortBreakTime =
                        int.parse(shortBreakTimeController.text) * 60;
                    PomodoroSettings.longBreakTime =
                        int.parse(longBreakTimeController.text) * 60;
                    PomodoroSettings.cyclesController =
                        int.parse(cyclesController.text);
                  });
                  Navigator.pop(context, true);
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
