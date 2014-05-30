define ->
  class CameraShaker
    constructor: (@camera, @options = {}) ->
      _.defaults @options,
        duration: 2000
        intensity: 
          min: -1
          max: 1

    shake: () ->
      now = new Date()
      @_startShaking now, @camera.getTranslation()

    _startShaking: (start, originalPosition) ->
      now = new Date()
      unless (now - start) > @options.duration
        i = (now - start)/@options.duration
        shakeX = @_getRandomShake(i) + originalPosition.x
        shakeY = @_getRandomShake(i) + originalPosition.y
        @camera.lookAt shakeX, shakeY

        requestAnimFrame =>
          @_startShaking(start, originalPosition)

    _getRandomShake: (i) ->
      dumpping = 1 - i
      _.random(@options.intensity.min, @options.intensity.max) * dumpping
