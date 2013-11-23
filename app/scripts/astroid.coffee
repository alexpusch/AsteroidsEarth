define ['entity'], (Entity) ->
  class Astroid extends Entity
    constructor: (options) ->
      super 'astroid'
      @radius = options.radius
      @planet = options.planet
      @forceWasApplied = false

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.position = new B2D.Vec2 0,0
      bodyDef.bullet = true
      
      fixtureDef = new B2D.FixtureDef
      fixtureDef.density = 0.3
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.CircleShape @radius

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    update: ->
      unless @forceWasApplied
        force = @planet.getPosition().Copy()
        force.Subtract(@getPosition())
        force.Normalize()
        force.Multiply(1000)

        @body.ApplyForce force, @body.GetWorldPoint(new B2D.Vec2(0,0))
        @forceWasApplied = true

    getRadius: ->
      @radius

    handleExitWorld: ->
      @destroy()