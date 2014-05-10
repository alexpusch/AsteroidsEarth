define ['view', 'box2d', 'conversions', 'pixi_animator'], (View, B2D, Conversions, Animator) ->
  class WaveView extends View
    constructor: (stage, camera, @astroidSpwaner) ->
      super stage, camera
      @animationDirection = 0

      @options =
        showDuration: 1000
        hideDuration: 1000
        stayDuration: 2000

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


