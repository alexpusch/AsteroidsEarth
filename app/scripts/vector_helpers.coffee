class window.VectorHelpers
  @createDirectionVector: (angle) ->
    rotationMatrix = Box2D.Common.Math.b2Mat22.FromAngle angle
    v = new Box2D.Common.Math.b2Vec2 1, 0
    v.MulM rotationMatrix

    v