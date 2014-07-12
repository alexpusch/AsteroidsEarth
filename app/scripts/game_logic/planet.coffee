define ['entity', 'asteroid', 'box2d'], (Entity, Asteroid, B2D) ->
  class Planet extends Entity
    constructor: (options) ->
      super 'planet'
      @radius = options.radius
      @shieldRadius = @radius * 1.2
      @shieldActive = false

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_staticBody
      bodyDef.position = new B2D.Vec2 0,0

      fixtureDef = new B2D.FixtureDef
      fixtureDef.density = 1
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.CircleShape @radius

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    getRadius: ->
      @radius

    handleCollision: (collidingEnity, contactPoint) ->
      if collidingEnity instanceof Asteroid
        _.defer =>
          if @shieldActive
            @_luanchAsteroidAway collidingEnity
            @dropShield()
          else
            @events.trigger "worldDistruction", contactPoint

    deployShield: ->
      unless @shieldActive
        @shieldActive = true
        @_changePlanetBodyRadius @shieldRadius
        @events.trigger "rasingShield"

    dropShield: ->
      if @shieldActive
        @shieldActive = false
        @_changePlanetBodyRadius @radius
        @events.trigger "dropingShield"

    hasShield: ->
      @shieldActive

    getShieldRadius: ->
      @shieldRadius

    _luanchAsteroidAway: (asteroid) ->
      intensity = 300
      asteroidPosition = asteroid.getPosition()
      vectorToAsteroid = asteroidPosition.Copy()
      vectorToAsteroid.Add @getPosition()
      vectorToAsteroid.Multiply intensity

      asteroid.body.ApplyImpulse vectorToAsteroid, new B2D.Vec2(0,0)

    _changePlanetBodyRadius: (radius) ->
      fixture = @body.GetFixtureList()
      @body.DestroyFixture fixture
      newFixtureDef = @getEntityDef().fixtureDef
      newFixtureDef.shape.SetRadius radius
      newFixture = @body.CreateFixture newFixtureDef