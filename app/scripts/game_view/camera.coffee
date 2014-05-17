define -> 
  class Camera
    constructor:  (@viewportWidth, @viewportHeight) ->
      @zoomMultiplier = 1
      @translation = 
        x: 0
        y: 0

    zoom: (multiplier) ->
      @zoomMultiplier = multiplier

    lookAt: (deltaX, deltaY) ->
      @translation = 
        x: deltaX
        y: deltaY

    project: (point)->
      clone = point.Copy()
      clone.Multiply @zoomMultiplier
      clone.Add(new B2D.Vec2(@translation.x  * @zoomMultiplier, @translation.y * @zoomMultiplier))

      clone.Add(new B2D.Vec2(@viewportWidth/2, @viewportHeight/2))
      clone

    backProject: (point) ->
      clone = point.Copy()
      clone.Add(new B2D.Vec2(- @viewportWidth/2, - @viewportHeight/2))
      clone.Add(new B2D.Vec2(- @translation.x  * @zoomMultiplier, - @translation.y * @zoomMultiplier))
      clone.Multiply 1/@zoomMultiplier

      clone

    getZoom: ->
      @zoomMultiplier

    getTranslation: ->
      @translation