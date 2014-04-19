define ['conversions'], (Conversions)  ->
  class BulletRenderer
    constructor: (@stage, @camera, @bullet) ->
      @graphics = new PIXI.Graphics()

      @graphics.beginFill(0xFF3300)
      @graphics.lineStyle(0, 0xffd900, 1)

      @graphics.drawCircle(0,0, @bullet.getRadius())
      @graphics.endFill()
      @stage.addChild(@graphics)

    render: ->
      vec2Position = @camera.project(@bullet.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    destroy: ->
      @stage.removeChild @graphics