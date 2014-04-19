define ['conversions'], (Conversions)  ->
  class AstroidRenderer
    constructor: (@stage, @camera, @astroid) ->
      @graphics = new PIXI.Graphics()

      @graphics.beginFill(0xAA1100)
      @graphics.lineStyle(0, 0xffd900, 1)

      @graphics.drawCircle(0,0, @astroid.getRadius())
      @graphics.endFill()
      @stage.addChild(@graphics)

    render: ->
      vec2Position = @camera.project(@astroid.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    destroy: ->
      @stage.removeChild @graphics