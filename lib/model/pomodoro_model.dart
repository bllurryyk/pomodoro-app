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

  static PomodoroModel fromJson(Map<String, dynamic> data) => PomodoroModel(
      workTime: data['workTime'],
      shortBreak: data['shortBreak'],
      longBreak: data['longBreak'],
      cycles: data['cycles']);
}
