import 'package:flutter_audio_player/flutter_audio_player.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            RawMaterialButton(
              child: Text('network disconnect'),
              onPressed: () => SoundPlayerUtil.addSoundName(
                  'network_disconnect.m4a',
                  count: 3),
            ),
            RawMaterialButton(
              child: Text('printer disconnect'),
              onPressed: () => SoundPlayerUtil.addSoundName(
                  'printer_disconnect.m4a',
                  count: 3),
            ),
            RawMaterialButton(
              child: Text('remove all'),
              onPressed: () => SoundPlayerUtil.removeAllSound(),
            ),
          ],
        )),
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

  static void removeAllSound() {
    AudioPlayer.removeAllSound();
  }
}
