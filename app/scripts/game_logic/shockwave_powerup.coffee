define ['powerup', 'box2d', 'spaceship', 'asteroid', 'bullet'], (Powerup, B2D, Spaceship, Asteroid, Bullet) ->
  class ShockwavePowerup extends Powerup
    constructor: (@world) ->
      super "shockwavePowerup"

    apply: ->
      @world.startShockWave @getPosition(), [Spaceship, Asteroid, Bullet]

