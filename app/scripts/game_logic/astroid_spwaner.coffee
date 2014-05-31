define ['typed_object', 'planet', 'wave', 'events'], (TypedObject, Planet, Wave, Events) ->
  class AstroidSpwaner extends TypedObject
    constructor: (options) ->
      super "astroidSpwaner"
      @width = options.width
      @height = options.height
      @waveIndex = 0
      @events = new Events()

      @options = 
        sizeRange:
          min: 4
          max: 6
        timeOffsetRange:
          min: 600
          max: 2000

    startSpwaning: ->
      @startNextWave(0)

    startNextWave: (waveIndex) ->
      wavePlan = @generageWavePlan(waveIndex)
      console.log "wave plan #{waveIndex}"
      console.log #{wavePlan}
      @events.trigger "newWave", waveIndex
      @currentWave = new Wave wavePlan

      @currentWave.events.on "newAstroid", (astroid) =>
        @events.trigger "newAstroid", astroid

      @waveDestroyedCallback = =>
        @waveIndex++

        @startNextWave(@waveIndex)

      @currentWave.events.on 'waveDestroyed', @waveDestroyedCallback

      @currentWave.start()

    generageWavePlan: (waveIndex)->
      @currentWaveCount = Math.floor(Math.pow((waveIndex + 1), 1.2))
      wavePlan = []
      for i in [0..@currentWaveCount]
        wavePlan.push @_generageRandomAstroidPlan() 

      wavePlan 

    getWaveNumber: ->
      @waveIndex

    destroy: ->
      @currentWave.events.off "waveDestroyed", @waveDestroyedCallback
      @currentWave.destroy()
      
    _generageRandomAstroidPlan: ->
      radius = _.random @options.sizeRange.min, @options.sizeRange.max
      position = @_getRandomPosition radius
      offset = _.random @options.timeOffsetRange.min, @options.timeOffsetRange.max
      
      astroidPlan = 
        radius: radius
        position: position
        offset: offset

    _getRandomPosition: (astroidRadius) ->
      side = _.random 3, 4
      
      randomY = _.random -@height/2, @height/2
      randomX = _.random -@width/2, @width/2

      offset = 0.1
      switch side
        # top
        when 1 
          x: randomX
          y: -@height/2 -astroidRadius + offset
        # bottom
        when 2
          x: randomX
          y: @height/2 + astroidRadius - offset
        # left
        when 3 
          x: -@width/2 - astroidRadius + offset
          y: randomY
        # right
        when 4 
          x: @width/2 + astroidRadius - offset
          y: randomY

