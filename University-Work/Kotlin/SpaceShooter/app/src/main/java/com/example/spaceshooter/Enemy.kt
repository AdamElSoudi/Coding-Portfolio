package com.example.spaceshooter

import android.content.res.Resources
//import android.graphics.Canvas
//import android.graphics.Color
//import android.graphics.Paint
import kotlin.math.sin

const val ENEMY_HEIGHT = 450
const val ENEMY_SPAWN_OFFSET = STAGE_WIDTH * 2

class Enemy(res: Resources) : BitmapEntity() {

    override val collisionBoxScale = 0.2f
    private var frequency = 0.01
    private var amplitude = 5f

    init {
        var id = R.drawable.enemy_1

        when(RNG.nextInt(0,6)) {
            0 -> id = R.drawable.enemy_1
            1 -> id = R.drawable.enemy_2
            2 -> id = R.drawable.enemy_3
            3 -> id = R.drawable.enemy_4
            4 -> id = R.drawable.enemy_5
            5 -> id = R.drawable.enemy_6
        }

        val bmp = loadBitmap(res, id, ENEMY_HEIGHT)
        setSprite(flipVertically(bmp))
        respawn()
    }

    override fun respawn() {
        x = (STAGE_WIDTH + RNG.nextInt(ENEMY_SPAWN_OFFSET).toFloat())
        y = RNG.nextInt(STAGE_HEIGHT - ENEMY_HEIGHT).toFloat()
    }

    override fun update() {
        velX = -playerSpeed
        x += velX

        y += (sin(x * frequency) * amplitude).toFloat()

        if (x + bitmap.width < 0) {
            respawn()
        }
    }

    override fun onCollision(that: Entity) {
        respawn()
    }

//    override fun render(canvas: Canvas, paint: Paint) {
//        super.render(canvas, paint)
//
//        // Debug: Draw hitbox
//        val debugPaint = Paint()
//        debugPaint.color = Color.RED
//        debugPaint.style = Paint.Style.STROKE
//        debugPaint.strokeWidth = 3f
//        val offsetX = (bitmap.width - width) / 2
//        val offsetY = (bitmap.height - height) / 2
//        canvas.drawRect(x + offsetX, y + offsetY, x + offsetX + width, y + offsetY + height, debugPaint)
//    }
}
