define ['view'], (View) ->
  class Background extends View
    constructor: (stage, camera) ->
      super stage, camera
      @options = 
        numberOfStarts: 50
        starRadiusRange:
          min: (3/8) * camera.getZoom()
          max: (5/8) * camera.getZoom()
        startPoints: 5
        starRatio: 0.4

    createGraphics: ->
      graphics = new PIXI.Graphics()
      numberOfStart = 50
      for i in [0...numberOfStart]
        randomPosition = @_getRandomPosition()
        @_drawRandomStar graphics, randomPosition

      graphics

    onAppearance: ->
      @sound = createjs.Sound.play "background"
      window.sound = @sound

    onDestroy: ->
      @sound.stop()

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

      point = @_getPointInAngle angle0, radius, position
      graphics.moveTo point.x, point.y
    
      skipAngle = Math.PI / @options.startPoints
      for i in [1..(@options.startPoints * 2)]
        currentAngle = skipAngle * i + angle0
        currentRadius = if (i % 2 == 0) then radius else (radius * @options.starRatio)
        point = @_getPointInAngle currentAngle, currentRadius, position
        
        graphics.lineTo point.x, point.y

      graphics.endFill()

    _getPointInAngle: (angle, radius, center) ->
      x = radius * Math.cos(angle) + center.x
      y = radius * Math.sin(angle) + center.y

      new PIXI.Point x, y