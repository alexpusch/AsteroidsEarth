define ['typed_object', 'planet', 'wave', 'events', 'math_helpers'], (TypedObject, Planet, Wave, Events, MathHelpers) ->
  class AstroidSpwaner extends TypedObject
    constructor: (options) ->
      super "astroidSpwaner"
      @width = options.width
      @height = options.height
      @waveIndex = 0
      @events = new Events()

      @options = 
        sizeRange:
          min: 3
          max: 4
        timeOffset:
          min: 800
          max: 3000
          range: 1000
          step: 200
        density:
          min: 0.3
          max: 1.5
          step: 0.05
          range: 0.1

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
      @currentWaveCount = 3 + Math.floor(Math.pow((waveIndex + 1), 1.2))
      wavePlan = []
      for i in [0..@currentWaveCount]
        wavePlan.push @_generageRandomAstroidPlan i

      wavePlan 

    getWaveNumber: ->
      @waveIndex

    destroy: ->
      @currentWave.events.off "waveDestroyed", @waveDestroyedCallback
      @currentWave.destroy()
      
    _generageRandomAstroidPlan: (waveIndex) ->
      radius = MathHelpers.random @options.sizeRange.min, @options.sizeRange.max
      position = @_getRandomPosition radius

      densityMin = @options.density.min + @options.density.step * waveIndex
      densityMax = Math.min(densityMin + @options.density.range, @options.density.max)
      density = MathHelpers.random densityMin, densityMax

      offsetMax = @options.timeOffset.max - @options.timeOffset.step * waveIndex
      offsetMin = Math.max(offsetMax - @options.timeOffset.range, @options.timeOffset.min)
      offset = MathHelpers.random offsetMin, offsetMax

      astroidPlan = 
        radius: radius
        position: position
        offset: offset
        density: density

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

