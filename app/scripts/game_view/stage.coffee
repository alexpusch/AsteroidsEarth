define ->
  class Stage
    constructor: (container)->
      @stage = new PIXI.Stage(0xFFFFFF, true) 
      @stage.setInteractive(true)

      @width = container.width()
      @height = container.height()

      @pixiRenderer = PIXI.autoDetectRenderer(@width, @height)
      container.append(@pixiRenderer.view)

    getPixiStage: ->
      @stage

    getPixiRenderer: ->
      @pixiRenderer

    render: ->
      @pixiRenderer.render(@stage)

    clear: ->
      while @stage.children.length > 0
        @stage.removeChild @stage.children[0]

    getWidth: ->
      @width

    getHeight: ->
      @height