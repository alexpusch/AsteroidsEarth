define -> 
  class Camera
    constructor: ->
      @zoomMultiplier = 1
      @translation = 
        x: 0
        y: 0

    zoom: (multiplier) ->
      @zoomMultiplier = multiplier

    move: (deltaX, deltaY) ->
      @translation = 
        x: deltaX
        y: deltaY

    project: (point)->
      clone = point.Copy()
      clone.Add(new B2D.Vec2(@translation.x, @translation.y))
      clone.Multiply @zoomMultiplier

      clone
