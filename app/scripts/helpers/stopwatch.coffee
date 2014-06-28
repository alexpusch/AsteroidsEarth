define ->
  class Stopwatch
    constructor: ->
      @marks = {}

    getFrameTime: ->
      if @paused
        throw new Error("Time is paused. Cannot read frame time")
      now = (new Date).getTime()
      frameTime = if @lastTime?
        (now - @lastTime)/1000
      else
        1/60
      @lastTime = now
      frameTime

    setMark: (name) ->
      @marks[name] = new Date()

    getTimeSinceMark: (name) ->
      unless @marks[name]?
        throw "no mark #{name} have been defined"

      now = new Date()
      now - @marks[name]

    pause: ->
      now = new Date()
      @frameTimeAtPause = now - @lastTime
      @paused = true

    resume: ->
      @paused = false
      now = new Date()
      @lastTime = now - @frameTimeAtPause
