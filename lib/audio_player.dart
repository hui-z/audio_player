import 'dart:async';

import 'package:flutter/services.dart';

class AudioPlayer {
  static const MethodChannel _channel =
  const MethodChannel('audio_player');

  static Future<String> addSound(String name) async {
    return await _channel.invokeMethod('addSound',name);
  }
}
