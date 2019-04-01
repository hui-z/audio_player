import 'dart:async';

import 'package:flutter/services.dart';

class AudioPlayer {
  static const MethodChannel _channel = const MethodChannel('audio_player');

  static Future addSound(String name) async {
    return await _channel.invokeMethod('addSound', name);
  }

  static Future removeAllSound() async {
    return await _channel.invokeMethod('removeAllSound');
  }
}
