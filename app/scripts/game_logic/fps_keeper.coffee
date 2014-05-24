define ->
  class FpsKeeper
    getFrameTime: ->
      time = (new Date).getTime()
      frameTime = if @lastTime? 
        (time - @lastTime)/1000
      else
        1/60
      @lastTime = time

      frameTime