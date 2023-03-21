import 'package:flutter/material.dart';
import 'package:pomodoro/model/pomodoro_status.dart';

const pomodoroTotalTime = 25 * 60;
const shortBreakTime = 5 * 60;
const longBreakTime = 15 * 60;
const pomodoriPerSet = 4;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.runningPomodoro: 'Hora de se concentrar!',
  PomodoroStatus.pausedPomodoro: 'Pronto?',
  PomodoroStatus.runningShortBreak: 'Pausa curta, hora de relaxar!',
  PomodoroStatus.pausedShortBreak: 'Vamos fazer uma pequena pausa?',
  PomodoroStatus.runningLongBreak: 'Pausa longa, hora de relaxar!',
  PomodoroStatus.pausedLongBreak: 'Vamos fazer uma pausa?',
  PomodoroStatus.setFinished:
      'Parabéns, você merece uma longa pausa, pronto para começar?',
};

const Map<PomodoroStatus, Color> statusColor = {
  PomodoroStatus.runningPomodoro: Colors.white,
  PomodoroStatus.pausedPomodoro: Colors.green,
  PomodoroStatus.runningShortBreak: Colors.blueAccent,
  PomodoroStatus.pausedShortBreak: Colors.green,
  PomodoroStatus.runningLongBreak: Colors.deepPurple,
  PomodoroStatus.pausedLongBreak: Colors.green,
  PomodoroStatus.setFinished: Colors.green,
};
