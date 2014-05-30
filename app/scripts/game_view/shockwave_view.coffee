define ['view'], (View) ->
  class ShockwaveView extends View
    constructor: (stage, camera, @shockWaveOrigin) ->
      super stage, camera
      @radius = 0
      @options = 
        expensionRate: 1000

    createGraphics: ->
      @shockwaveGraphics = new PIXI.Graphics()
      graphics = new PIXI.Graphics()
      graphics.addChild @shockwaveGraphics

      graphics

    updateGraphics: () ->
      dt = @getFrameTime()
      @radius += dt * @options.expensionRate

      viewShockWaveOrigin = @camera.project @shockWaveOrigin

      # mask = new PIXI.Graphics()
      # mask.beginFill(0x999999)
      # mask.drawCircle(viewShockWaveOrigin.x, viewShockWaveOrigin.y, @radius - 20)
      # mask.endFill()

      # @graphics.mask = mask
      @shockwaveGraphics.clear()
      @shockwaveGraphics.beginFill(0xEEEEEE, 0.5)
      @shockwaveGraphics.drawCircle viewShockWaveOrigin.x, viewShockWaveOrigin.y, @radius
      @shockwaveGraphics.endFill()

      # mask.beginFill(0x999999)
      # mask.drawCircle(viewShockWaveOrigin.x, viewShockWaveOrigin.y, @radius - 20)
      # mask.endFill()