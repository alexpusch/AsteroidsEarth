define ['box2d', 'entity', 'vector_helpers'], (B2D, Entity, VectorHelpers) ->
  
  class Spaceship extends Entity
    constructor: (options) ->
      super 'spaceship'
      @speed = options.speed
      @angularSpeed = options.angularSpeed
      @length = options.length
      @width = options.width
      @bulletSpeed = 30
      @cannonOffset = new B2D.Vec2(@length)
      @cannonRate = 200
      
      @cannonHeatRate = options.cannonHeatRate
      @cannonCooldownRate = options.cannonCooldownRate
      @angularDamping = options.angularDamping
      @linearDamping = options.linearDamping

      @thrusters =
        main: 'off'
        left: 'off'
        right: 'off'

      @cannonTemperature = 0  
      @cannonJammed = false;
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

      # fixtureDef.shape.SetAsBox(1, 1)
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

    fireCannon: ->
      unless @cannonIntervalHandler?
        @cannonIntervalHandler = setInterval(
          => 
           @fireBullet()
           console.log "cannon temp: #{@cannonTemperature}"
        , @cannonRate)

    turnCannonOff: ->
      clearInterval @cannonIntervalHandler
      @cannonIntervalHandler = null

    fireBullet: ->
      unless @cannonJammed
        @_createBullet()
        @cannonTemperature += @cannonHeatRate
        @cannonTemperature = Math.min(@cannonTemperature, 1)

        if @cannonTemperature == 1
          @cannonJammed = true

    update: (dt) ->
      if @_thrustersOn 'main'
        @_mainThrustersAction()
      if @_thrustersOn 'left'
        @_leftThrustersAction()
      if @_thrustersOn 'right'
        @_rightThrustersACtion()

      if @cannonTemperature > 0
        @cannonTemperature -= @cannonCooldownRate*dt

      if @cannonJammed and @cannonTemperature <= 0
        @cannonJammed = false
        @cannonTemperature = 0

      window.dt = dt

    getVertices: ->
      @body.GetFixtureList().GetShape().GetVertices()

    isCannonOn: ->
      @cannonIntervalHandler?

    isCannonJammed: ->
      @cannonJammed

    getCannonTemperature: ->
      @cannonTemperature

    destroy: ->
      @turnCannonOff()
    
    handleExitWorld: ->
      @outOfWorld = true

    handleEnterWorld: ->
      @outOfWorld = false

    isOutOfWOrld: ->
      @outOfWorld

    getSpeed: ->
      speedVector = @body.GetLinearVelocity()
      speedVector.Length()

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

    _createBullet: ->
      angle = @getAngle()
      position = @getPosition()
      transformCannonOffest = @cannonOffset.Copy()
      transformCannonOffest = VectorHelpers.rotate transformCannonOffest, angle
      transformCannonOffest.Add(position)
      spaceshipSpeed = @body.GetLinearVelocity()

      bulletSpeed = @_getDirectionVector()
      bulletSpeed.Multiply(@bulletSpeed)
      bulletSpeed.Add(spaceshipSpeed)
      bullet = EntityFactory.createBullet()
      bullet.setAngle angle
      bullet.setPosition transformCannonOffest
      bullet.setSpeed(bulletSpeed)
