define ['conversions', 'view'], (Conversions, View) ->
  class SpaceshipView extends View
    constructor: (stage, camera, @spaceship) ->
      super stage, camera

    createGraphics: ->
      vertices = @spaceship.getVertices()
      graphics = new PIXI.Graphics()
      graphics.beginFill(0xFF3300)
      graphics.lineStyle(0, 0xffd900, 1)

      graphics.moveTo(vertices[0].x,vertices[0].y)
      graphics.lineTo(vertices[1].x,vertices[1].y)
      graphics.lineTo(vertices[2].x,vertices[2].y)
      graphics.lineTo(vertices[0].x,vertices[0].y)

      graphics.endFill()
      graphics

    updateGraphics: () ->
      vec2Position = @camera.project(@spaceship.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()
      @graphics.rotation = @spaceship.getAngle()


