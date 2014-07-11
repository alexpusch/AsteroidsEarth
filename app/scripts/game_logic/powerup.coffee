define ['entity', 'spaceship', 'bullet', 'astroid', 'planet', 'vector_helpers'], (Entity, Spaceship, Bullet, Astroid, Planet, VectorHelpers) ->
  class Powerup extends Entity
    constructor: (powerupType) ->
      super powerupType
      @applied = false

      @options =
        radius: 1

    handleCollision: (entity, contactPoint) ->
      unless @applied
        if entity instanceof Spaceship
          @apply entity, contactPoint
          @events.trigger "applied"
          @destroy()

    shouldPassThrough: (entity) ->
      entity instanceof Spaceship or
      entity instanceof Bullet or
      entity instanceof Astroid or
      entity instanceof Planet

    handleExitWorld: ->
      @destroy()

    goToDirection: (direction) ->
      force = VectorHelpers.createDirectionVector direction
      force.Multiply 70

      @body.ApplyImpulse force, new B2D.Vec2(0,0)

    getRadius: ->
      @options.radius

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.position = new B2D.Vec2 0,0

      fixtureDef = new B2D.FixtureDef
      fixtureDef.density = 10
      fixtureDef.friction = 0.5
      bodyDef.linearDamping = 0.1
      fixtureDef.shape = new B2D.CircleShape @options.radius
      bodyDef: bodyDef
      fixtureDef: fixtureDef