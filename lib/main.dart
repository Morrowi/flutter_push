import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mls = "";
  int bgColorBtn = 0xFF40CA88;
  GameState gameState = GameState.readyToStart;

  Timer? witingTimer;
  Timer? stoppblTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF282E3D),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.8),
            child: Text(
              'Test your\nreaction speed',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ColoredBox(
              color: Color(0xFF6D6D6D),
              child: SizedBox(
                height: 150,
                width: 300,
                child: Center(
                  child: Text(
                    mls,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: GestureDetector(
              onTap: () => setState(() {
                switch (gameState) {
                  case GameState.readyToStart:
                    gameState = GameState.waiting;
                    mls="";
                    _startWaitingTime();
                    break;
                  case GameState.waiting:
                    break;
                  case GameState.cantBeStopped:

                    gameState = GameState.readyToStart;
                    stoppblTimer?.cancel();
                    break;
                }
              }),
              child: ColoredBox(
                color: Color(_getButtonBgColor()),
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Center(
                    child: Text(
                      _getButtonText(),
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText() {
    switch (gameState) {
      case GameState.readyToStart:
        setState(() {
          bgColorBtn=0xFF40CA88;
        });
        return 'START';
      case GameState.waiting:
        setState(() {
          bgColorBtn=0xFFE0982D;
        });
        return 'WAIT';
      case GameState.cantBeStopped:
        setState(() {
          bgColorBtn=0xFFE02D47;
        });
        return "STOP";
    }
  }

  int _getButtonBgColor() {
    switch (gameState) {
      case GameState.readyToStart:
        return 0xFF40CA88;
      case GameState.waiting:
        return 0xFFE0982D;
      case GameState.cantBeStopped:
        return 0xFFE02D47;
    }
  }

  void _startWaitingTime() {
    final int rms = Random().nextInt(4000) + 1000;
    witingTimer = Timer(Duration(milliseconds: rms), () {
      setState(() {
        gameState = GameState.cantBeStopped;
      });
      _startStobplTimer();
    });
  }

  void _startStobplTimer() {
    stoppblTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        mls = "${timer.tick * 16} ms";
      });
    });
  }

  @override
  void dispose() {
    witingTimer?.cancel();
    stoppblTimer?.cancel();
    super.dispose();
  }
}

enum GameState { readyToStart, waiting, cantBeStopped }
