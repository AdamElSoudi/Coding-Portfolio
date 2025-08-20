package com.example.spaceshooter

import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path

private const val MAX_STAR_RADIUS_DIFF = 6
private const val MIN_STAR_RADIUS = 2

class Star : Entity() {
    private val TAG = "Star"
    private val colors = arrayOf(Color.YELLOW, Color.WHITE, Color.CYAN, Color.LTGRAY)
    private val color = colors[RNG.nextInt(colors.size)]
    private val radius = (RNG.nextInt(MAX_STAR_RADIUS_DIFF) + MIN_STAR_RADIUS).toFloat()
    private val speedFactor = 1 + (radius - MIN_STAR_RADIUS) / (MAX_STAR_RADIUS_DIFF)
    private val shapes = arrayOf("circle", "diamond")
    private val shape = shapes[RNG.nextInt(shapes.size)]

    init {
        respawn()
    }

    override fun respawn() {
        x = RNG.nextInt(STAGE_WIDTH).toFloat()
        y = RNG.nextInt(STAGE_HEIGHT).toFloat()
        width = radius * 2f
        height = width
    }

    override fun update() {
        super.update()
        x -= playerSpeed * speedFactor
        if (right() < 0) {
            setLeft(STAGE_WIDTH.toFloat())
            setTop(RNG.nextInt(STAGE_HEIGHT - height.toInt()).toFloat())
        }

        if (top() > STAGE_HEIGHT)
            setBottom(0f)
    }

    override fun render(canvas: Canvas, paint: Paint) {
        super.render(canvas, paint)
        paint.color = color

        when (shape) {
            "circle" -> canvas.drawCircle(x, y, radius, paint)
            "diamond" -> canvas.drawPath(diamondPath(x, y, radius), paint)
        }
    }

    private fun diamondPath(cx: Float, cy: Float, size: Float): Path {
        val path = Path()
        path.moveTo(cx, cy - size)
        path.lineTo(cx + size, cy)
        path.lineTo(cx, cy + size)
        path.lineTo(cx - size, cy)
        path.close()
        return path
    }
}
