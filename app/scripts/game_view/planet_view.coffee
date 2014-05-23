define ['conversions', 'view', 'earth_graphics_points'], (Conversions, View, earthGraphicsPoints)  ->
  class PlanetView extends View
    constructor: (stage, camera, @planet) ->
      super stage, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()

      graphics.beginFill(0x75baef)

      graphics.drawCircle(0,0, @planet.getRadius())
      graphics.endFill()

      @_drawContinents graphics

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@planet.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    _drawContinents: (graphics)->
      continentsGraphics = new PIXI.Graphics()

      continentsGraphics.beginFill 0x00AA00

      @_drawPoints continentsGraphics, earthGraphicsPoints

      continentsGraphics.endFill()

      continentsGraphics.scale = new PIXI.Point 1/21, 1/21
      continentsGraphics.position = new PIXI.Point -8,-84
      graphics.addChild continentsGraphics

    _drawPoints: (graphics, points) ->
      for blob in points
        first = true
        for point in blob
          if first
            graphics.moveTo point[0], point[1]
            first = false
          else
            graphics.lineTo point[0], point[1]
