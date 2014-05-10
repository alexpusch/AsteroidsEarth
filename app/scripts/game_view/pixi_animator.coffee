define ->
  class PIXIAnimator
    constructor: (@graphics)->
      @frameRate = 60
      @frameTimeout = 1000/@frameRate

    fadeIn: (done, duration) ->
      showDelta = 1/(duration/@frameRate)

      @graphics.alpha += showDelta
      if @graphics.alpha < 1
        setTimeout => 
          @fadeIn(done, duration)
        , @frameTimeout
      else
        done()

    stay: (done, duration) ->
      setTimeout ->
        done()
      , duration

    fadeOut: (done, duration) ->
      hideDelta = 1/(duration/@frameRate)
      @graphics.alpha -= hideDelta
      if @graphics.alpha > 0
        setTimeout => 
          @fadeOut(done, duration)
        , @frameTimeout
      else
        @graphics.alpha = 0
        done()
          
    animate: (animationPlan) ->
      animationFunctions = []
      for animation in animationPlan
        func = do =>
          currentAnimation = @[animation.type]
          currentDuration = animation.duration
          (done) => 
            currentAnimation.call(@, done, currentDuration)

        animationFunctions.push func
        
      async.series animationFunctions