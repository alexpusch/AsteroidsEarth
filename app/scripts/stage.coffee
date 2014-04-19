define ->
  class Stage
    constructor: (container)->
      @stage = new PIXI.Stage(0xFFFFFF, true) 
      @stage.setInteractive(true)

      @width = container.width()
      @height = container.height()

      @pixiRenderer = PIXI.autoDetectRenderer(@width, @height)
      container.append(@pixiRenderer.view)

    getStage: ->
      @stage

    getRenderer: ->
      @pixiRenderer

    getWidth: ->
      @width

    getHeight: ->
      @height