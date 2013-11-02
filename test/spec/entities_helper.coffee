window.createEntitySpy = ->
  bodyDef = new B2D.BodyDef
  bodyDef.type = B2D.Body.b2_staticBody

  fixtureDef = new B2D.FixtureDef
  fixtureDef.shape = new B2D.PolygonShape
  fixtureDef.shape.SetAsBox(20, 2)

  entityDef = 
    fixtureDef: fixtureDef
    bodyDef: bodyDef

  entity = {}
  entity.getEntityDef = jasmine.createSpy().andReturn entityDef

  entity
