define ->
  class Events
    constructor: ->
      @directory = {}

    on: (eventName, callback) ->
      unless @directory[eventName]?
        @directory[eventName] = []

      callbackList = @directory[eventName]
      callbackList.push callback

    off: (eventName, callback) ->
      unless @directory[eventName]?
        return

      callbackList = @directory[eventName]
      @directory[eventName] = _.without callbackList, callback

    trigger: (eventName, args...) ->
      unless @directory[eventName]?
        return

      callbackList = @directory[eventName]

      _.each callbackList, (callback)->
        callback.apply(this, args)

    clear: ->
      @directory = {}