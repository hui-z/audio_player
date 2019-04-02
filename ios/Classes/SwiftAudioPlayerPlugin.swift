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
    var soundDict:[String:SystemSoundID] = [:]
    init(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "addSound":
            guard let path = call.arguments as? String else {return}
            addSound(path: path)
        case "removeAllSound":
            removeAllSound()
        default:
            result("error: not Implemented")
        }
    }
    private func addSound(path: String) {
        playList.append(path)
        if (!playing) {
            playNext()
        }
        
    }
    private func removeAllSound(){
        playList.removeAll()
    }
    private func playNext() {
        if (playList.count > 0) {
            let path = playList[0]
            playList.remove(at: 0)
            playSound(path: path)
        }
    }
    
    private func playSound(path: String ) {
        var soundId:SystemSoundID = 0
        if let sid = soundDict[path] {
            soundId = sid
        } else {
            let assetPath = registrar.lookupKey(forAsset: path)
            guard let urlString = Bundle.main.path(forResource: assetPath, ofType: nil) else { return }
            let url = URL(fileURLWithPath: urlString)
            AudioServicesCreateSystemSoundID(url as CFURL, &soundId)
            soundDict[path] = soundId
        }
        playing = true
        AudioServicesPlaySystemSoundWithCompletion(soundId) {
            self.playing = false
            self.playNext()
        }
    }
}
