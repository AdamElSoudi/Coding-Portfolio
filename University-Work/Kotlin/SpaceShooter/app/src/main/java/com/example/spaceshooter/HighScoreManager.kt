package com.example.spaceshooter

import android.annotation.SuppressLint
import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.database.DatabaseUtils
import android.database.sqlite.SQLiteDatabase
import android.util.Log

private const val TAG = "HighScore"

class HighScoreManager(context: Context) {
    private val dbHelper: DatabaseHelper = DatabaseHelper(context)

    fun saveScore(score: Int) {
        val db: SQLiteDatabase = dbHelper.writableDatabase
        val contentValues = ContentValues()
        contentValues.put("SCORE", score)

        val rowID = db.insert(DatabaseHelper.TABLE_NAME, null, contentValues)
        if (rowID == -1L) {
            Log.e(TAG, "Failed to insert new score into the database.")
        } else {
            Log.d(TAG, "Score successfully inserted with row ID: $rowID")
        }
        cleanupScores()
        Log.d(TAG, "Score successfully inserted with row ID: $rowID")
    }

    @SuppressLint("Range")
    fun getScores(): List<Int> {
        val scores = mutableListOf<Int>()
        val db: SQLiteDatabase = dbHelper.readableDatabase

        val cursor: Cursor = db.rawQuery("SELECT SCORE FROM ${DatabaseHelper.TABLE_NAME} ORDER BY SCORE DESC LIMIT 10", null)

        if (cursor.moveToFirst()) {
            do {
                scores.add(cursor.getInt(cursor.getColumnIndex("SCORE")))
            } while (cursor.moveToNext())
        }
        cursor.close()
        return scores
    }

    fun cleanupScores() {
        val db: SQLiteDatabase = dbHelper.writableDatabase
        val beforeCount = DatabaseUtils.queryNumEntries(db, DatabaseHelper.TABLE_NAME)
        Log.d(TAG, "Number of scores before cleanup: $beforeCount")

        // Delete all scores except the top 10.
        db.execSQL("DELETE FROM ${DatabaseHelper.TABLE_NAME} WHERE ROWID NOT IN (SELECT ROWID FROM ${DatabaseHelper.TABLE_NAME} ORDER BY SCORE DESC LIMIT 10)")

        val afterCount = DatabaseUtils.queryNumEntries(db, DatabaseHelper.TABLE_NAME)
        Log.d(TAG, "Number of scores after cleanup: $afterCount")

        val count = DatabaseUtils.queryNumEntries(db, DatabaseHelper.TABLE_NAME)
        Log.d(TAG, "Total number of rows: $count")

    }


}