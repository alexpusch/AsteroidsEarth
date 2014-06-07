define ['powerup', 'box2d', 'spaceship'], (Powerup, B2D, Spaceship) ->
  class SpeedPowerup extends Powerup
    constructor: ->
      super "speedPowerup"
      @amount = 10

      @options = 
        radius: 1

    apply: (spaceship) ->
      spaceship.addSpeed @amount

    getRadius: ->
      @options.radius

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.position = new B2D.Vec2 0,0
      
      fixtureDef = new B2D.FixtureDef
      fixtureDef.density = 10
      fixtureDef.friction = 0.5
      fixtureDef.shape = new B2D.CircleShape @options.radius
      bodyDef: bodyDef
      fixtureDef: fixtureDef