define ['powerup', 'box2d', 'spaceship'], (Powerup, B2D, Spaceship) ->
  class SpeedPowerup extends Powerup
    constructor: ->
      super "speedPowerup"
      @amount = 10

    apply: (spaceship) ->
      spaceship.addSpeed @amount

