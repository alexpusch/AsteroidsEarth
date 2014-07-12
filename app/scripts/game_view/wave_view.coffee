define ['view', 'box2d', 'conversions', 'pixi_animator'], (View, B2D, Conversions, Animator) ->
  class WaveView extends View
    constructor: (container, camera, @asteroidSpwaner) ->
      super container, camera
      @animationDirection = 0

      @options =
        showDuration: 1000
        hideDuration: 1000
        stayDuration: 2000

      @newWaveHandler = (waveIndex) =>
        @graphics.setText("WAVE #{waveIndex + 1}")
        @graphics.alpha = 0

        @animate()

      @asteroidSpwaner.events.on "newWave", @newWaveHandler

    createGraphics: ->
      @graphics = new PIXI.Text "WAVE 1",
        font: '30pt DroidSans'
        fill: "white"
        align: "center"
      @graphics.alpha = 0

      @graphics.anchor = new PIXI.Point 0.5, 0.5
      @graphics.x = @container.width/2
      @graphics.y = @container.height/2

      @graphics

    updateGraphics: ->
      vec2Position = @camera.project(new B2D.Vec2 0,0)
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition

    animate: ->
      new Animator(@graphics).animate [
          type: "fadeIn"
          duration: @options.showDuration
        ,
          type: "stay"
          duration: @options.stayDuration
        ,
          type: "fadeOut"
          duration: @options.hideDuration
      ]


    onDestroy: ->
      @asteroidSpwaner.events.off "newWave", @newWaveHandler