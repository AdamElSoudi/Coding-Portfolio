package com.example.spaceshooter

import android.media.MediaPlayer
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.KeyEvent

class GameActivity : AppCompatActivity() {
    private val TAG = "GameActivity"
    lateinit var game : Game

    private lateinit var mediaPlayer: MediaPlayer

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mediaPlayer = MediaPlayer.create(this, R.raw.background_music)
        mediaPlayer.isLooping = true
        game = Game(this)
        setContentView(game)
        Log.d(TAG, "onCreate called!!")
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        if (keyCode == KeyEvent.KEYCODE_SPACE) {
            game.shootLaser()
            return true
        }
        return super.onKeyDown(keyCode, event)
    }

    override fun onPause() {
        mediaPlayer.pause()
        game.pause()
        super.onPause()
    }

    override fun onResume() {
        super.onResume()
        mediaPlayer.start()
        game.resume()
    }

    override fun onDestroy() {
        mediaPlayer.stop()
        mediaPlayer.release()
        super.onDestroy()
    }
}