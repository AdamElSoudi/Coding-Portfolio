package com.example.spaceshooter

import android.annotation.SuppressLint
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView

private const val TAG = "MainActivity"
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        Log.d(TAG, "Deleted db")
        val dbHelper = DatabaseHelper(this)
        //dbHelper.deleteDatabase()

        findViewById<Button>(R.id.startGameButton)?.setOnClickListener {
            val intent = Intent(this, GameActivity::class.java)
            startActivity(intent)
        }

        findViewById<Button>(R.id.highScoresButton)?.setOnClickListener {
            val backIntent = Intent(this, HighScoresActivity::class.java)
            startActivity(backIntent)
        }
    }


    override fun onResume() {
        super.onResume()

        //val prefs = getSharedPreferences(PREFS, MODE_PRIVATE)
        //val longestDistance = prefs.getInt(LONGEST_DIST, 0)
        val highscoreTextView = findViewById<TextView>(R.id.highscore)
        val highScoreManager = HighScoreManager(this)
        val scores = highScoreManager.getScores()

        if (scores.isNotEmpty()) {
            val topScore = scores[0]
            highscoreTextView.text = getString(R.string.longest_distance, topScore)
        } else {
            highscoreTextView.text = getString(R.string.no_scores_available)
        }
    }
}