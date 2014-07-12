define ->
  class PauseableTimeout
    constructor: (@callback, @remainingTimeout) ->

    start: ->
      handler = setTimeout @callback, @remainingTimeout
      @handler = handler
      @timeAtStart = new Date()

    @setTimeout: (callback, timeout) ->
      pauseableHandler = new PauseableTimeout callback, timeout
      pauseableHandler.start()

      pauseableHandler

    clear: ->
      clearTimeout @handler

    pause: ->
      now = new Date()
      @remainingTimeout = @remainingTimeout - (now - @timeAtStart)
      clearTimeout @handler

    resume: ->
      @start()