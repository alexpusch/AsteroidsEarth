define ['planet', 'wave'], (Planet, Wave) ->
  class AstroidSpwaner
    constructor: (options) ->
      @width = options.width
      @height = options.height

    startSpwaning: ->
      @startNextWave(0)

    startNextWave: (waveIndex) ->
      wavePlan = @generageWavePlan(waveIndex)
      console.log "wave plan #{waveIndex}"
      console.log #{wavePlan}
      @currentWave = new Wave wavePlan

      @waveDestroyedCallback = =>
        @startNextWave(waveIndex + 1)

      @currentWave.events.on 'waveDestroyed', @waveDestroyedCallback

      @currentWave.start()

    generageWavePlan: (waveIndex)->
      @currentWaveCount = Math.floor(Math.pow((waveIndex + 1), 1.2))
      wavePlan = []
      for i in [0..@currentWaveCount]
        wavePlan.push @_generageRandomAstroidPlan() 

      wavePlan 

    destroy: ->
      @currentWave.events.off "waveDestroyed", @waveDestroyedCallback
      @currentWave.destroy()
      
    _generageRandomAstroidPlan: ->
      radius = _.random 3,5
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