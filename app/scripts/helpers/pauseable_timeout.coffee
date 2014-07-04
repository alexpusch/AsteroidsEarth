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
      console.log "pausing at #{now.getTime()}. remaningTime: #{@remainingTimeout}"
      clearTimeout @handler

    resume: ->
      console.log "resuming at #{new Date().getTime()}"
      @start()