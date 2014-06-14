define ['entity', 'astroid', 'box2d'], (Entity, Astroid, B2D) ->
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
      if collidingEnity instanceof Astroid
        _.defer =>
          if @shieldActive
            @_luanchAstroidAway collidingEnity
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

    _luanchAstroidAway: (astroid) ->
      intensity = 300
      astroidPosition = astroid.getPosition()
      vectorToAstroid = astroidPosition.Copy()
      vectorToAstroid.Add @getPosition()
      vectorToAstroid.Multiply intensity

      astroid.body.ApplyImpulse vectorToAstroid, new B2D.Vec2(0,0)

    _changePlanetBodyRadius: (radius) ->
      fixture = @body.GetFixtureList()
      @body.DestroyFixture fixture
      newFixtureDef = @getEntityDef().fixtureDef
      newFixtureDef.shape.SetRadius radius
      newFixture = @body.CreateFixture newFixtureDef