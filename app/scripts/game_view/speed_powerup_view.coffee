define ['view', 'conversions', 'pixi_animator'], (View, Conversions, Animator) ->
  class SpeedPowerupView extends View
    constructor: (container, camera, @powerup) ->
      super container, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()
      graphics.beginFill 0x1133ee
      graphics.drawCircle 0,0, @powerup.getRadius()
      graphics.endFill()

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@powerup.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    onDestroy: ->
      new Animator(@graphics).animate [
        type: 'fadeOut'
        duration: 500
      ]
