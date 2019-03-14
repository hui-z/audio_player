import Flutter
import UIKit
import AVFoundation

public class SwiftAudioPlayerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "audio_player", binaryMessenger: registrar.messenger())
        let instance = SwiftAudioPlayerPlugin(with: registrar)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    let registrar: FlutterPluginRegistrar
    var playing:Bool = false
    var playList:[String] = []
    init(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "addSound" {
            guard let path = call.arguments as? String else {return}
            addSound(path: path)
        } else {
            result("error: not Implemented")
        }
    }
    private func addSound(path: String) {
        playList.append(path)
        if (!playing) {
            playNext()
        }
        
    }
    private func playNext() {
        if (playList.count > 0) {
            let path = playList[0]
            playList.remove(at: 0)
            playSound(path: path)
        }
    }
    
    private func playSound(path: String ) {
        let assetPath = registrar.lookupKey(forAsset: path)
        if let urlString = Bundle.main.path(forResource: assetPath, ofType: nil) {
            let url = URL(fileURLWithPath: urlString)
            var soundId:SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url as CFURL, &soundId)
            playing = true
            AudioServicesPlaySystemSoundWithCompletion(soundId) {
                self.playNext()
            }
        }
    }
}
