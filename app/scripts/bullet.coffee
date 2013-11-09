define ['entity'], (Entity) ->
  class Bullet extends Entity
    constructor: ->
      super 'bullet'
      @radius = 0.5

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.position = new B2D.Vec2 0,0
      bodyDef.angularDamping = 1
      bodyDef.bullet = true
      fixtureDef = new B2D.FixtureDef
      fixtureDef.mass = 0.2
      fixtureDef.density = 1
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.CircleShape @radius


      # fixtureDef.shape.SetAsBox(1, 1)
      bodyDef: bodyDef
      fixtureDef: fixtureDef

    getRadius: ->
      @radius