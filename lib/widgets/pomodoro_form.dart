import 'package:flutter/material.dart';

class PomodoroSettingsForm extends StatefulWidget {
  const PomodoroSettingsForm({super.key});

  @override
  State<PomodoroSettingsForm> createState() => _PomodoroSettingsFormState();
}

class _PomodoroSettingsFormState extends State<PomodoroSettingsForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Ciclos', false),
        buildInputForm('Tempo de trabalho', false),
        buildInputForm('Pausa curta', false),
        buildInputForm('Pausa longa', false),
      ],
    );
  }

  Padding buildInputForm(String hint, bool pass) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF979797)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
          ),
        ));
  }
}
