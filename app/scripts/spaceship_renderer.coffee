define ['conversions'], (Conversions) ->
  class SpaceshipRenderer
    constructor: (@stage, @camera, @spaceship) ->
      @graphics = new PIXI.Graphics()
      @_createGraphics()
      @stage.addChild(@graphics)

    render: () ->
      vec2Position = @camera.project(@spaceship.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()
      @graphics.rotation = @spaceship.getAngle()


    _createGraphics: ->
      vertices = @spaceship.getVertices()
      @graphics.beginFill(0xFF3300)
      @graphics.lineStyle(0, 0xffd900, 1)

      @graphics.moveTo(vertices[0].x,vertices[0].y)
      @graphics.lineTo(vertices[1].x,vertices[1].y)
      @graphics.lineTo(vertices[2].x,vertices[2].y)
      @graphics.lineTo(vertices[0].x,vertices[0].y)

      @graphics.endFill()