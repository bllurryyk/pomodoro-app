import 'package:flutter/material.dart';

class PomodoroSettingsForm extends StatefulWidget {
  const PomodoroSettingsForm({
    Key? key,
    required this.cyclesController,
    required this.workTimeController,
    required this.shortBreakTimeController,
    required this.longBreakTimeController,
  }) : super(key: key);

  final TextEditingController cyclesController;
  final TextEditingController workTimeController;
  final TextEditingController shortBreakTimeController;
  final TextEditingController longBreakTimeController;

  @override
  _PomodoroSettingsFormState createState() => _PomodoroSettingsFormState();
}

class _PomodoroSettingsFormState extends State<PomodoroSettingsForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Ciclos', widget.cyclesController, false),
        buildInputForm('Tempo de trabalho', widget.workTimeController, false),
        buildInputForm('Pausa curta', widget.shortBreakTimeController, false),
        buildInputForm('Pausa longa', widget.longBreakTimeController, false),
      ],
    );
  }

  Padding buildInputForm(
      String label, TextEditingController controller, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF979797),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
