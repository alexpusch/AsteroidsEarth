define ->
  class MathHelpers
    @d2r: (degree) ->
      degree * Math.PI / 180

    @r2d: (radians) ->
      radians * 180 / Math.PI

    @adjustAngle: (angle) ->
      if angle > 180
        angle = angle - 360
      else if angle < -180
        angle = angle + 360

      angle

    @average: (a, b, t = 0.5) ->
      a * t + b * (1 - t)

    @random: (from, to) ->
      Math.random() * (to - from) + from
