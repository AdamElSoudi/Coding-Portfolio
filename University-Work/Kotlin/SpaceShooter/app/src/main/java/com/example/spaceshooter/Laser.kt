package com.example.spaceshooter

import android.graphics.Bitmap

class Laser(laserBitmap: Bitmap, startX: Float, startY: Float, private val direction: Direction) : BitmapEntity() {
    private val TAG = "Laser"
    private val speed = 10f

    enum class Direction {
        LEFT, RIGHT
    }

    init {
        setSprite(laserBitmap)
        x = startX
        y = startY
    }

    override fun update() {
        when (direction) {
            Direction.LEFT -> x -= speed
            Direction.RIGHT -> x += speed
        }
    }
}
