import 'package:flutter/material.dart';

class PomodoroSettings {
  static int workTime = 25 * 60;
  static int shortBreakTime = 5 * 60;
  static int longBreakTime = 15 * 60;
  static int cyclesController = 4;

  static Map<PomodoroStatus, String> statusDescription = {
    PomodoroStatus.runningPomodoro: 'Hora de se concentrar!',
    PomodoroStatus.pausedPomodoro: 'Pronto?',
    PomodoroStatus.runningShortBreak: 'Pausa curta, hora de relaxar!',
    PomodoroStatus.pausedShortBreak: 'Vamos fazer uma pequena pausa?',
    PomodoroStatus.runningLongBreak: 'Pausa longa, hora de relaxar!',
    PomodoroStatus.pausedLongBreak: 'Vamos fazer uma pausa?',
    PomodoroStatus.setFinished:
        'Parabéns, você completou todo o ciclo, pronto para começar?',
  };

  static Map<PomodoroStatus, Color> statusColor = {
    PomodoroStatus.runningPomodoro: Colors.white,
    PomodoroStatus.pausedPomodoro: Colors.white.withOpacity(0.5),
    PomodoroStatus.runningShortBreak: Colors.white,
    PomodoroStatus.pausedShortBreak: Colors.white.withOpacity(0.5),
    PomodoroStatus.runningLongBreak: Colors.white,
    PomodoroStatus.pausedLongBreak: Colors.white.withOpacity(0.5),
    PomodoroStatus.setFinished: Colors.white.withOpacity(0.9),
  };

  static void updateSettings({
    int? newWorkTime,
    int? newShortBreakTime,
    int? newLongBreakTime,
    int? newCyclesController,
  }) {
    if (newWorkTime != null) {
      workTime = newWorkTime;
    } else {
      workTime = workTime;
    }
    if (newShortBreakTime != null) {
      shortBreakTime = newShortBreakTime;
    } else {
      shortBreakTime = shortBreakTime;
    }
    if (newLongBreakTime != null) {
      longBreakTime = newLongBreakTime;
    } else {
      longBreakTime = longBreakTime;
    }
    if (newCyclesController != null) {
      cyclesController = newCyclesController;
    } else {
      cyclesController = cyclesController;
    }
  }
}

enum PomodoroStatus {
  runningPomodoro,
  pausedPomodoro,
  runningShortBreak,
  pausedShortBreak,
  runningLongBreak,
  pausedLongBreak,
  setFinished,
}

class PomodoroModel {
  int workTime;
  int shortBreak;
  int longBreak;
  int cycles;

  PomodoroModel({
    required this.workTime,
    required this.shortBreak,
    required this.longBreak,
    required this.cycles,
  });

  Map<String, dynamic> toJason() => {
        'workTime': workTime,
        'shortBreak': shortBreak,
        'longBreak': longBreak,
        'cycles': cycles,
      };
}
