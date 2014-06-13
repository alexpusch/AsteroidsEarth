define ['box2d', 'entity', 'vector_helpers', 'math_helpers', 'cannon'], (B2D, Entity, VectorHelpers, MathHelpers, Cannon) ->
  
  class Spaceship extends Entity
    constructor: (options) ->
      super 'spaceship'
      @speed = options.speed
      @angularSpeed = options.angularSpeed
      @length = options.length
      @width = options.width

      @cannon = new Cannon
        bulletSpeed: 30
        cannonOffset: new B2D.Vec2(@length)
        cannonRate: 200    
        cannonHeatRate: options.cannonHeatRate
        cannonCooldownRate: options.cannonCooldownRate

      @angularDamping = options.angularDamping

      @linearDamping = options.linearDamping

      @thrusters =
        main: 'off'
        left: 'off'
        right: 'off'

      @outOfWorld = false;

    getEntityDef: ->
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_dynamicBody
      bodyDef.angularDamping = @angularDamping
      bodyDef.linearDamping = @linearDamping
      fixtureDef = new B2D.FixtureDef
      fixtureDef.mass = 1
      fixtureDef.density = 1
      fixtureDef.friction = 0
      fixtureDef.shape = new B2D.PolygonShape
      fixtureDef.shape.SetAsArray [ 
          new B2D.Vec2(-@length/2, -@width/2),
          new B2D.Vec2(@length/2, 0),
          new B2D.Vec2(-@length/2, @width/2)], 3

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

    setAutoPilotTarget: (point) ->
      @autoPilotTarget = point

    stopAutoPilot: ->
      @turnLeftThrustersOff()
      @turnRightThrustersOff()
      @turnMainThrustersOff()

      delete @autoPilotTarget

    fireCannon: ->
      @cannon.fireCannon()

    turnCannonOff: ->
      @cannon.turnCannonOff()

    update: (dt) ->
      if @autoPilotTarget?
        @_autoPilot()

      if @_thrustersOn 'main'
        @_mainThrustersAction()
      if @_thrustersOn 'left'
        @_leftThrustersAction()
      if @_thrustersOn 'right'
        @_rightThrustersACtion()

      @cannon.setPosition @getPosition()
      @cannon.setAngle @getAngle()
      @cannon.setSpeed @body.GetLinearVelocity()
      @cannon.update dt

    getVertices: ->
      @body.GetFixtureList().GetShape().GetVertices()

    isCannonOn: ->
      @cannon.isCannonOn()

    isCannonJammed: ->
      @cannon.isCannonJammed()

    getCannonTemperature: ->
      @cannon.getCannonTemperature()

    destroy: ->
      @cannon.destroy()
    
    handleExitWorld: ->
      @outOfWorld = true

    handleEnterWorld: ->
      @outOfWorld = false

    isOutOfWOrld: ->
      @outOfWorld

    getSpeed: ->
      speedVector = @body.GetLinearVelocity()
      speedVector.Length()

    setSuperCannon: ->
      @cannon.canJam = false

    isSuperCannon: ->
      not @cannon.canJam

    addSpeed: (amount) ->
      @speed += amount

    addBulletDensity: (amount) ->
      @cannon.addBulletDensity amount
      
    _autoPilot: ->
      angle = @_calculateAngleTwardsTarget()
      
      if Math.abs(angle) < 5 
        @fireMainThrusters() unless @isCannonOn()
        @turnLeftThrustersOff()
        @turnRightThrustersOff()
      else if angle < 0
        @fireRightThrusters()
        @turnLeftThrustersOff()
        @fireMainThrusters() unless @isCannonOn()
      else
        @fireLeftThrusters()
        @turnRightThrustersOff()
        @fireMainThrusters() unless @isCannonOn()

    _calculateAngleTwardsTarget: ->
      position = @body.GetPosition()
      pointDirection = new B2D.Vec2(@autoPilotTarget.x - position.x, @autoPilotTarget.y - position.y)
      pointDirection.Normalize()
      
      direction = @_getDirectionVector()

      angle = Math.atan2(pointDirection.x, pointDirection.y) - Math.atan2(direction.x, direction.y)
      angle = MathHelpers.r2d angle        
      angle = MathHelpers.adjustAngle angle

      angle

    _thrustersOn: (type)->
      @thrusters[type] == 'on'

    _mainThrustersAction: ->
      direction = @_getDirectionVector()
      direction.Multiply(@speed)
      @body.ApplyForce(direction, @body.GetWorldPoint(new B2D.Vec2(0,0)))

    _leftThrustersAction: ->
      @body.ApplyTorque -@angularSpeed

    _rightThrustersACtion: ->
      @body.ApplyTorque @angularSpeed

    _getDirectionVector: ->
      angle = @body.GetAngle()
      direction = VectorHelpers.createDirectionVector angle

      direction