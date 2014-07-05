define ['view'], (View) ->
  class CannonTemperatureView extends View
    constructor: (container, camera, @spaceship) ->
      @options =
        numberOfTicks : 40
        height : 20
        width : 200
        borderWidth: 4
        ticksPadding: 2
        borderColor:
          nominal: 0xAAAAAA
          jammaed: 0xEE0000

      super container, camera

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

      graphics.position.x = @container.width - @options.width - @container.width/40
      graphics.position.y = @container.height - @options.height - @container.width/40
      graphics

    _createBoderGraphics: ->
      graphics = new PIXI.Graphics()
      @_drawBorderGraphics graphics, @options.borderColor.nominal
      graphics

    _drawBorderGraphics: (graphics, color) ->
      graphics.lineStyle @options.borderWidth, color, 0.5
      graphics.drawRect 0,0, @options.width, @options.height

    _getBorderColor: ->
      if @spaceship.isCannonJammed()
        @options.borderColor.jammaed
      else
        @options.borderColor.nominal

    _drawTicks: ->
      temperature = @spaceship.getCannonTemperature()
      for i in [0..(@options.numberOfTicks - 1)]
        color = @_calculateTickColor i, temperature
        tickWidth = (@options.width - @options.borderWidth*2)/@options.numberOfTicks
        @_drawTick i, color, tickWidth, @options.height

    _drawTick: (i, color, width, height) ->
      borderWidth = @options.borderWidth
      ticksPadding = @options.ticksPadding
      tickFillHeight = height - borderWidth*2

      @ticksContainer.beginFill(color, 0.5)
      @ticksContainer.lineStyle @options.ticksPadding, 0xAAAAAA, 0.5
      @ticksContainer.drawRect(borderWidth + i*width, borderWidth, width, tickFillHeight)
      @ticksContainer.endFill()

    _calculateTickColor: (tickIndex, temperature) ->
      tickTempDiff = 1/@options.numberOfTicks

      if tickIndex * tickTempDiff > temperature
        return 0xffffff

      blue = 0

      t = (tickIndex/@options.numberOfTicks)
      red = 255 * t
      green = 255 * (1 - t)

      @_getRgb(red, green, blue)

    _getRgb: (red, green, blue) ->
      shiftedRed = red << 16
      shiftedGreen = green << 8

      color = blue + shiftedGreen + shiftedRed
      color
