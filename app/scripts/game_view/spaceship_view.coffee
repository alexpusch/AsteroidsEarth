define ['conversions', 'view'], (Conversions, View) ->
  class SpaceshipView extends View
    constructor: (stage, camera, @spaceship) ->
      super stage, camera
      
      @temperatureGraphicsOptions =
        numberOfTicks : 40
        height : 20
        width : 200
        borderWidth: 4
        ticksPadding: 2
        borderColor:
          nominal: 0xAAAAAA
          jammaed: 0xEE0000

    createGraphics: ->
      graphics = new PIXI.Graphics()

      @spaceshipGraphics = @_createSpaceshipGraphics()
      @cannonTemperatureGraphics = @_createCannonTemperatureGraphics()
      @distanceMeterGraphics = @_createOutOfWorldIndicatorGraphics()
      graphics.addChild @spaceshipGraphics
      graphics.addChild @cannonTemperatureGraphics
      graphics.addChild @distanceMeterGraphics
      graphics

    updateGraphics: ->
      if @spaceship.isOutOfWOrld()
        @_updateOutOfWorldGraphics()
      else
        @_updateInWorldGraphics()

      @_updateCannonTemperatureGraphics()

    _createSpaceshipGraphics: ->
      graphics = new PIXI.Graphics()
      @_drawSpaceshipGraphics graphics      

      graphics

    _drawSpaceshipGraphics: (graphics) ->
      vertices = @spaceship.getVertices()
      graphics.beginFill(0xFF3300)
      graphics.lineStyle(0, 0xffd900, 1)

      graphics.moveTo(vertices[0].x,vertices[0].y)
      graphics.lineTo(vertices[1].x,vertices[1].y)
      graphics.lineTo(vertices[2].x,vertices[2].y)
      graphics.lineTo(vertices[0].x,vertices[0].y)

      graphics.endFill()

      color = @_getSpeedIndicatorColor()
      graphics.beginFill(color)
      graphics.lineStyle(0, 0xffd900, 1)

      t = 0.9

      vertice01 = @_getAveragePoint vertices[0], vertices[1], t
      vertice21 = @_getAveragePoint vertices[2], vertices[1], t

      graphics.moveTo(vertices[0].x,vertices[0].y)
      graphics.lineTo(vertice01.x, vertice01.y)
      graphics.lineTo(vertice21.x, vertice21.y)
      graphics.lineTo(vertices[2].x,vertices[2].y)
      graphics.lineTo(vertices[0].x,vertices[0].y)

      graphics.endFill()
    
    _getSpeedIndicatorColor: ->
      slowColor = 
        red: 255
        green: 51
        blue: 0

      fastColor = 
        red: 255
        green: 235
        blue: 235

      speed = @spaceship.getSpeed()

      maxSpeed = 35
      r = 1 - speed/maxSpeed

      engineColor = 
        red: @_linearAverage slowColor.red, fastColor.red, r
        green: @_linearAverage slowColor.green, fastColor.green, r
        blue: @_linearAverage slowColor.blue, fastColor.blue, r

      color = @_getRgb(engineColor.red, engineColor.green, engineColor.blue)

    _getAveragePoint: (vertice1, vertice2, t) ->
      new PIXI.Point(@_linearAverage(vertice1.x, vertice2.x, t), @_linearAverage(vertice1.y, vertice2.y, t))

    _linearAverage: (num1, num2, t) ->
      num1 * t + num2 * (1 - t)

    _createCannonTemperatureGraphics: ->
      graphics = new PIXI.Graphics()
      @borderGraphics = @_createBoderGraphics()

      graphics.addChild @borderGraphics

      @ticksContainer = new PIXI.Graphics()
      graphics.addChild @ticksContainer

      graphics.position.x = @stage.getWidth()/2 - @temperatureGraphicsOptions.width/2
      graphics.position.y = @stage.getHeight() - @temperatureGraphicsOptions.height - 30
      graphics

    _createBoderGraphics: ->
      graphics = new PIXI.Graphics()
      @_drawBorderGraphics graphics, @temperatureGraphicsOptions.borderColor.nominal
      graphics

    _drawBorderGraphics: (graphics, color) ->
      graphics.lineStyle @temperatureGraphicsOptions.borderWidth, color, 0.5
      graphics.drawRect 0,0, @temperatureGraphicsOptions.width, @temperatureGraphicsOptions.height

    _updateCannonTemperatureGraphics: ->
      @borderGraphics.clear()
      @_drawBorderGraphics @borderGraphics, @_getBorderColor()

      @ticksContainer.clear()
      @_drawTicks()
        
    _getBorderColor: ->
      if @spaceship.isCannonJammed()
        @temperatureGraphicsOptions.borderColor.jammaed
      else
        @temperatureGraphicsOptions.borderColor.nominal

    _drawTicks: ->
      temperature = @spaceship.getCannonTemperature()
      for i in [0..(@temperatureGraphicsOptions.numberOfTicks - 1)]
        color = @_calculateTickColor i, temperature
        tickWidth = (@temperatureGraphicsOptions.width - @temperatureGraphicsOptions.borderWidth*2)/@temperatureGraphicsOptions.numberOfTicks
        @_drawTick i, color, tickWidth, @temperatureGraphicsOptions.height

    _drawTick: (i, color, width, height) ->
      borderWidth = @temperatureGraphicsOptions.borderWidth
      ticksPadding = @temperatureGraphicsOptions.ticksPadding
      tickFillHeight = height - borderWidth*2

      @ticksContainer.beginFill(color, 0.5)
      @ticksContainer.lineStyle @temperatureGraphicsOptions.ticksPadding, 0xffffff, 1
      @ticksContainer.drawRect(borderWidth + i*width, borderWidth, width, tickFillHeight)
      @ticksContainer.endFill()

    _calculateTickColor: (tickIndex, temperature) ->
      tickTempDiff = 1/@temperatureGraphicsOptions.numberOfTicks
      
      if tickIndex * tickTempDiff > temperature
        return 0xffffff

      blue = 0

      t = (tickIndex/@temperatureGraphicsOptions.numberOfTicks)
      red = 255 * t
      green = 255 * (1 - t)

      @_getRgb(red, green, blue)

    _getRgb: (red, green, blue) ->
      shiftedRed = red << 16
      shiftedGreen = green << 8

      color = blue + shiftedGreen + shiftedRed      
      color

    _createOutOfWorldIndicatorGraphics: ->
      graphics = new PIXI.Text "0",
        font: '10pt Helvetica'
        fill: "555555"
        align: 'center'

      graphics.anchor = new PIXI.Point 0.5,0.5
      graphics.alpha = 0.5
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
