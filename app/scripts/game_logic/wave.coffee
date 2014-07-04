define ['events', 'pauseable_timeout'], (Events, PauseableTimeout)->
  class Wave
    constructor: (@wavePlan)->
      @events = new Events()
      @activeAstroids = @wavePlan.length

    start: ->
      @continueWave(0)

    continueWave: (waveIndex)->
      if(waveIndex == @wavePlan.length)
        return

      astroidPlan = @wavePlan[waveIndex]

      @waveTimeoutHandler = PauseableTimeout.setTimeout =>
        @_spwanAstroid astroidPlan
        @continueWave(waveIndex + 1)
      , astroidPlan.offset

    pause: ->
      @waveTimeoutHandler.pause()

    resume: ->
      @waveTimeoutHandler.resume()

    destroy: ->
      PauseableTimeout.clear @waveTimeoutHandler

    _spwanAstroid: (astroidPlan)->
      console.log "spwaning astroid"
      options =
          radius: astroidPlan.radius
          position: astroidPlan.position
          density: astroidPlan.density

      astroid = window.EntityFactory.createAstroid options

      @events.trigger "newAstroid", astroid

      astroid.on 'destroy', =>
        @activeAstroids--
        if @activeAstroids == 0
          @events.trigger 'waveDestroyed'