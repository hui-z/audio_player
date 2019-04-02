import 'dart:async';

import 'package:flutter/services.dart';

class AudioPlayer {
  static const MethodChannel _channel = const MethodChannel('audio_player');
  /// add sound
  static Future addSound(String path) async {
    return await _channel.invokeMethod('addSound', path);
  }
  /// remove all sound
  static Future removeAllSound() async {
    return await _channel.invokeMethod('removeAllSound');
  }
}
