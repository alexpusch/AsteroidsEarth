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
      offset = _.random 1000, 3000
      
      astroidPlan = 
        radius: radius
        position: position
        offset: offset

    _getRandomPosition: (astroidRadius) ->
      side = _.random 1, 4
      
      randomX = _.random 0, @height
      randomY = _.random 0, @width

      offset = 0.1
      switch side
        # top
        when 1 
          x:randomX
          y: -astroidRadius + offset
        # bottom
        when 2
          x: randomX
          y: @height + astroidRadius - offset
        # left
        when 3 
          x: - astroidRadius + offset
          y: randomY
        # right
        when 4 
          x: @width + astroidRadius - offset
          y: randomX