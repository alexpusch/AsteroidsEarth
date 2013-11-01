class window.World
  constructor: ->
    @world = new Box2D.Dynamics.b2World(new Box2D.Common.Math.b2Vec2(0, 0),  true)

  registerEntity: (entity) ->
    fixtureDef =  entity.getEntityDef().fixtureDef
    bodyDef = entity.getEntityDef().bodyDef

    body = @world.CreateBody bodyDef
    body.CreateFixture fixtureDef

    entity.setBody body

  getBodyCount: ->
    @world.GetBodyCount()

  update: ->
    console.log "update"
    @world.Step(1 / 60, 10, 10);
    @world.DrawDebugData();
    @world.ClearForces();

  setupDebugRenderer: (canvas) ->
    debugDraw = new Box2D.Dynamics.b2DebugDraw
    debugDraw.SetSprite(canvas.getContext("2d"))
    debugDraw.SetDrawScale(30.0);
    debugDraw.SetFillAlpha(0.5);
    debugDraw.SetLineThickness(1.0);
    debugDraw.SetFlags(Box2D.Dynamics.b2DebugDraw.e_shapeBit | Box2D.Dynamics.b2DebugDraw.e_jointBit);
    @world.SetDebugDraw(debugDraw);