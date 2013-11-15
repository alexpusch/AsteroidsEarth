define ['entity'], (Entity) ->
  class Bullet extends Entity
    constructor: (options) ->
      super 'bullet'
      @radius = options.radius

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.position = new B2D.Vec2 0,0
      bodyDef.bullet = true
      
      fixtureDef = new B2D.FixtureDef
      fixtureDef.density = 1
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.CircleShape @radius

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    getRadius: ->
      @radius