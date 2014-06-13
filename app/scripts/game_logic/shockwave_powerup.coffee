define ['powerup', 'box2d'], (Powerup, B2D) ->
  class ShockwavePowerup extends Powerup
    constructor: (@world) ->
      super "shockwavePowerup"

    apply: ->
      @world.startShockWave @getPosition()

