import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:audio_player/audio_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // initPlatformState();
  }

  Future<void> playSound() async {

    // String dir = (await getApplicationDocumentsDirectory()).path;


    String result;
    try {
      result = await AudioPlayer.addSound('assets/network_disconnect.m4a');
    } on PlatformException {
      result = 'Failed to get platform version.';
    }
    print(result);
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RawMaterialButton(
            child: Text('Play'),
            onPressed: () {
              playSound();
            },
          ),
        ),
      ),
    );
  }
}
