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
  }

  Future<void> playSound() async {
    SoundPlayerUtil.addSoundName('network_disconnect.m4a',count: 3);
    // AudioPlayer.addSound('assets/network_disconnect.m4a');
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


class SoundPlayerUtil {
  static void addSoundName(String name, {int count = 1}) {
    for (var i = 0; i < count; i++) {
      AudioPlayer.addSound('assets/' + name);
    }
  }
}