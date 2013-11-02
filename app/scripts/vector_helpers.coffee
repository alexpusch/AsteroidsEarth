define ['box2d'], (box2d) ->
  
  class window.VectorHelpers
    @createDirectionVector: (angle) ->
      rotationMatrix = B2D.Mat22.FromAngle angle
      v = new B2D.Vec2 1, 0
      v.MulM rotationMatrix

      v