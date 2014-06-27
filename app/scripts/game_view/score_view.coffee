define ['view'], (View) ->
  class ScoreView extends View
    constructor: (container, @score) ->
      super container

    createGraphics: ->
      size = @container.height/6
      scoreText = new PIXI.Text @score.getScore(),
        fill: "white"
        font: "#{size}px DroidSans"
        align: "center"

      scoreText.alpha = 0.6
      scoreText.position.x = 10
      scoreText.position.y = @container.height
      scoreText.anchor = new PIXI.Point 0, 1
      scoreText

    updateGraphics: ->
      @graphics.setText @score.getScore()

