define ['events'], (Events) ->
  class Stage
    constructor: (@options)->
      canvas = @createCanvas()
      containerElement = @options.container
      containerElement.appendChild canvas

      @stage = new PIXI.Stage(0x122a39, true)
      @stage.setInteractive(true)
      @stage.setBackgroundColor 0x122a39

      @width = canvas.width
      @height = canvas.height

      @pixiRenderer = PIXI.autoDetectRenderer(@width, @height, canvas)

      @pixleRatio = window.devicePixelRatio
      @container = new PIXI.DisplayObjectContainer()
      @container.width = @width/@pixleRatio
      @container.height = @height/@pixleRatio
      @container.pivot = new PIXI.Point 0.5, 0.5
      @container.scale = new PIXI.Point @pixleRatio, @pixleRatio
      @stage.addChild @container

      createjs.Sound.initializeDefaultPlugins()
      createjs.Sound.registerPlugins([createjs.CocoonJSAudioPlugin]);

      @events = new Events()

    createCanvas: ->
      canvas = document.createElement "canvas"
      canvas.style.width = @options.width #window.innerWidth
      canvas.style.height = @options.height #window.innerHeight
      canvas.width = @options.width * window.devicePixelRatio
      canvas.height = @options.height * window.devicePixelRatio
      canvas

    startMainLoop: ->
      mainLoop = =>
        unless @paused
          @events.trigger "frame"
          @render()
          requestAnimFrame mainLoop

      mainLoop()

    pause: ->
      @paused = true

    resume: ->
      @paused = false
      @startMainLoop()

    getContainer: ->
      @container

    getPixiRenderer: ->
      @pixiRenderer

    render: ->
      @pixiRenderer.render(@stage)

    clear: ->
      while @container.children.length > 0
        @container.removeChild @container.children[0]

    getWidth: ->
      @container.width

    getHeight: ->
      @container.height