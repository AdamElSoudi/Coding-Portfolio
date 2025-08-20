package com.example.spaceshooter

import android.content.res.Resources
import android.graphics.Canvas
import android.graphics.Paint
import android.util.Log
import androidx.core.math.MathUtils.clamp

const val PLAYER_HEIGHT = 350
const val ACCELERATING = 1.1f
const val MIN_VEL = 0.1f
const val MAX_VEL = 15f
const val GRAVITY = 0.5f
const val LIFT = -(GRAVITY * 2)
const val DRAG = 0.97f
const val PLAYER_STARTING_HEALTH = 3
const val PLAYER_STARTING_POSITION = 10f

var isInvulnerable = false

private var lastShotTime = 0L
private const val SHOT_COOLDOWN = 500
private const val MAX_SHOTS = 3

private var invulnerabilityStartTime = 0L
private const val INVULNERABILITY_DURATION = 500

class Player(res: Resources, private val jukebox: Jukebox) : BitmapEntity() {
    private val TAG = "Player"
    private val playerResources: Resources = res
    var health = PLAYER_STARTING_HEALTH
    val projectiles = mutableListOf<Projectile>()

    init {
        setSprite(loadBitmap(playerResources, R.drawable.ship1, PLAYER_HEIGHT))
        respawn()
    }

    override fun respawn() {
        health = PLAYER_STARTING_HEALTH
        x = PLAYER_STARTING_POSITION
        y = 0f
    }

    override fun onCollision(that: Entity) {
        if (!isInvulnerable) {
            health--
            startInvulnerability()
        }
    }

    private fun startInvulnerability() {
        isInvulnerable = true
        invulnerabilityStartTime = System.currentTimeMillis()
    }

    private fun endInvulnerability() {
        isInvulnerable = false
    }

    fun shoot() {
        val currentTime = System.currentTimeMillis()
        if (currentTime - lastShotTime > SHOT_COOLDOWN && projectiles.size < MAX_SHOTS) {
            projectiles.add(Projectile(playerResources, x + width, y + height / 2 + 50))
            jukebox.play(SFX.projectile)

            lastShotTime = currentTime
        }
    }

    override fun update() {
        super.update()

        if (isInvulnerable && System.currentTimeMillis() - invulnerabilityStartTime > INVULNERABILITY_DURATION) {
            endInvulnerability()
        }

        velX *= DRAG
        velY += GRAVITY
        if (isBoosting) {
            velX *= ACCELERATING
            velY += LIFT
        }

        velX = clamp(velX, MIN_VEL, MAX_VEL)
        velY = clamp(velY, -MAX_VEL, MAX_VEL)

        y += velY
        playerSpeed = velX

        if (bottom() > STAGE_HEIGHT) {
            Log.d(TAG, "Player bottom: ${bottom()}, STAGE_HEIGHT: $STAGE_HEIGHT")
            setBottom(0f)
        } else if (top() < 0f) {
            setTop(0f)
            Log.d(TAG, "Adjusted player position at top boundary")
        }

        val iterator = projectiles.iterator()
        while (iterator.hasNext()) {
            val projectile = iterator.next()
            projectile.update()
            if (projectile.x > STAGE_WIDTH) {
                iterator.remove()
            }
        }
    }

    override fun render(canvas: Canvas, paint: Paint) {
        val playerPaint = Paint(paint)

        if (isInvulnerable) {
            if ((System.currentTimeMillis() - invulnerabilityStartTime) % 200 < 100) {
                playerPaint.colorFilter = android.graphics.PorterDuffColorFilter(android.graphics.Color.RED, android.graphics.PorterDuff.Mode.MULTIPLY)
            }
        }

        for (projectile in projectiles) {
            projectile.render(canvas, paint)
        }

        canvas.drawBitmap(bitmap, x, y, playerPaint)
    }
}