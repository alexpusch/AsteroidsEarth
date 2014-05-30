define ['view'], (View) ->
  class CannonTemperatureView extends View
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

      @cannonTemperatureGraphics = @_createCannonTemperatureGraphics()
      graphics.addChild @cannonTemperatureGraphics

      graphics

    updateGraphics: ->
      @borderGraphics.clear()
      @_drawBorderGraphics @borderGraphics, @_getBorderColor()

      @ticksContainer.clear()
      @_drawTicks()

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
      @ticksContainer.lineStyle @temperatureGraphicsOptions.ticksPadding, 0xAAAAAA, 0.5
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
