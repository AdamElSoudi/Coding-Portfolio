package com.example.spaceshooter

import android.content.res.Resources
//import android.graphics.Canvas
//import android.graphics.Color
//import android.graphics.Paint

const val PROJECTILE_HEIGHT = 75
const val PROJECTILE_SPEED = 10f

class Projectile(res: Resources, startX: Float, startY: Float) : BitmapEntity() {

    init {
        setSprite(loadBitmap(res, R.drawable.laser_blue, PROJECTILE_HEIGHT))
        x = startX
        y = startY
    }

    override fun update() {
        x += PROJECTILE_SPEED
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
