define ['powerup', 'box2d', 'spaceship', 'astroid', 'bullet'], (Powerup, B2D, Spaceship, Astroid, Bullet) ->
  class ShockwavePowerup extends Powerup
    constructor: (@world) ->
      super "shockwavePowerup"

    apply: ->
      @world.startShockWave @getPosition(), [Spaceship, Astroid, Bullet]

