define ->
  class CameraShaker
    constructor: (@camera, @options = {}) ->
      _.defaults @options,
        numberOfShakes: 40
        rest: 30
        intensity: 
          min: -1
          max: 1

    shake: () ->
      @_startShaking 0, @camera.getTranslation()

    _startShaking: (i, originalPosition) ->
      unless i == @options.numberOfShakes
        shakeX = @_getRandomShake(i) + originalPosition.x
        shakeY = @_getRandomShake(i) + originalPosition.y
        @camera.lookAt shakeX, shakeY

        setTimeout =>
          @_startShaking(i + 1, originalPosition)
        , @options.rest

    _getRandomShake: (i) ->
      dumpping = 1 - i / @options.numberOfShakes 
      _.random(@options.intensity.min, @options.intensity.max) * dumpping
