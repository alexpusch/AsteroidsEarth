define ['view'], (View) ->
  class Background extends View
    constructor: (stage) ->
      super stage

    createGraphics: ->
      graphics = new PIXI.Graphics()
      for i in [0..30]
        randomPosition = @_getRandomPosition()
        @_drawStar graphics, randomPosition

      graphics

    _getRandomPosition: ->
      x = _.random 0, @stage.getWidth()
      y = _.random 0, @stage.getHeight()

      new PIXI.Point x,y

    _drawStar: (graphics, position) ->
      graphics.beginFill "000066"
      graphics.drawCircle position.x, position.y, 2
      graphics.endFill()
