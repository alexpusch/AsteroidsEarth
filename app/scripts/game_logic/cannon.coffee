define ['vector_helpers', 'box2d'], (VectorHelpers, B2D) ->

  class Cannon
    constructor: (options)->
      _.defaults options,
        bulletSpeed: 30
        cannonHeatRate: 0.01
        cannonCooldownRate: 0.05

      @cannonRate = 200
      @cannonOffset = options.cannonOffset
      @cannonHeatRate = options.cannonHeatRate
      @cannonCooldownRate = options.cannonCooldownRate
      @cannonTemperature = 0  
      @bulletSpeed = options.bulletSpeed

      @speed = new B2D.Vec2 0, 0
      @position = new B2D.Vec2 0, 0
      @angle = 0
      @canJam = true

    setPosition: (position) ->
      @position = position

    setAngle: (angle) ->
      @angle = angle

    setSpeed: (speed) ->
      @speed = speed

    fireCannon: ->
      unless @cannonIntervalHandler?
        @fireBullet()
        @cannonIntervalHandler = setInterval(
          => 
           @fireBullet()
        , @cannonRate)

    turnCannonOff: ->
      clearInterval @cannonIntervalHandler
      @cannonIntervalHandler = null

    fireBullet: ->
      unless @cannonJammed
        @_createBullet()

        if @canJam
          @cannonTemperature += @cannonHeatRate
          @cannonTemperature = Math.min(@cannonTemperature, 1)

          if @cannonTemperature == 1
            @cannonJammed = true

    update: (dt) ->
      if @cannonTemperature > 0
        @cannonTemperature -= @cannonCooldownRate*dt

      if @cannonJammed and @cannonTemperature <= 0
        @cannonJammed = false
        @cannonTemperature = 0

    isCannonOn: ->
      @cannonIntervalHandler?

    isCannonJammed: ->
      @cannonJammed

    getCannonTemperature: ->
      @cannonTemperature

    destroy: ->
      @turnCannonOff()

    _createBullet: ->
      transformCannonOffest = @cannonOffset.Copy()
      transformCannonOffest = VectorHelpers.rotate transformCannonOffest, @angle
      transformCannonOffest.Add(@position)
      cannonSpeed = @speed

      bulletSpeed = @_getDirectionVector()
      bulletSpeed.Multiply(@bulletSpeed)
      bulletSpeed.Add(cannonSpeed)
      bullet = EntityFactory.createBullet()
      bullet.setAngle @angle
      bullet.setPosition transformCannonOffest
      bullet.setSpeed(bulletSpeed)

    _getDirectionVector: ->
      angle = @angle
      direction = VectorHelpers.createDirectionVector angle

      direction