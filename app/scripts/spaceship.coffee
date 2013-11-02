define ['box2d'], (box2d) ->


  
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
      bodyDef.type = B2D.Dynamics.b2Body.b2_staticBody

      fixtureDef = new B2D.FixtureDef
      fixtureDef.shape = new B2D.PolygonShape
      fixtureDef.shape.SetAsBox(20, 2)

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    fireMainThrusters: ->
      angle = @body.GetAngle()
      direction = VectorHelpers.createDirectionVector angle
      @body.applyForce(new B2D.Vec2(1,0), new B2D.Vec2(0,0))



  window.Spaceship = Spaceship