define ['box2d'], (B2D) ->
  
  class World
    constructor: ->
      @world = new B2D.World(new B2D.Vec2(0, 0),  true)
      @entities = []

    registerEntity: (entity) ->
      fixtureDef =  entity.getEntityDef().fixtureDef
      bodyDef = entity.getEntityDef().bodyDef

      body = @world.CreateBody bodyDef
      body.CreateFixture fixtureDef

      entity.setBody body
      @entities.push entity

    getBodyCount: ->
      @world.GetBodyCount()

    update: ->
      # console.log "update"
      _.each @entities, (e)->
        e.update()

      @world.Step(1 / 60, 10, 10);
      @world.DrawDebugData();
      @world.ClearForces();

    setupDebugRenderer: (canvas) ->
      debugDraw = new B2D.DebugDraw
      debugDraw.SetSprite(canvas.getContext("2d"))
      debugDraw.SetDrawScale(1.0);
      debugDraw.SetFillAlpha(0.5);
      debugDraw.SetLineThickness(1.0);
      debugDraw.SetFlags(B2D.DebugDraw.e_shapeBit | B2D.DebugDraw.e_jointBit);
      @world.SetDebugDraw(debugDraw);