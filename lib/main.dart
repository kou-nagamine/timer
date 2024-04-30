import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tenminute = 0;
  int _minute = 0;
  int _tensecond = 0;
  int _second = 0;
  int _hudredmillisecond = 0;
  int _tenmillisecond = 0;
  Timer? _minutetimer;
  Timer? _secondtimer;
  Timer? _millisecondtimer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タイマー'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _tenminute.toString(),
                  style:TextStyle(
                    fontSize: 80,
                  )
                ),
                Text(
                  _minute.toString(),
                  style:TextStyle(
                    fontSize: 80,
                  )
                ),
                Column(
                  children: [
                    Text(
                      ':',
                      style:TextStyle(
                        fontSize: 80,
                      )
                    ),
                    SizedBox(height: 15)
                  ],
                ),                
                Text(
                  _tensecond.toString(),
                  style:TextStyle(
                    fontSize: 80,
                  )
                ),
                Text(
                  _second.toString(),
                  style:TextStyle(
                    fontSize: 80,
                  )
                ),
                Text(
                  '.',
                  style:TextStyle(
                    fontSize: 80,
                  )
                ),
                Text(
                  _hudredmillisecond.toString(),
                  style:TextStyle(
                    fontSize: 80,
                  )
                ),
                Text(
                  _tenmillisecond.toString(),
                  style:TextStyle(
                    fontSize: 80,
                  )
                ),  
              ]
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                toggleTimer();
              },
              child: Text(
                _isRunning ? 'ストップ' : 'スタート',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                resetTimer();
              },
              child: Text(
                'リセット',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]
        ) 
      ),
    );
  }

  void resetTimer() {
    _minutetimer?.cancel();
    _secondtimer?.cancel();
    _millisecondtimer?.cancel();


    setState(() {
      _tenminute = 0;
      _minute = 0;
      _tensecond = 0;
      _second = 0;
      _hudredmillisecond = 0;
      _tenmillisecond = 0;
      _isRunning = false;
    });
  }

  void toggleTimer() {
    if (_isRunning) {
      _minutetimer?.cancel();
      _secondtimer?.cancel();
      _millisecondtimer?.cancel();
    } else {
      _minutetimer = Timer.periodic(
        const Duration(minutes: 1),
        (timer){
          setState(() {
            _minute++;
            if (_minute == 10) {
              _minute = 0;
              _tenminute = (_tenminute + 1) % 6; 
            }
          });
        }
      );
      _secondtimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer){
          setState(() {
            _second++;
            if (_second == 10) {
              _second = 0;
              _tensecond = (_tensecond + 1) % 6;
            }
          });
        }
      );
      _millisecondtimer = Timer.periodic(
        const Duration(milliseconds: 10),
        (timer){
          setState(() {
            _tenmillisecond++;
            if (_tenmillisecond == 10) {
               _tenmillisecond = 0;
              _hudredmillisecond = (_hudredmillisecond + 1) % 10; 
            }
          });
        }
      );
    }
    setState(() {
    _isRunning = !_isRunning;
  });
  }
}