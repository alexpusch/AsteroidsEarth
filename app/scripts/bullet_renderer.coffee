define ->
  class BulletRenderer
    constructor: (@stage, @bullet) ->
      @graphics = new PIXI.Graphics()

      @graphics.beginFill(0xFF3300)
      @graphics.lineStyle(1, 0xffd900, 1)

      @graphics.drawCircle(0,0, @bullet.getRadius())
      @graphics.endFill()
      @stage.addChild(@graphics)

    render: () ->
      b2dPosition = @bullet.getPosition()
      pixiPosition = new PIXI.Point b2dPosition.x, b2dPosition.y
      @graphics.position = pixiPosition

      