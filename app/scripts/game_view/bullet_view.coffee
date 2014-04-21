define ['conversions', 'view'], (Conversions, View)  ->
  class BulletView extends View
    constructor: (stage, camera, @bullet) ->
      super stage, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()

      graphics.beginFill(0xFF3300)
      graphics.lineStyle(0, 0xffd900, 1)

      graphics.drawCircle(0,0, @bullet.getRadius())
      graphics.endFill()

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@bullet.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()