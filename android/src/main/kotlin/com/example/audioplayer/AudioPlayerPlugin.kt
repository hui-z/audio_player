package com.example.audioplayer

import android.media.MediaPlayer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class AudioPlayerPlugin : MethodCallHandler, MediaPlayer.OnPreparedListener, MediaPlayer.OnCompletionListener {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "audio_player")
            channel.setMethodCallHandler(AudioPlayerPlugin(registrar))
        }
    }

    private val registrar: Registrar
    private var player: MediaPlayer
    private val playList: MutableList<String>
    private var playing: Boolean

    constructor(registrar: Registrar) {

        this.registrar = registrar
        this.player = MediaPlayer()
        this.playList = emptyArray<String>().toMutableList()
        this.playing = false
        player.setOnPreparedListener(this)
        player.setOnCompletionListener(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "addSound" -> {
                val arg = call.arguments as? String ?: return
                addSound(arg)
            }
            "removeAllSound" -> {
                removeAllSound()
            }
            else -> {
                result.notImplemented()
            }
        }
    }
    private fun addSound(path: String) {
        playList.add(path)
        if (!player.isPlaying && !playing) {
            playNext()
        }
    }
    private fun removeAllSound() {
        playList.removeAll { true }
    }
    private fun playNext() {
        if (playList.count() > 0) {
            val path = playList[0]
            playList.removeAt(0)
            playSound(path)
        }

    }

    private fun playSound(path: String) {
        playing = true
        val assetManager = registrar.context().assets
        val assetLookupKey = registrar.lookupKeyForAsset(path)
        val input = assetManager.openFd(assetLookupKey)
        player.reset()
        player.setDataSource(input.fileDescriptor, input.startOffset, input.length)
        input.close()
        player.prepareAsync()
    }

    override fun onPrepared(mp: MediaPlayer?) {
        mp?.start()
    }

    override fun onCompletion(mp: MediaPlayer?) {
        playing = false
        playNext()
    }
}
