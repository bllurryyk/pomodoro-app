import 'package:flutter/material.dart';
import 'package:pomodoro/model/pomodoro_status.dart';

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
        'Parabéns, você merece uma longa pausa, pronto para começar?',
  };

  static Map<PomodoroStatus, Color> statusColor = {
    PomodoroStatus.runningPomodoro: Colors.white,
    PomodoroStatus.pausedPomodoro: Colors.green,
    PomodoroStatus.runningShortBreak: Colors.blueAccent,
    PomodoroStatus.pausedShortBreak: Colors.green,
    PomodoroStatus.runningLongBreak: Colors.deepPurple,
    PomodoroStatus.pausedLongBreak: Colors.green,
    PomodoroStatus.setFinished: Colors.green,
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
