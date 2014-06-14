define ['powerup', 'box2d'], (Powerup, B2D) ->
  class ShieldPowerup extends Powerup
    constructor: (@planet) ->
      super "shieldPowerup"
      @amount = 10

    apply: ->
      _.defer =>
        @planet.deployShield()

