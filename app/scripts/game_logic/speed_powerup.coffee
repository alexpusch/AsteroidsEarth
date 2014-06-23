define ['powerup', 'box2d'], (Powerup, B2D) ->
  class SpeedPowerup extends Powerup
    constructor: ->
      super "speedPowerup"
      @amount = 10

    apply: (spaceship) ->
      spaceship.addSpeed @amount

