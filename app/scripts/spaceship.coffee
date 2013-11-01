class Spaceship
  constructor: ->
    @thrusters = 
      main: false
      left: false
      right: false

  setBody: (body) ->
    @body = body

  getEntityDef: ->
    bodyDef = new Box2D.Dynamics.b2BodyDef
    bodyDef.type = Box2D.Dynamics.b2Body.b2_staticBody

    fixtureDef = new Box2D.Dynamics.b2FixtureDef
    fixtureDef.shape = new Box2D.Collision.Shapes.b2PolygonShape
    fixtureDef.shape.SetAsBox(20, 2)

    bodyDef: bodyDef
    fixtureDef: fixtureDef

  fireMainThrusters: ->
    angle = @body.GetAngle()
    direction = VectorHelpers.createDirectionVector angle
    @body.applyForce(new Box2D.Common.Math.b2Vec2(1,0), new Box2D.Common.Math.b2Vec2(0,0))



window.Spaceship = Spaceship