define ['stopwatch'], (Stopwatch) ->
  class View
    constructor: (@stage, @camera) ->
      @pixiStage = @stage.getPixiStage()
      @stopwatch = new Stopwatch()

    render: ->
      unless @graphics?
        @graphics = @createGraphics()
        @pixiStage.addChild(@graphics)
      @updateGraphics?()

    destroy: ->
      @pixiStage.removeChild @graphics

    getFrameTime: ->
      @stopwatch.getFrameTime()