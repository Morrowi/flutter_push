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
  GameState gameState = GameState.readyToStart;

  Timer? witingTimer;
  Timer? stoppblTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.9),
            child: Text(
              'Test your\nreaction speed',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ColoredBox(
              color: Colors.white,
              child: SizedBox(
                height: 150,
                width: 300,
                child: Center(
                  child: Text(
                    mls,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.9),
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
                color: Colors.white70,
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Center(
                    child: Text(
                      _getButtonText(),
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
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
        return 'START';
      case GameState.waiting:
        return 'WAIT';
      case GameState.cantBeStopped:
        return "STOP";
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
