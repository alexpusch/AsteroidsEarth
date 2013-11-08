define ['box2d', 'entity', 'vector_helpers'], (B2D, Entity, VectorHelpers) ->
  
  class Spaceship extends Entity
    constructor: (options) ->
      @speed = options.speed
      @angularSpeed = options.angularSpeed
      @length = 8
      @cannonOffset = new B2D.Vec2(@length + 1)
      @thrusters =
        main: 'off'
        left: 'off'
        right: 'off'

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
      fixtureDef.shape.SetAsArray [ 
          new B2D.Vec2(0, -3),
          new B2D.Vec2(@length, 0),
          new B2D.Vec2(0, 3)], 3

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

    fireBullet: ->
      angle = @getAngle()
      position = @getPosition()
      transformCannonOffest = @cannonOffset.Copy()
      transformCannonOffest.Add(position)
      spaceshipSpeed = @body.GetLinearVelocity()

      bulletSpeed = spaceshipSpeed.Copy()
      bulletSpeed.Normalize()
      bulletSpeed.Multiply(10000)
      bulletSpeed.Add(spaceshipSpeed)

      bullet = EntityFactory.createBullet()
      bullet.setAngle angle
      bullet.setPosition transformCannonOffest
      bullet.setSpeed(bulletSpeed)

    update: ->
      if @_thrustersOn 'main'
        @_mainThrustersAction()
      if @_thrustersOn 'left'
        @_leftThrustersAction()
      if @_thrustersOn 'right'
        @_rightThrustersACtion()

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