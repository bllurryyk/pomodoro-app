import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro/model/pomodoro_status.dart';
import 'package:pomodoro/screens/pomodoro_settings.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:pomodoro/widgets/progress_icon.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

const _btnPlay = Icon(Icons.play_arrow_rounded);
const _btnPause = Icon(Icons.pause_rounded);
const _btnStop = Icon(Icons.stop_rounded);

class _PomodoroScreenState extends State<PomodoroScreen> {
  int remainingTime = pomodoroTotalTime;
  Icon mainBtn = _btnPlay;
  PomodoroStatus pomodoroStatus = PomodoroStatus.pausedPomodoro;
  Timer? _timer;
  int pomodoroNum = 0;
  int setNum = 0;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        shadowColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PomodoroSettingsScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 220.0,
                      lineWidth: 5.0,
                      percent: _getPomodoroPercentage(),
                      progressColor: statusColor[pomodoroStatus],
                      backgroundColor: Colors.red,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _secondsToFormatedString(remainingTime),
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              statusDescription[pomodoroStatus]!,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ProgressIcons(
                      total: pomodoriPerSet,
                      done: pomodoroNum - (setNum * pomodoriPerSet),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: _mainButtonPressed,
                          icon: mainBtn,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        IconButton(
                          onPressed: _resetButtonPressed,
                          icon: _btnStop,
                          color: Colors.white,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _secondsToFormatedString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - (roundedMinutes * 60);
    String remaingSecondsFormated;

    if (remainingSeconds < 10) {
      remaingSecondsFormated = '0$remainingSeconds';
    } else {
      remaingSecondsFormated = remainingSeconds.toString();
    }

    return '$roundedMinutes:$remaingSecondsFormated';
  }

  _getPomodoroPercentage() {
    int totalTime;

    switch (pomodoroStatus) {
      case PomodoroStatus.runningPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.pausedPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.runningShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroStatus.pausedShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroStatus.runningLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.pausedLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.setFinished:
        totalTime = pomodoroTotalTime;
        break;
    }

    double percentage = (totalTime - remainingTime) / totalTime;

    return percentage;
  }

  _mainButtonPressed() {
    switch (pomodoroStatus) {
      case PomodoroStatus.runningPomodoro:
        _pausePomodoroCountingdown();
        break;
      case PomodoroStatus.pausedPomodoro:
        _startPomodoroCountingdown();
        break;
      case PomodoroStatus.runningShortBreak:
        _pausedShortBreakCountdown();
        break;
      case PomodoroStatus.pausedShortBreak:
        _startShortBreak();
        break;
      case PomodoroStatus.runningLongBreak:
        _pausedLongBreakCountdown();
        break;
      case PomodoroStatus.pausedLongBreak:
        _startLongBreak();
        break;
      case PomodoroStatus.setFinished:
        setNum++;
        _startPomodoroCountingdown();
        break;
    }
  }

  _startPomodoroCountingdown() {
    pomodoroStatus = PomodoroStatus.runningPomodoro;
    _cancelTimer();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => {
        if (remainingTime > 0)
          {
            setState(
              () {
                remainingTime--;
                mainBtn = _btnPause;
              },
            ),
          }
        else
          {
            _playSound(),
            pomodoroNum++,
            _cancelTimer(),
            if (pomodoroNum % pomodoriPerSet == 0)
              {
                pomodoroStatus = PomodoroStatus.pausedLongBreak,
                setState(
                  () {
                    remainingTime = longBreakTime;
                    mainBtn = _btnPlay;
                  },
                ),
              }
            else
              {
                pomodoroStatus = PomodoroStatus.pausedShortBreak,
                setState(
                  () {
                    remainingTime = shortBreakTime;
                    mainBtn = _btnPlay;
                  },
                ),
              }
          },
      },
    );
  }

  _pausePomodoroCountingdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    _cancelTimer();
    setState(
      () {
        mainBtn = _btnPlay;
      },
    );
  }

  _resetButtonPressed() {
    pomodoroNum = 0;
    setNum = 0;
    _cancelTimer();
    _stopCountdown();
  }

  _stopCountdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    setState(() {
      mainBtn = _btnPlay;
      remainingTime = pomodoroTotalTime;
    });
  }

  _pausedShortBreakCountdown() {
    pomodoroStatus = PomodoroStatus.pausedShortBreak;
    _pausedBreakCountdown();
  }

  _pausedLongBreakCountdown() {
    pomodoroStatus = PomodoroStatus.pausedLongBreak;
    _pausedBreakCountdown();
  }

  _pausedBreakCountdown() {
    _cancelTimer();
    setState(() {
      mainBtn = _btnPlay;
    });
  }

  _startShortBreak() {
    setState(
      () {
        mainBtn = _btnPause;
      },
    );
    pomodoroStatus = PomodoroStatus.runningShortBreak;
    _cancelTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingTime > 0) {
          setState(
            () {
              remainingTime--;
            },
          );
        } else {
          _playSound();
          remainingTime = pomodoroTotalTime;
          _cancelTimer();
          pomodoroStatus = PomodoroStatus.pausedPomodoro;
          setState(() {
            mainBtn = _btnPlay;
          });
        }
      },
    );
  }

  _startLongBreak() {
    setState(
      () {
        mainBtn = _btnPause;
      },
    );
    pomodoroStatus = PomodoroStatus.runningLongBreak;
    _cancelTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingTime > 0) {
          setState(
            () {
              remainingTime--;
            },
          );
        } else {
          _playSound();
          remainingTime = pomodoroTotalTime;
          _cancelTimer();
          pomodoroStatus = PomodoroStatus.setFinished;
          setState(() {
            mainBtn = _btnPlay;
          });
        }
      },
    );
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  _playSound() {}
}
