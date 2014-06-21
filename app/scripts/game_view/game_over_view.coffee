define ['events', 'view', 'pixi_animator', 'pixi_layout'], (Events, View, Animator, PixiLayout) ->
  class GameOverScreen extends View
    constructor: (container, @score)->
      super container

    createGraphics: ->
      graphics = new PIXI.Graphics()

      gameOverText = @_createGameOverText()
      scoreText = @_createScoreText()
      highScoreText = @_createHighScoreText()
      @refreshGraphics = @_createRefreshButton()

      graphics.alpha = 0
      graphics.width = @container.width
      graphics.height = @container.height * 0.8
      graphics.y = @container.height * 0.1

      PixiLayout.order graphics, [
        element: gameOverText
        height: 0.3
      ,
        element: scoreText
        height: 0.2
      ,
        element: highScoreText
        height: 0.1
      ,
        element: @refreshGraphics
        height: 0.4
      ]

      graphics

    updateGraphics: ->

    onAppearance: ->
        @fadeIn()
        setTimeout =>
          new Animator(@refreshGraphics).animate([
              type: "fadeIn"
              duration: 1000
          ]).then =>
            @refreshGraphics.interactive = true
        , 1000

    fadeIn: ->
      new Animator(@graphics).animate [
        type: "fadeIn",
        duration: 1000
      ]

    _createGameOverText: ->
      new PIXI.Text "GAME OVER",
        fill: "white"
        font: "100px DroidSans"
        align: "center"

    _createScoreText: ->
      new PIXI.Text "SCORE: #{@score.getScore()}",
        fill: "white"
        font: "100px DroidSans"
        align: "center"

    _createHighScoreText: ->
      if @score.getHighScore() == @score.getScore()
        new PIXI.Text "NEW HIGHSCORE!",
          fill: "#ffcc00"
          font: "100px DroidSans bold"
          align: "center"
      else
        new PIXI.Text "HIGHSCORE: #{@score.getHighScore()}",
          fill: "white"
          font: "100px DroidSans bold"
          align: "center"

    _createRefreshButton: ->
      refreshTexture = PIXI.Texture.fromImage("images/refresh.png");
      refreshGraphics = new PIXI.Sprite(refreshTexture);

      refreshGraphics.width = 10
      refreshGraphics.height = 10
      refreshGraphics.buttonMode = true
      refreshGraphics.interactive = false
      refreshGraphics.alpha = 0

      refreshGraphics.click = refreshGraphics.touchstart = =>
        @events.trigger "gameStartClicked"

      refreshGraphics