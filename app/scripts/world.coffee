define ['box2d'], (B2D) ->
  
  class World
    constructor: (options)->
      @world = new B2D.World(new B2D.Vec2(0, 0),  true)
      @size = options.size
      @entities = []
      @outWorldEntities = {}
      @inWorldEntities = {}

    registerEntity: (entity) ->
      fixtureDef =  entity.getEntityDef().fixtureDef
      bodyDef = entity.getEntityDef().bodyDef

      body = @world.CreateBody bodyDef
      body.CreateFixture fixtureDef

      entity.setBody body
      @entities.push entity

    getBodyCount: ->
      @world.GetBodyCount()

    getEntities: ->
      @entities

    update: ->
      _.each @entities, (e) =>
        unless e.exists
          @world.DestroyBody e.body
       
        @_callWorldCallbacks e      

        e.update?()

      @world.Step(@_getFrameTime(), 10, 10);
      @world.ClearForces();

    setupDebugRenderer: (canvas) ->
      debugDraw = new B2D.DebugDraw
      debugDraw.SetSprite(canvas.getContext("2d"))
      debugDraw.SetDrawScale(1.0);
      debugDraw.SetFillAlpha(0.5);
      debugDraw.SetLineThickness(1.0);
      debugDraw.SetFlags(B2D.DebugDraw.e_shapeBit | B2D.DebugDraw.e_jointBit);
      @world.SetDebugDraw(debugDraw);

    _getFrameTime: ->
      time = (new Date).getTime()
      frameTime = if @lastTime? 
        (time - @lastTime)/1000
      else
        1/60
      @lastTime = time

      frameTime
    
    _outOfWorld: (position) ->
      (position.x > @size.width) or (position.x < 0) or (position.y > @size.height) or (position.y < 0 )

    _callWorldCallbacks: (e) ->
      position = e.getPosition()
      if @_outOfWorld(position)
        unless @outWorldEntities[e]?
          @outWorldEntities[e] = e

        if @inWorldEntities[e]?
          delete @inWorldEntities[e]
          e.handleExitWorld()
      else 
        if @outWorldEntities[e]?
          delete @outWorldEntities[e]
          e.handleEnterWorld()

        unless @inWorldEntities[e]?
          @inWorldEntities[e] = e