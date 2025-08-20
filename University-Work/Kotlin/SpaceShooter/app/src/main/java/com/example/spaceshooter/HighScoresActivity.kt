package com.example.spaceshooter

import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.ListView
import androidx.appcompat.app.AppCompatActivity

private const val TAG = "HSActivity"

class HighScoresActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_high_scores)

        val highScoreManager = HighScoreManager(this)
        val scores = highScoreManager.getScores()
        Log.d(TAG, "Fetched Scores: $scores")

        val adapter = HighScoresAdapter(this, scores)
        val listView = findViewById<ListView>(R.id.highScoresListView)
        listView.adapter = adapter

        val backButton = findViewById<Button>(R.id.backButton)
        backButton.setOnClickListener {
            finish()
        }
    }
}
