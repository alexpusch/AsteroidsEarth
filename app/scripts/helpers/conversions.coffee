define ['box2d', 'pixi'], (B2D, PIXI) ->
  Conversions =
    B2DtoPIXI:
      toPoint: (vec2) ->
        new PIXI.Point vec2.x, vec2.y
    
    PIXI2Box2D:
      toVec2: (point) ->
        new B2D.Vec2 point.x, point.y