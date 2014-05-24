define ->
  class FpsKeeper
    constructor: ->
      @marks = {}

    getFrameTime: ->
      time = (new Date).getTime()
      frameTime = if @lastTime? 
        (time - @lastTime)/1000
      else
        1/60
      @lastTime = time

      frameTime

    setMark: (name) ->
      @marks[name] = new Date()

    getTimeSinceMark: (name) ->
      unless @marks[name]?
        throw "no mark #{name} have been defined"

      now = new Date()
      now - @marks[name]