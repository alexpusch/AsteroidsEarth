define ['box2d', 'events', 'astroid', 'planet', 'spaceship', 'powerup'], (B2D, Events, Astroid, Planet, Spaceship, Powerup) ->

  class WorldContactListener
    constructor: (@worldBody) ->
      @events = new Events()

    BeginContact: (contact)->
      bodyA = contact.GetFixtureA().GetBody()
      bodyB = contact.GetFixtureB().GetBody()

      if( otherBody = @_findWorldBody(bodyA, bodyB))
        @events.trigger "entityEnter", otherBody.GetUserData()
      else
        @_handleEntitiesCollision bodyA, bodyB, contact

    EndContact: (contact) ->
      bodyA = contact.GetFixtureA().GetBody()
      bodyB = contact.GetFixtureB().GetBody()

      if( otherBody = @_findWorldBody(bodyA, bodyB))
        @events.trigger "entityExit", otherBody.GetUserData()

    PreSolve: (contact) ->
      entityA = contact.GetFixtureA().GetBody().GetUserData()
      entityB = contact.GetFixtureB().GetBody().GetUserData()

      if (entityA.shouldPassThrough? entityB) or (entityB.shouldPassThrough? entityA)
        contact.SetEnabled false

    PostSolve: ->
    _findWorldBody: (bodyA, bodyB) ->
      otherBody = null

      if( bodyA == @worldBody ||  bodyB == @worldBody)
        if bodyA == @worldBody
          otherBody = bodyB
        else
          otherBody = bodyA

      otherBody

    _handleEntitiesCollision: (bodyA, bodyB, contact) ->
      entityA = bodyA.GetUserData()
      entityB = bodyB.GetUserData()

      worldManifold = new B2D.WorldManifold()
      manifold = contact.GetWorldManifold worldManifold
      contactPoint = worldManifold.m_points[0]

      @events.trigger "collision", entityA, entityB, contactPoint

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

      worldContactListener.events.on "collision", (entityA, entityB, contactPoint) =>
        entityA.handleCollision? entityB, contactPoint
        entityB.handleCollision? entityA, contactPoint

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

    startShockWave: (position, affectedTypes) ->
      @shockWavePosition = position
      shokwaveMagnitude = 600

      if affectedTypes?
        affectedEnteties = _(@entities).filter (entity) ->
          _(affectedTypes).any (type) ->
            entity instanceof type
      else
        affectedEnteties = @entities

      for entity in affectedEnteties
        entityPosition = entity.getPosition()
        forceVector = entityPosition.Copy()
        forceVector.Add position.GetNegative()
        forceVector.Normalize()
        forceVector.Multiply shokwaveMagnitude

        entity.body.ApplyImpulse forceVector, new B2D.Vec2(0,0)

    update: (dt) ->
      _.each @entities, (e) =>
        if not e.exists()
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