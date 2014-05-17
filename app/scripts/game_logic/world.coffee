define ['box2d', 'events'], (B2D, Events) ->
  
  class WorldContactListener
    constructor: (@worldBody) ->
      @events = new Events()

    BeginContact: (contact)->
      bodyA = contact.GetFixtureA().GetBody()
      bodyB = contact.GetFixtureB().GetBody()

      if( otherBody = @_findWorldBody(bodyA, bodyB))
        @events.trigger "entityEnter", otherBody.GetUserData()
      else
        @_handleEntitiesCollision bodyA, bodyB

    EndContact: (contact) ->
      bodyA = contact.GetFixtureA().GetBody()
      bodyB = contact.GetFixtureB().GetBody()

      if( otherBody = @_findWorldBody(bodyA, bodyB))
        @events.trigger "entityExit", otherBody.GetUserData()

    PreSolve: ->
      # console.log "presolve"

    PostSolve: ->
      # console.log "PostSolve"

    _findWorldBody: (bodyA, bodyB) ->
      otherBody = null

      if( bodyA == @worldBody ||  bodyB == @worldBody)
        if bodyA == @worldBody
          otherBody = bodyB
        else
          otherBody = bodyA

      otherBody

    _handleEntitiesCollision: (bodyA, bodyB) ->
      entityA = bodyA.GetUserData()
      entityB = bodyB.GetUserData()

      if (entityA.type == "planet" and entityB.type == "astroid") or
         (entityA.type == "astroid" and entityB.type == "planet")

        @events.trigger "astroidWorldCollistion"

  class World
    constructor: (options)->
      @world = new B2D.World(new B2D.Vec2(0, 0),  true)
      @size = options.size
      @entities = []
      @outWorldEntities = {}
      @inWorldEntities = {}
      @events = new Events()

      @worldBody = @_createWorldBody()

      worldContactListener = new WorldContactListener @worldBody

      worldContactListener.events.on "astroidWorldCollistion", =>
        @events.trigger "astroidWorldCollistion"
      worldContactListener.events.on "entityEnter", (entity) ->
        entity.handleEnterWorld()
      worldContactListener.events.on "entityExit", (entity) ->
        entity.handleExitWorld()

      @world.SetContactListener worldContactListener

    registerEntity: (entity) ->
      fixtureDef =  entity.getEntityDef().fixtureDef
      bodyDef = entity.getEntityDef().bodyDef

      body = @world.CreateBody bodyDef
      body.CreateFixture fixtureDef
      body.SetUserData(entity)

      entity.setBody body

      @entities.push entity

    getBodyCount: ->
      @world.GetBodyCount()

    getEntities: ->
      @entities

    update: ->
      dt = @_getFrameTime()
      _.each @entities, (e) =>
        unless e.exists()
          @world.DestroyBody e.body
          @entities = _(@entities).without e
       
        e.update? dt

      @world.Step(dt, 10, 10);
      @world.ClearForces();

    hitCheck: (type, point) ->
      body = @world.GetBodyList()
      while body?
        if body.GetUserData()?.type == type
          fixture = body.GetFixtureList()
          while fixture?
            if fixture.TestPoint point
              return true
            fixture = fixture.GetNext()

        body = body.GetNext()

      false

    destroy: ->
      body = @world.GetBodyList()
      while body
        @world.DestroyBody body
        body = body.GetNext()

    setupDebugRenderer: (canvas) ->
      debugDraw = new B2D.DebugDraw
      debugDraw.SetSprite(canvas.getContext("2d"))
      debugDraw.SetDrawScale(1.0);
      debugDraw.SetFillAlpha(0.5);
      debugDraw.SetLineThickness(1.0);
      debugDraw.SetFlags(B2D.DebugDraw.e_shapeBit | B2D.DebugDraw.e_jointBit);
      @world.SetDebugDraw(debugDraw);

    _createWorldBody: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_staticBody
      bodyDef.position = new B2D.Vec2 0, 0
      fixtureDef = new B2D.FixtureDef
      fixtureDef.mass = 1
      fixtureDef.density = 1
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.PolygonShape
      fixtureDef.shape.SetAsBox(@size.width/2, @size.height/2)
      fixtureDef.isSensor = true     
      worldBody = @world.CreateBody bodyDef
      worldBody.CreateFixture fixtureDef

      worldBody

    _getFrameTime: ->
      time = (new Date).getTime()
      frameTime = if @lastTime? 
        (time - @lastTime)/1000
      else
        1/60
      @lastTime = time

      frameTime