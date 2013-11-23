define ['planet'], (Planet) ->
  class AstroidSpwaner
    constructor: (options) ->
      @width = options.width
      @height = options.height
      @planet = options.planet

    startSpwaning: ->
      netSpwan = _.random 2000, 6000
      setTimeout =>
        @spwanAstroid()
        @startSpwaning()
      , netSpwan

    spwanAstroid: ->
      size = _.random 10,20
      position = @_getRandomPosition()
      console.log position
      astroid = window.EntityFactory.createAstroid @planet
      astroid.setPosition position

    _getRandomPosition: ->
      side = _.random 1, 4
      
      randomX = _.random 0, @height
      randomY = _.random 0, @width

      switch side
        when 1 then new B2D.Vec2(randomX, -50)
        when 2 then new B2D.Vec2(randomX, @height + 50)
        when 3 then new B2D.Vec2(-50, randomY)
        when 4 then new B2D.Vec2(@width + 50, randomX)