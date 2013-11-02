define ['box2d', 'vector_helpers'], (B2D, VectorHelpers) ->
  
  class Spaceship
    constructor: (options) ->
      @speed = options.speed
      @angularSpeed = options.angularSpeed

    setBody: (body) ->
      @body = body

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody

      fixtureDef = new B2D.FixtureDef
      fixtureDef.shape = new B2D.PolygonShape
      fixtureDef.shape.SetAsBox(1, 1)
      fixtureDef.mass = 1
      fixtureDef.density = 1

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    fireMainThrusters: ->
      angle = @body.GetAngle()
      direction = VectorHelpers.createDirectionVector angle
      direction.Multiply(@speed)
      @body.ApplyForce(direction, @body.GetWorldPoint(new B2D.Vec2(0,0)))

    fireLeftThrusters: ->
      @body.ApplyTorque -@angularSpeed

    fireRightThrusters: ->
      @body.ApplyTorque @angularSpeed