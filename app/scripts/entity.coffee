define ['box2d', 'events'], (B2D, Events)->
  class Entity
    constructor: (@type)->
      @id = "#{@type}_#{Math.random()}"
      @_exists = true
      @events = new Events()

    setBody: (body) ->
      @body = body

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.position = new B2D.Vec2 30,30
      bodyDef.angularDamping = 5
      fixtureDef = new B2D.FixtureDef
      fixtureDef.mass = 1
      fixtureDef.density = 1
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.PolygonShape
      fixtureDef.shape.SetAsBox(1, 1)

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    getPosition: ->
      @body.GetPosition()

    setPosition: (position)->
      @body.SetPosition position

    setSpeed: (speed)->
      @body.SetLinearVelocity speed

    getSpeed: ->
      @body.GetLinearVelocity()

    getAngle: ->
      @body.GetAngle()

    setAngle: (angle) ->
      @body.SetAngle angle

    toString: ->
      @id

    destroy: ->
      @_exists = false
      @events.trigger 'destroy', this

    exists: ->
      @_exists
      
    on: (eventName, callback)->
      @events.on eventName, callback

    handleEnterWorld: ->

    handleExitWorld: ->