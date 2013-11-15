define ->
  class SpaceshipRenderer
    constructor: (@stage, @spaceship) ->
      @graphics = new PIXI.Graphics()

      vertices = @spaceship.getVertices()
      console.log vertices
      @graphics.beginFill(0xFF3300)
      @graphics.lineStyle(0, 0xffd900, 1)

      @graphics.moveTo(vertices[0].x,vertices[0].y)
      @graphics.lineTo(vertices[1].x,vertices[1].y)
      @graphics.lineTo(vertices[2].x,vertices[2].y)
      @graphics.lineTo(vertices[0].x,vertices[0].y)

      @graphics.endFill()    
      @stage.addChild(@graphics)

    render: () ->
      b2dPosition = @spaceship.getPosition()
      pixiPosition = new PIXI.Point b2dPosition.x, b2dPosition.y
      @graphics.position = pixiPosition
      @graphics.rotation = @spaceship.getAngle()


      