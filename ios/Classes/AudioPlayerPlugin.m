#import "AudioPlayerPlugin.h"
#import <flutter_audio_player/flutter_audio_player-Swift.h>

@implementation AudioPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAudioPlayerPlugin registerWithRegistrar:registrar];
}
@end
