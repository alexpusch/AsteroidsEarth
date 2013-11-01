window.createEntitySpy = ->
  bodyDef = new Box2D.Dynamics.b2BodyDef
  bodyDef.type = Box2D.Dynamics.b2Body.b2_staticBody

  fixtureDef = new Box2D.Dynamics.b2FixtureDef
  fixtureDef.shape = new Box2D.Collision.Shapes.b2PolygonShape
  fixtureDef.shape.SetAsBox(20, 2)

  entityDef = 
    fixtureDef: fixtureDef
    bodyDef: bodyDef

  entity = {}
  entity.getEntityDef = jasmine.createSpy().andReturn entityDef

  entity
