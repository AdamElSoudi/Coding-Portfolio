package com.example.spaceshooter

import android.content.res.Resources
import android.graphics.Canvas
import android.graphics.Paint
import kotlin.random.Random

const val BOSS_HEIGHT = 250
const val LASER_HEIGHT = 100

class EnemyBoss(private val res: Resources) : BitmapEntity() {
    private val TAG = "EnemyBoss"

    private var verticalMovementSpeed = 5f
    private val shootingProbability = 0.01 // 1% chance to shoot each frame
    private val lasers = mutableListOf<Laser>()

    init {
        val bmp = loadBitmap(res, R.drawable.destroyer, BOSS_HEIGHT)
        setSprite(flipVertically(bmp))


        // Set initial position to the right side of the screen
        x = STAGE_WIDTH - width - 300
        y = STAGE_HEIGHT / 2f - height / 2f
    }

    override fun update() {
        y += verticalMovementSpeed

        // Reverse the direction if the boss reaches the top or bottom of the screen
        if (y <= 0 || y + height >= STAGE_HEIGHT) {
            verticalMovementSpeed = -verticalMovementSpeed
        }

        if (Random.nextFloat() < shootingProbability) {
            shootLaser()
        }

        lasers.forEach { it.update() }

        val iterator = lasers.iterator()
        while (iterator.hasNext()) {
            val laser = iterator.next()
            if (laser.right() < 0) {
                iterator.remove()
            }
        }
    }

    private fun shootLaser() {
        val laserBitmap = loadBitmap(res, R.drawable.laser_red, LASER_HEIGHT)
        val laser = Laser(laserBitmap, x, y + height / 2f, Laser.Direction.LEFT)
        lasers.add(laser)
    }

    override fun render(canvas: Canvas, paint: Paint) {
        super.render(canvas, paint)

        lasers.forEach { it.render(canvas, paint) }
    }

    fun getLasers(): List<Laser> {
        return lasers
    }

    fun removeLaser(laser: Laser) {
        lasers.remove(laser)
    }
}
