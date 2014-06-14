define ['entity', 'astroid', 'box2d'], (Entity, Astroid, B2D) ->
  class Planet extends Entity
    constructor: (options) ->
      super 'planet'
      @radius = options.radius
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
        if @shieldActive
          @_luanchAstroidAwaw collidingEnity
          @dropShield()
        else
          @events.trigger "worldDistruction", contactPoint

    deployShield: ->
      @shieldActive = true
      @events.trigger "rasingShield"

    dropShield: ->
      @shieldActive = false
      @events.trigger "dropingShield"
          
    hasShield: ->
      @shieldActive

    _luanchAstroidAwaw: (astroid) ->
      intensity = 500
      astroidPosition = astroid.getPosition()
      vectorToAstroid = astroidPosition.Copy()
      vectorToAstroid.Add @getPosition()
      vectorToAstroid.Multiply intensity

      astroid.body.ApplyImpulse vectorToAstroid, new B2D.Vec2(0,0)