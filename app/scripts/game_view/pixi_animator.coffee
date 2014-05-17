define ->
  class PIXIAnimator
    constructor: (@graphics)->
      @frameRate = 60
      @frameTimeout = 1000/@frameRate

    fadeIn: (done, start, duration) ->
      now = new Date()
      alpha = (now - start)/duration
      @graphics.alpha = alpha
      if @graphics.alpha < 1
        requestAnimFrame => 
          @fadeIn(done, start, duration)
      else
        console.log "fade in end"
        done()

    stay: (done, start, duration) ->
      setTimeout ->
        done()
      , duration

    fadeOut: (done, start, duration) ->
      now = new Date()
      alpha = 1 - (now - start)/duration
      @graphics.alpha = alpha
      if @graphics.alpha > 0
        requestAnimFrame => 
          @fadeOut(done, start, duration)
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
            animationStart = new Date()
            currentAnimation.call(@, done, animationStart, currentDuration)

        animationFunctions.push func
      
      promise = new Promise (resolve, reject) ->
        async.series animationFunctions, ->
          resolve()

      promise
