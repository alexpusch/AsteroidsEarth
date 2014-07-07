define ['powerup', 'box2d'], (Powerup, B2D) ->
  class SpeedPowerup extends Powerup
    constructor: ->
      super "speedPowerup"
      @amount = 5

    apply: (spaceship) ->
      spaceship.addSpeed @amount

