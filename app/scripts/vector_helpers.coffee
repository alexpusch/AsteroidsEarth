define ['box2d'], (B2D) ->
  
  class VectorHelpers
    @createDirectionVector: (angle) ->
      rotationMatrix = B2D.Mat22.FromAngle angle
      v = new B2D.Vec2 1, 0
      v.MulM rotationMatrix

      v