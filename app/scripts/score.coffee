define ["typed_object"], (TypedObject) ->
  class Score extends TypedObject
    constructor: (options) ->
      super "score"
      @score = 0
      @upInterval = options.upInterval

    start: ->
      @intervalHandler = setInterval =>
        @score += 1
      , @upInterval

    getScore: ->
      @score 

    stop: ->
      clearInterval @intervalHandler