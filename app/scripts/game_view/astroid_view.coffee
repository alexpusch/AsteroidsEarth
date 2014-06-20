define ['conversions', 'view', 'color_helpers'], (Conversions, View, ColorHelpers) ->
  class AstroidView extends View
    constructor: (container, camera, @astroid) ->
      super container, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()

      graphics.beginFill(@getColor())
      # graphics.lineStyle(0, 0xffd900, 1)

      graphics.drawCircle(0,0, @astroid.getRadius())
      graphics.endFill()

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@astroid.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    getColor: ->
      density = @astroid.getDensity()

      lowDensityColor = 0xed8c00
      highDensityColor = 0x520000

      min = 0.3
      max = 3

      t = 1 - (density - min)/(max - min)

      ColorHelpers.colorAverage lowDensityColor, highDensityColor, t