define ->
  class View
    constructor: (@stage, @camera) ->
      @pixiStage = @stage.getPixiStage()
      
    render: ->
      unless @graphics?
        @graphics = @createGraphics()
        @pixiStage.addChild(@graphics)
      @updateGraphics?()

    destroy: ->
      @pixiStage.removeChild @graphics