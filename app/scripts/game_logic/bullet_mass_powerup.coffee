define ['powerup', 'box2d', 'spaceship'], (Powerup, B2D, Spaceship) ->
  class BulletMassPowerup extends Powerup
    constructor: ->
      super "bulletMassPowerup"
      @amount = 3

    apply: (spaceship) ->
      spaceship.addBulletDensity @amount

