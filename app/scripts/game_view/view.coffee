define ['fps_keeper'], (FpsKeeper) ->
  class View
    constructor: (@stage, @camera) ->
      @pixiStage = @stage.getPixiStage()
      @fpsKeeper = new FpsKeeper()

    render: ->
      unless @graphics?
        @graphics = @createGraphics()
        @pixiStage.addChild(@graphics)
      @updateGraphics?()

    destroy: ->
      @pixiStage.removeChild @graphics

    getFrameTime: ->
      @fpsKeeper.getFrameTime()