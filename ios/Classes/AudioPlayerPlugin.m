#import "AudioPlayerPlugin.h"
#import <audio_player/audio_player-Swift.h>

@implementation AudioPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAudioPlayerPlugin registerWithRegistrar:registrar];
}
@end
