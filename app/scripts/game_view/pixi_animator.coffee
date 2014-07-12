define ->
  class PIXIAnimator
    constructor: (@graphics)->

    fadeIn: (done, start, duration) ->
      now = new Date()
      alpha = (now - start)/duration
      @graphics.alpha = alpha
      if @graphics.alpha < 1
        requestAnimFrame =>
          @fadeIn(done, start, duration)
      else
        @graphics.alpha = 1
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

    grow: (done, start, duration, options) ->
      from = @graphics.scale.x
      to = options.by * @graphics.scale.x
      @_grow done, start, duration, from, to

    _grow: (done, start, duration, from, to) ->
      now = new Date()
      ratio = (now - start)/duration
      scale = from + (to - from) * ratio
      @graphics.scale.x = scale
      @graphics.scale.y = scale

      if(scale < to)
        requestAnimFrame =>
          @_grow done, start, duration, from, to
      else
        @graphics.scale.x = to
        @graphics.scale.y = to
        done()

    animateParallel: (animationPlan) ->
      animationFunctions = @_createFunctions animationPlan

      promise = new Promise (resolve, reject) ->
        async.parallel animationFunctions, ->
          resolve()

      promise

    animate: (animationPlan) ->
      animationFunctions = @_createFunctions animationPlan

      promise = new Promise (resolve, reject) ->
        async.series animationFunctions, ->
          resolve()

      promise

    _createFunctions: (animationPlan) ->
      animationFunctions = []
      for animation in animationPlan
        func = do =>
          currentAnimation = @[animation.type]
          currentDuration = animation.duration
          options = _(animation).clone()
          (done) =>
            animationStart = new Date()
            currentAnimation.call(@, done, animationStart, currentDuration, options)

        animationFunctions.push func

      animationFunctions