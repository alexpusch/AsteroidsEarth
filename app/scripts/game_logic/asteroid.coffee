define ['entity'], (Entity) ->
  class Asteroid extends Entity
    constructor: (options) ->
      super 'asteroid'
      @radius = options.radius
      @planet = options.planet
      @density = options.density
      @forceWasApplied = false

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.position = new B2D.Vec2 0,0

      fixtureDef = new B2D.FixtureDef
      fixtureDef.density = @density
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.CircleShape @radius

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    update: ->
      force = @planet.getPosition().Copy()
      force.Subtract(@getPosition())
      distance = force.Length()
      force.Normalize()
      G = 0.003
      forceMagniture = G * @body.GetMass() * @body.GetMass()
      force?.Multiply(forceMagniture)
      @body.ApplyForce force, @body.GetWorldPoint(new B2D.Vec2(0,0))

    getRadius: ->
      @radius

    handleExitWorld: ->
      @destroy()

    getDensity: ->
      @body.GetFixtureList().GetDensity()