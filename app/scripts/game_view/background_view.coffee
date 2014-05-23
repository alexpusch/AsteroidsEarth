define ['view'], (View) ->
  class Background extends View
    constructor: (stage) ->
      super stage
      @options = 
        numberOfStarts: 50
        starRadiusRange:
          min: 3
          max: 5
        # http://en.wikipedia.org/wiki/Star_polygon
        starP: 7
        starQ: 3

    createGraphics: ->
      graphics = new PIXI.Graphics()
      numberOfStart = 50
      for i in [0...numberOfStart]
        randomPosition = @_getRandomPosition()
        @_drawRandomStar graphics, randomPosition

      graphics

    _getRandomPosition: ->
      x = _.random 0, @stage.getWidth()
      y = _.random 0, @stage.getHeight()

      new PIXI.Point x,y

    _drawRandomStar: (graphics, position) ->
      angle0 = Math.PI * Math.random()
      radius = _.random(@options.starRadiusRange.min,@options.starRadiusRange.max)

      @_drawStar(graphics, position, angle0, radius)

    _drawStar: (graphics, position, angle0, radius) ->
      graphics.beginFill 0xFFFFFF
      graphics.moveTo position.x, (position.y + radius)
    
      skipAngle = 2 * Math.PI / @options.starP
      for i in [0..@options.starP]
        currentAngle = skipAngle * @options.starQ * i + angle0
        point = @_getPointInAngle currentAngle, radius, position
        
        graphics.lineTo point.x, point.y

      graphics.endFill()

    _getPointInAngle: (angle, radius, center) ->
      x = radius * Math.cos(angle) + center.x
      y = radius * Math.sin(angle) + center.y

      new PIXI.Point x, y