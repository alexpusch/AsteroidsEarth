define ['entity', 'astroid'], (Entity, Astroid) ->
  class Planet extends Entity
    constructor: (options) ->
      super 'planet'
      @radius = options.radius

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
        @events.trigger "worldDistruction", contactPoint