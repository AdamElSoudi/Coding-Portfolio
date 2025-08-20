package com.example.spaceshooter

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.os.SystemClock.uptimeMillis
import android.util.Log
import android.view.MotionEvent
import android.view.SurfaceHolder
import android.view.SurfaceView
import kotlin.random.Random

const val STAGE_WIDTH = 1080
const val STAGE_HEIGHT = 720
const val STAR_COUNT = 100
const val ENEMY_COUNT = 10

val RNG = Random(uptimeMillis())
@Volatile var isBoosting = false
var playerSpeed = 0f

private const val TAG = "Game"
const val PREFS = "com.example.spaceshooter"
const val LONGEST_DIST = "longest_distance"

class Game(context: Context) : SurfaceView(context), Runnable, SurfaceHolder.Callback {
    private val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
    //private val editor = prefs.edit()
    private lateinit var gameThread: Thread

    @Volatile
    private var isRunning = false
    private var isGameOver = false
    private val jukebox = Jukebox(context.assets)
    private val player = Player(resources, jukebox)
    private val enemyBoss = EnemyBoss(resources)
    private var entities = ArrayList<Entity>()
    private val paint = Paint()
    private var distanceTraveled = 0
    private var maxDistanceTraveled = prefs.getInt(LONGEST_DIST, 0)

    init {
//        editor.remove(LONGEST_DIST)
//        editor.apply()

        holder.addCallback(this)
        holder.setFixedSize(STAGE_WIDTH, STAGE_HEIGHT)

        for (i in 0 until STAR_COUNT) {
            entities.add(Star())
        }
        for (i in 0 until ENEMY_COUNT) {
            entities.add(Enemy(resources))
        }
    }

    private fun restart() {
        for (entity in entities) {
            entity.respawn()
        }
        player.respawn()
        distanceTraveled = 0
        isGameOver = false
    }

    override fun run() {
        while (isRunning) {
            if (!isGameOver) {
                update()
                render()
            }
        }
    }

    private fun update() {
        player.update()
        enemyBoss.update()

        for (entity in entities) {
            entity.update()
        }

        for (laser in enemyBoss.getLasers()) {
            if (isColliding(laser, player)) {
                Log.d(TAG, "Laser collided with player!")
                laser.onCollision(player)
                player.onCollision(laser)
                jukebox.play(SFX.laser)
                enemyBoss.removeLaser(laser)
                break
            }
        }

        distanceTraveled += playerSpeed.toInt()
        checkCollisions()
        checkGameOver()
    }

    private fun checkGameOver() {
        if (player.health <= 0 && !isGameOver) {
            Log.d(TAG, "Game Over")
            isGameOver = true
            if (distanceTraveled > maxDistanceTraveled) {
                val highScoreManager = HighScoreManager(context)
                highScoreManager.saveScore(distanceTraveled)
                maxDistanceTraveled = distanceTraveled
            }
        }
    }

    private fun checkCollisions() {
        for (i in STAR_COUNT until entities.size) {
            val enemy = entities[i]
            if (isColliding(enemy, player)) {
                Log.d(TAG, "Player hit enemy")
                Log.d(TAG, "Player Position: (${player.x}, ${player.y}), Width: ${player.width}, Height: ${player.height}")
                Log.d(TAG, "Enemy Position: (${enemy.x}, ${enemy.y}), Width: ${enemy.width}, Height: ${enemy.height}")
                enemy.onCollision(player)
                player.onCollision(enemy)
                jukebox.play(SFX.crash)
            }
        }

        val projectilesToRemove = mutableListOf<Entity>()
        val enemiesToRemove = mutableListOf<Entity>()

        val playerProjectiles = player.projectiles
        for (projectile in playerProjectiles) {
            for (i in STAR_COUNT until entities.size) {
                val enemy = entities[i]
                if (isColliding(projectile, enemy)) {
                    jukebox.play(SFX.enemy_hit)
                    Log.d(TAG, "Enemy hit by projectile")
                    projectilesToRemove.add(projectile)
                    enemiesToRemove.add(enemy)
                    break
                }
            }
        }
        playerProjectiles.removeAll(projectilesToRemove.toSet())
        entities.removeAll(enemiesToRemove.toSet())
    }


    private fun render() {
        val canvas = acquireAndLockCanvas() ?: return
        val midnightBlue = Color.rgb(0, 0, 80)

        canvas.drawColor(midnightBlue)

        for (entity in entities) {
            entity.render(canvas, paint)
        }

        player.render(canvas, paint)
        enemyBoss.render(canvas, paint)

        renderHud(canvas, paint)
        holder.unlockCanvasAndPost(canvas)
    }

    private fun renderHud(canvas: Canvas, paint: Paint) {
        val textSize = 48f
        val margin = 10f

        paint.color = Color.WHITE
        paint.textAlign = Paint.Align.LEFT
        paint.textSize = textSize

        if (!isGameOver) {
            canvas.drawText(context.getString(R.string.health, player.health), margin, textSize, paint)
            canvas.drawText(context.getString(R.string.distance, distanceTraveled), margin, textSize * 2, paint)
        } else {
            paint.textAlign = Paint.Align.CENTER
            val centerX = STAGE_WIDTH * 0.5f
            val centerY = STAGE_HEIGHT * 0.5f

            // Black rectangle behind game over text
            val rectHeight = textSize * 7 + 40
            val rectWidth = STAGE_WIDTH * 0.5f
            val rectLeft = (STAGE_WIDTH - rectWidth) / 2
            val rectRight = rectLeft + rectWidth
            val rectTop = centerY - rectHeight / 2
            val rectBottom = centerY + rectHeight / 2
            paint.color = Color.BLACK
            canvas.drawRect(rectLeft, rectTop, rectRight, rectBottom +35, paint)

            // Text inside the rectangle
            paint.color = Color.WHITE
            val textVerticalOffset = textSize * 1.2f
            val gapSize = textSize * 2
            canvas.drawText(context.getString(R.string.game_over), centerX, centerY - textVerticalOffset, paint)
            canvas.drawText(context.getString(R.string.score, distanceTraveled), centerX, centerY, paint)
            canvas.drawText(context.getString(R.string.press_to_restart), centerX, centerY + textVerticalOffset + gapSize, paint)
        }
    }

    private fun acquireAndLockCanvas(): Canvas? {
        if (holder?.surface?.isValid == false) {
            return null
        }
        return holder.lockCanvas()
    }

    fun pause() {
        isRunning = false
        try {
            gameThread.join()
        } catch (e: Exception) {
            Log.e(TAG, "Error joining game thread", e)
        }
    }

    fun resume() {
        Log.d(TAG, "Resume")
        isRunning = true
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onTouchEvent(event: MotionEvent): Boolean {
        when (event.action and MotionEvent.ACTION_MASK) {
            MotionEvent.ACTION_UP -> {
                Log.d(TAG, "isSlowing")
                jukebox.play(SFX.slowing_boost)
                isBoosting = false
            }
            MotionEvent.ACTION_DOWN -> {
                jukebox.play(SFX.boosting)
                Log.d(TAG, "isBoosting")
                if (isGameOver) {
                    restart()
                } else {
                    isBoosting = true
                }
            }
        }
        return true
    }

    fun shootLaser() {
        player.shoot()
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        Log.d(TAG, "Surface Created")
        gameThread = Thread(this)
        gameThread.start()
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
        Log.d(TAG, "Surface Changed, width: $width, height: $height")
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
        Log.d(TAG, "Surface Destroyed")
    }
}
