define ['events', 'pauseable_timeout'], (Events, PauseableTimeout)->
  class Wave
    constructor: (@wavePlan)->
      @events = new Events()
      @activeAsteroids = @wavePlan.length

    start: ->
      @continueWave(0)

    continueWave: (waveIndex)->
      if(waveIndex == @wavePlan.length)
        return

      asteroidPlan = @wavePlan[waveIndex]

      @waveTimeoutHandler = PauseableTimeout.setTimeout =>
        @_spwanAsteroid asteroidPlan
        @continueWave(waveIndex + 1)
      , asteroidPlan.offset

    pause: ->
      @waveTimeoutHandler.pause()

    resume: ->
      @waveTimeoutHandler.resume()

    destroy: ->
      @waveTimeoutHandler.clear()

    _spwanAsteroid: (asteroidPlan)->
      options =
          radius: asteroidPlan.radius
          position: asteroidPlan.position
          density: asteroidPlan.density

      asteroid = window.EntityFactory.createAsteroid options

      @events.trigger "newAsteroid", asteroid

      asteroid.on 'destroy', =>
        @activeAsteroids--
        if @activeAsteroids == 0
          @events.trigger 'waveDestroyed'