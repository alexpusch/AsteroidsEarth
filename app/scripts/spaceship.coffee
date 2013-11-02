define ['box2d', 'vector_helpers'], (B2D, VectorHelpers) ->
  
  class Spaceship
    constructor: ->
      @thrusters = 
        main: false
        left: false
        right: false

    setBody: (body) ->
      @body = body

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody

      fixtureDef = new B2D.FixtureDef
      fixtureDef.shape = new B2D.PolygonShape
      fixtureDef.shape.SetAsBox(20, 2)

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    fireMainThrusters: ->
      angle = @body.GetAngle()
      direction = VectorHelpers.createDirectionVector angle
      @body.ApplyForce(new B2D.Vec2(10,0), new B2D.Vec2(0,0))