define ->
  class Score
    constructor: (options) ->
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