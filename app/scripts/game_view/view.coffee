define ['stopwatch', 'events'], (Stopwatch, Events) ->
  class View
    constructor: (@container, @camera) ->
      @container = @container
      @stopwatch = new Stopwatch()
      @graphics = @createGraphics()

      @addedToContainer = false
      @events = new Events

    render: ->
      unless @addedToContainer
        @addedToContainer = true
        @container.addChild(@graphics)
        @onAppearance?()
      @updateGraphics?()

    destroy: ->
      @onDestroy?()
      @container.removeChild @graphics

    getFrameTime: ->
      @stopwatch.getFrameTime()

    pushToTop: ->
      @container.removeChild(@graphics)
      @container.addChild(@graphics)