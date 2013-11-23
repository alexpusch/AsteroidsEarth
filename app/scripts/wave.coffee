define ['events'], (Events)->
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
      setTimeout =>
        @_spwanAstroid astroidPlan
        @continueWave(waveIndex + 1)
      , astroidPlan.offset

    on: (eventName, callback)->
      @events.on eventName, callback

    _spwanAstroid: (astroidPlan)->
      console.log "spwaning astroid"
      options = 
          radius: astroidPlan.radius
          position: astroidPlan.position

      astroid = window.EntityFactory.createAstroid options

      astroid.on 'destroy', =>
        @activeAstroids--
        if @activeAstroids == 0
          @events.trigger 'waveDestroyed'