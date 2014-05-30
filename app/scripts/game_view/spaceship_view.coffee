define ['conversions', 'view', 'box2d', 'cannon_temperature_view'], (Conversions, View, B2D, CannonTemperatureView) ->
  class SpaceshipView extends View
    constructor: (stage, camera, @spaceship) ->
      super stage, camera
      @cannonTemperatureView = new CannonTemperatureView stage, camera, @spaceship

    createGraphics: ->
      graphics = new PIXI.Graphics()
      graphics.addChild @cannonTemperatureView.createGraphics()

      @spaceshipGraphics = @_createSpaceshipGraphics()
      @distanceMeterGraphics = @_createOutOfWorldIndicatorGraphics()
      graphics.addChild @spaceshipGraphics
      graphics.addChild @distanceMeterGraphics
      graphics

    updateGraphics: ->
      @cannonTemperatureView.updateGraphics()

      if @spaceship.isOutOfWOrld()
        @_updateOutOfWorldGraphics()
      else
        @_updateInWorldGraphics()

    _createSpaceshipGraphics: ->
      graphics = new PIXI.Graphics()
      @_drawSpaceshipGraphics graphics      

      graphics

    _drawSpaceshipGraphics: (graphics) ->
      vertices = @spaceship.getVertices()
      graphics.beginFill(0xf3f3f3)
      
      engineHight = 0.8
      engineWidth = 0.75

      vertice01 = @_getAveragePoint vertices[0], vertices[1], engineHight
      vertice21 = @_getAveragePoint vertices[2], vertices[1], engineHight
      
      vertice3 = @_getAveragePoint vertice01, vertice21, engineWidth
      vertice4 = @_getAveragePoint vertice01, vertice21, (1-engineWidth)

      n = vertices[0].Copy()
      n.Add(vertices[2].GetNegative())
      n.Normalize()
      vertice5 = @_findMirrorPoint vertice4, n, vertices[0]
      vertice6 = @_findMirrorPoint vertice3, n, vertices[0]

      graphics.moveTo(vertices[0].x,vertices[0].y)
      graphics.lineTo(vertices[1].x,vertices[1].y)
      graphics.lineTo(vertices[2].x,vertices[2].y)
      graphics.lineTo(vertice4.x, vertice4.y)
      graphics.lineTo(vertice3.x, vertice3.y)
      graphics.lineTo(vertices[0].x,vertices[0].y)

      graphics.endFill()

      alpha = @_getSpeedIndicatorAlpha()
      color = 0x6ef8f7
      graphics.beginFill(color, alpha)

      graphics.moveTo(vertices[0].x,vertices[0].y)
      graphics.lineTo(vertice3.x, vertice3.y)
      graphics.lineTo(vertice4.x, vertice4.y)
      graphics.lineTo(vertices[2].x,vertices[2].y)

      graphics.lineTo(vertice5.x, vertice5.y)
      graphics.lineTo(vertice6.x, vertice6.y)

      graphics.lineTo(vertices[0].x,vertices[0].y)

      graphics.endFill()
    
    _findMirrorPoint: (x1, n, x0) ->
      # http://mathworld.wolfram.com/Reflection.html
      z = x1.Copy()
      z.Add(x0.GetNegative())
      dot = z.x * n.x + z.y * n.y

      n2dot = n.Copy()
      n2dot.Multiply(2*dot)
      
      x02 = x0.Copy()
      x02.Multiply(2)

      xr = x02.Copy()
      xr.Add(n2dot)
      xr.Multiply(0.75)
      mirror = x1.Copy().GetNegative()
      mirror.Add(xr)

      mirror

    _getSpeedIndicatorAlpha: ->
      speed = @spaceship.getSpeed()

      maxSpeed = 35
      r = speed/maxSpeed

      r

    _getAveragePoint: (vertice1, vertice2, t) ->
      new B2D.Vec2(@_linearAverage(vertice1.x, vertice2.x, t), @_linearAverage(vertice1.y, vertice2.y, t))

    _linearAverage: (num1, num2, t) ->
      num1 * t + num2 * (1 - t)

    _createOutOfWorldIndicatorGraphics: ->
      graphics = new PIXI.Text "0",
        font: "10pt Helvetica"
        fill: "EEEEEE"
        align: "center"

      graphics.anchor = new PIXI.Point 0.5,0.5
      graphics.alpha = 0.8
      graphics

    _updateInWorldGraphics: ->
      vec2Position = @camera.project(@spaceship.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @spaceshipGraphics.clear()
      @_drawSpaceshipGraphics @spaceshipGraphics

      @distanceMeterGraphics.visible = false
      @spaceshipGraphics.position = pixiPosition
      @spaceshipGraphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()
      @spaceshipGraphics.rotation = @spaceship.getAngle()

    _updateOutOfWorldGraphics: ->
      vec2Position = @camera.project(@spaceship.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position

      distance = @_getDistanceFromEdge pixiPosition
      spaceshipIndicatorPosition = @_calculateIndicatorPosition pixiPosition

      indicatorScale = 2

      @spaceshipGraphics.position = spaceshipIndicatorPosition
      @spaceshipGraphics.scale = new PIXI.Point @camera.getZoom()/indicatorScale ,@camera.getZoom()/indicatorScale
      @spaceshipGraphics.rotation = @spaceship.getAngle()

      distanceMeterPosition = @_calculateDistanceMeterPosition pixiPosition, spaceshipIndicatorPosition
      
      @distanceMeterGraphics.visible = true
      @distanceMeterGraphics.setText(distance)
      @distanceMeterGraphics.position = distanceMeterPosition

    _getDistanceFromEdge: (position) ->
      distance = 0

      if position.y < 0
        distance = -position.y
      else if position.y > @stage.getHeight()
        distance = position.y - @stage.getHeight()
      if position.x < 0
        distance = -position.x
      else if position.x > @stage.getWidth()
        distance = position.x - @stage.getWidth()

      Math.ceil distance

    _calculateIndicatorPosition: (position) ->
      indicatorPosition = position.clone()

      if position.y < 0
        indicatorPosition.y = 10
      else if position.y > @stage.getHeight()
        indicatorPosition.y = @stage.getHeight() - 10
      if position.x < 0
        indicatorPosition.x = 10
      else if position.x > @stage.getWidth()
        indicatorPosition.x = @stage.getWidth() - 10

      indicatorPosition

    _calculateDistanceMeterPosition: (pixiPosition, spaceshipIndicatorPosition) ->
      spaceshipBounds = @spaceshipGraphics.getLocalBounds()
      spaceshipGraphicsWidth = spaceshipBounds.width/ @spaceshipGraphics.scale.x
      distanceMeterOffset = 0

      if pixiPosition.y < 0
        distanceMeterOffset = spaceshipBounds.width + 5
      else if pixiPosition.y > @stage.getHeight()
        distanceMeterOffset = spaceshipBounds.width + 5
      if pixiPosition.x < 0
        distanceMeterOffset = spaceshipGraphicsWidth + 5 + @distanceMeterGraphics.width/2
      else if pixiPosition.x > @stage.getWidth()
        distanceMeterOffset = -(spaceshipGraphicsWidth + 5 + @distanceMeterGraphics.width/2)

      distanceMeterPosition = spaceshipIndicatorPosition.clone()
      distanceMeterPosition.x += distanceMeterOffset

      distanceMeterPosition

