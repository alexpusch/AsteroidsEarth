define ["typed_object"], (TypedObject) ->
  class Score extends TypedObject
    constructor: (options) ->
      super "score"
      @score = 0
      @upInterval = options.upInterval
      @multiplier = 1

    update: (dt) ->
      milisecondsPassed = dt * 1000
      @score += (milisecondsPassed/@upInterval) * @multiplier

    setMultiplier: (multiplier) ->
      @multiplier = multiplier

    getScore: ->
      Math.ceil @score 