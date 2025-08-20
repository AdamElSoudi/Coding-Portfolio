package com.example.spaceshooter

import android.content.res.AssetFileDescriptor
import android.content.res.AssetManager
import android.media.AudioAttributes
import android.media.SoundPool
import android.util.Log
import java.io.IOException

object SFX{
    var crash = 0
    var death = 0
    var laser = 0
    var enemy_hit = 0
    var boosting = 0
    var slowing_boost = 0
    var projectile = 0
}

const val MAX_STREAMS = 3

class Jukebox(private val assetManager: AssetManager) {
    private val TAG = "Jukebox"
    var soundPool: SoundPool
    private var crashCount = 0

    init {
        val attr = AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_GAME)
            .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
            .build()

        soundPool = SoundPool.Builder()
            .setAudioAttributes(attr)
            .setMaxStreams(MAX_STREAMS)
            .build()


        Log.d(TAG, "soundpool created!")
        SFX.crash = loadSound("crash.wav")
        SFX.death = loadSound("death.wav")
        SFX.laser = loadSound("laser_hit.wav")
        SFX.enemy_hit = loadSound("enemy_hit.mp3")
        SFX.boosting = loadSound("boosting.wav")
        SFX.slowing_boost = loadSound("slowing_boost.mp3")
        SFX.projectile = loadSound("projectile.mp3")
    }

    private fun loadSound(fileName: String): Int {
        try {
            val descriptor: AssetFileDescriptor = assetManager.openFd(fileName)
            Log.d(TAG, "$fileName loaded successfully.")
            return soundPool.load(descriptor, 1)
        } catch (e: IOException) {
            Log.e(
                TAG,
                "Unable to load $fileName! Check the filename, and make sure it's in the assets-folder."
            )
        }
        return 0
    }

    fun play(soundID: Int) {
        val leftVolume = 1f
        val rightVolume = 1f
        val priority = 0
        val loop = 0
        var playbackRate = 1.0f

        if (soundID == SFX.boosting) {
            //speed of sound
            playbackRate = 1.5f
        }

        if (soundID > 0) {
            if (soundID == SFX.crash) {
                crashCount++
                if (crashCount >= 3) {
                    // Play "death.wav" after 3 crashes
                    soundPool.play(SFX.death, leftVolume, rightVolume, priority, loop, playbackRate)
                    crashCount = 0 // Reset crash count
                } else {
                    soundPool.play(soundID, leftVolume, rightVolume, priority, loop, playbackRate)
                }
            } else {
                soundPool.play(soundID, leftVolume, rightVolume, priority, loop, playbackRate)
            }
        }
    }
}