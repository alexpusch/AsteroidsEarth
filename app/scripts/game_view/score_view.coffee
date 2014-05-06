define ['view'], (View) ->
  class ScoreView extends View
    constructor: (stage, @score) ->
      super stage

    createGraphics: ->
      scoreText = new PIXI.Text(@score.getScore())
      scoreText.position.x = 50
      scoreText.position.y = 50

      scoreText

    updateGraphics: ->
      @graphics.setText @score.getScore()
      