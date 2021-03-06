define ['view', 'conversions', 'pixi_animator'], (View, Conversions, Animator) ->
  class PowerupView extends View
    constructor: (container, camera, @powerup) ->
      super container, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()
      
      speedTexture = PIXI.Texture.fromImage(@image);
      speedGraphics = new PIXI.Sprite(speedTexture);
      speedGraphics.width = @powerup.getRadius() * 2 
      speedGraphics.height = @powerup.getRadius() * 2

      speedGraphics.position.x = -@powerup.getRadius()
      speedGraphics.position.y = -@powerup.getRadius()

      graphics.addChild speedGraphics

      @powerup.events.on "applied", =>
        @showAppliedAnimation()

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@powerup.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    showAppliedAnimation: ->
      text = new PIXI.Text @text,
        fill: "white"
        font: "20pt DroidSans"
        align: "center"
      text.anchor = new PIXI.Point 0.5,0.5
      text.position = @graphics.position
      @container.addChild text

      promise1 = new Animator(text).animate [
        type: 'fadeOut'
        duration: 500
      ]

      promise1.then =>
        @container.removeChild text

      promise2 = new Animator(@graphics).animate [
        type: 'fadeOut'
        duration: 500
      ]

      @setActivePromise Promise.all [promise1, promise2]
