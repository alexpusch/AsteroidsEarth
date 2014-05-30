define ->
  class Stage
    constructor: (container)->
      @stage = new PIXI.Stage(0x1b6dab, true) 
      @stage.setInteractive(true)
      @stage.setBackgroundColor 0x1b6dab
      
      @width = container.width
      @height = container.height

      @pixiRenderer = PIXI.autoDetectRenderer(@width, @height, container)

      @pixleRatio = window.devicePixelRatio
      @container = new PIXI.DisplayObjectContainer()
      @container.pivot = new PIXI.Point 0.5, 0.5
      @container.scale = new PIXI.Point @pixleRatio, @pixleRatio
      @stage.addChild @container

    getPixiStage: ->
      @container

    getPixiRenderer: ->
      @pixiRenderer

    render: ->
      @pixiRenderer.render(@stage)

    clear: ->
      while @container.children.length > 0
        @container.removeChild @container.children[0]

    getWidth: ->
      @width / @pixleRatio

    getHeight: ->
      @height / @pixleRatio