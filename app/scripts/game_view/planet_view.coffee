define ['conversions', 'view'], (Conversions, View)  ->
  class PlanetView extends View
    constructor: (stage, camera, @planet) ->
      super stage, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()

      graphics.beginFill(0x75baef)

      graphics.drawCircle(0,0, @planet.getRadius())
      graphics.endFill()

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@planet.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()