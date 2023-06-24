import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String hoursString = "00", minuteString = "00", secondsString = "00";
  int hours = 0, minutes = 0, seconds = 0;
  bool isTimerRunning = false, isReset = false;
  late Timer _timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _startSecond();
    });
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      isTimerRunning = false;
    });
    isReset = checkValues();
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      seconds = 0;
      hours = 0;
      minutes = 0;
      secondsString = "00";
      minuteString = "00";
      hoursString = "00";
    });
  }

  void _startSecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondsString = seconds.toString();
        if (secondsString.length == 1) {
          secondsString = "0" + secondsString;
        }
      } else {
        _startMinute();
      }
    });
  }

  void _startMinute() {
    setState(() {
      if (minutes < 59) {
        seconds = 0;
        secondsString = "00";
        minutes++;
        minuteString = minutes.toString();
        if (minuteString.length == 1) {
          minuteString = "0" + minuteString;
        }
      } else {
        _startHour();
      }
    });
  }

  void _startHour() {
    setState(() {
      minutes = 0;
      seconds = 0;
      minuteString = "00";
      secondsString = "00";
      hours++;
      hoursString = hours.toString();
      if (hoursString.length == 1) {
        hoursString = "0" + hoursString;
      }
    });
  }

  bool checkValues() {
    if (seconds != 0 || minutes != 0 || hours != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F253B),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 240,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff5F8DF7),
                    width: 5,
                  )),
              child: Text(
                "$hoursString:$minuteString:$secondsString",
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: const EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () {
                    if (isTimerRunning) {
                      pauseTimer();
                    } else {
                      startTimer();
                    }
                  },
                  child: Text(
                    isTimerRunning ? "Pause" : "Play",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff5F8DF7),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(30),
                child: isReset
                    ? ElevatedButton(
                        onPressed: () {
                          resetTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff5F8DF7),
                        ),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ))
                    : SizedBox(
                        height: 20,
                      ),
              ),
            ]),
          ],
        ),
      )),
    );
  }
}
