define ['view', 'box2d', 'conversions'], (View, B2D, Conversions) ->
  class WaveView extends View
    constructor: (stage, camera, @astroidSpwaner) ->
      super stage, camera
      @animationDirection = 0

      @options =
        showDuration: 1000
        hideDuration: 1000
        stayTime: 1000
        frameRate: 30

      @astroidSpwaner.events.on "newWave", (waveIndex) =>
        @graphics.setText("Wave #{waveIndex + 1}")
        @graphics.alpha = 0

        @animate()
          
    createGraphics: ->
      @graphics = new PIXI.Text "Wave 1",
        font: 'bold 20pt Helvetica'
        fill: "ffffff"
        align: "center"
      @graphics.alpha = 0

      @graphics.anchor = new PIXI.Point 0.5, 0.5
      @graphics.x = @stage.getWidth()/2
      @graphics.y = @stage.getHeight()/2

      @animate()

      @graphics

    updateGraphics: ->
      vec2Position = @camera.project(new B2D.Vec2 0,0)
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition

    animate: ->
      showDelta = 1/(@options.showDuration/@options.frameRate)
      hideDelta = 1/(@options.hideDuration/@options.frameRate)
      stayTime = @options.stayTime
      frameTimeout = 1000/@options.frameRate

      show = (done) =>
        @graphics.alpha += showDelta
        if @graphics.alpha < 1
          setTimeout => 
            show(done)
          , frameTimeout
        else
          done()

      stay = (done) =>
        setTimeout ->
          done()
        , stayTime

      hide = (done) =>
        @graphics.alpha -= hideDelta
        if @graphics.alpha > 0
          setTimeout => 
            hide(done)
          , frameTimeout
        else
          @graphics.alpha = 0
          done()

      async.series [show, stay, hide]

