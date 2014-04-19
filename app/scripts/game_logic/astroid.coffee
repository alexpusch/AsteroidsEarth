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
      force = @planet.getPosition().Copy()
      force.Subtract(@getPosition())
      distance = force.Length()
      force.Normalize()
      G = 1000
      force.Multiply( G * ( @body.GetMass())/(distance*distance))

      @body.ApplyForce force, @body.GetWorldPoint(new B2D.Vec2(0,0))

    getRadius: ->
      @radius

    handleExitWorld: ->
      @destroy()