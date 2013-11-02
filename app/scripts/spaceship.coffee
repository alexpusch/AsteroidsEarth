define ['box2d', 'vector_helpers'], (B2D, VectorHelpers) ->
  
  class Spaceship
    constructor: (options) ->
      @speed = options.speed
      @angularSpeed = options.angularSpeed
      @thrusters =
        main: 'off'
        left: 'off'
        right: 'off'

    setBody: (body) ->
      @body = body

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody

      fixtureDef = new B2D.FixtureDef
      fixtureDef.shape = new B2D.PolygonShape
      fixtureDef.shape.SetAsBox(1, 1)
      fixtureDef.mass = 1
      fixtureDef.density = 1

      bodyDef: bodyDef
      fixtureDef: fixtureDef

    fireMainThrusters: ->
      @thrusters.main = 'on'

    fireLeftThrusters: ->
      @thrusters.left = 'on'

    fireRightThrusters: ->
      @thrusters.right = 'on'

    turnMainThrustersOff: ->
      @thrusters.main = 'off'

    turnLeftThrustersOff: ->
      @thrusters.left = 'off'

    turnRightThrustersOff: ->
      @thrusters.right = 'off'

    update: ->
      if @_thrustersOn 'main'
        @_mainThrustersAction()
      else if @_thrustersOn 'left'
        @_leftThrustersAction()
      else if @_thrustersOn 'right'
        @_rightThrustersACtion()

    _thrustersOn: (type)->
      @thrusters[type] == 'on'

    _mainThrustersAction: ->
      angle = @body.GetAngle()
      direction = VectorHelpers.createDirectionVector angle
      direction.Multiply(@speed)
      @body.ApplyForce(direction, @body.GetWorldPoint(new B2D.Vec2(0,0)))

    _leftThrustersAction: ->
      @body.ApplyTorque -@angularSpeed

    _rightThrustersACtion: ->
      @body.ApplyTorque @angularSpeed